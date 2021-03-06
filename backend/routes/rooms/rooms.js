const express = require('express')
const router = express.Router()
const mysql = require('mysql')
const auth = require('../users/auth')

const pool = mysql.createPool({
  connectionLimit: 5,
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_DATABASE
})

const query = (...args) => {
  return new Promise((resolve, reject) => {
    pool.query(...args, (err, ...res) => {
      if(err) return reject(err)
      resolve(...res)
    })
  })
}

router.use(auth)

// Creates a room
// {title, capacity, appid}
// Requires authentication
router.post('/create', async (req, res) => {
  // Extract data from request body
  const title = req.body.title ?? ''
  const capacity = req.body.capacity ?? 5
  const appid = req.body.appid
  const owner = req.body.id

  // Check if game id was provided
  if(appid === undefined){
    return res.status(400).json({msg: "Appid was not specified"})
  }

  // Check if capacity is greater than 1
  if(Number.isNaN(capacity) || !Number.isInteger(capacity) || capacity < 2){
    return res.status(400).json({msg: "Room capactiy must be an integer bigger than 1"})
  }
  
  // Check if game exists in DB
  const game = await query('SELECT `appid` FROM `steam` WHERE `appid` = ?', [appid])
  if(!game.length){
    return res.status(400).json({msg: "Bad appid"})
  }

  // Create the room
  const room = await query('INSERT INTO `rooms` VALUES (0, ?, ?, ?, ?, DEFAULT)', [owner, title, appid, capacity])

  // Add owner to the room
  await query('INSERT INTO `user_in_room` VALUES (?, ?)', [room.insertId, owner])
  res.status(201).json({id: room.insertId})
})

// Deletes a room
// Requires authentication
router.delete('/delete/:id', async (req, res) => {
  // Extract data from request body/parameters
  const id = req.params.id
  const owner = req.body.id

  // Grab the room owner and check if he's the one deleting the room
  const [room] = await query('SELECT `owner` FROM `rooms` WHERE `id` = ?', [id])
  if(room === undefined){  // Room doesn't exist
    return res.status(400).json({msg: "Invalid room id"})
  }
  if(room.owner !== owner){      // Room owner doesn't match
    return res.status(403).json({msg: "Permission denied"})
  }

  // Delete the room
  await query('DELETE FROM `rooms` WHERE `id` = ?', [id])
  res.status(200).json({msg: "Room was deleted"})
})

// Leaves a room
// Requires authentication
router.delete('/leave/:id', async (req, res) => {
  // Extract data from request body/parameters
  const id = req.params.id
  const user = req.body.id

  // Grab the room owner and check if he's the one leaving
  const [room] = await query('SELECT `owner` FROM `rooms` WHERE `id` = ?', [id])
  if(room === undefined){  // Room doesn't exist
    return res.status(400).json({msg: "Invalid room id"})
  }
  if(room.owner === id){      // The one leaving is the owner
    return res.status(403).json({msg: "Owners can only delete rooms"})
  }

  // Check if user is inside the room
  const [userInRoom] = await query('SELECT `user_id` FROM `user_in_room` WHERE `room_id` = ? AND `user_id` = ?', [id, user])
  if(userInRoom === undefined){
    return res.status(400).json({msg: "User is not in the room"})
  }

  // Remove the user from the room and decrement the room current user count
  await query('DELETE FROM `user_in_room` WHERE `room_id` = ? AND `user_id` = ?', [id, user])
  await query('UPDATE `rooms` SET `current_count` = `current_count` - 1 WHERE `id` = ?', [id])
  res.status(200).json({msg: "User was removed from the room"})
})

// Adds user to a room
// {username}
// Requires authentication
router.put('/add/:id', async (req, res) => {
  // Extract data from the request body
  const id = req.params.id
  const username = req.body.username
  const owner = req.body.id

  // Check if user id was given
  if(username === undefined){
    return res.status(400).json({msg: "Username was not given"})
  }

  // Check if the room exists and room owner is correct
  if(!(await roomAndOwnerValidation(id, owner, res))){
    return
  }

  // Check if username exists
  const [user] = await query('SELECT `id` FROM `user` WHERE `username` = ?', [username])
  if(user === undefined){
    return res.status(400).json({msg: "User was not found"})
  }

  // Check if user was not added previously to the room
  const [userInRoom] = await query('SELECT `user_id` FROM `user_in_room` WHERE `room_id` = ? AND `user_id` = ?', [id, user.id])
  if(userInRoom !== undefined){
    return res.status(403).json({msg: "User already exists in the room"})
  }

  // Check if room capacity is not full
  const [fullRoom] = await query('SELECT `id` FROM `rooms` WHERE `id` = ? AND `capacity` = `current_count`', [id])
  if(fullRoom !== undefined){
    return res.status(403).json({msg: "Room is full"})
  }

  // Add user to the room and increment the room current user count
  await query('INSERT INTO `user_in_room` VALUES (?, ?)', [id, user.id])
  await query('UPDATE `rooms` SET `current_count` = `current_count` + 1 WHERE `id` = ?', [id])
  res.status(200).json({msg: "User added to the room"})
})

// Removes user from a room
// {username}
// Requires authentication
router.put('/remove/:id', async (req, res) => {
  // Extract data from the request body
  const id = req.params.id
  const username = req.body.username
  const owner = req.body.id

  // Check if user id was given
  if(username === undefined){
    return res.status(400).json({msg: "Username was not given"})
  }

  // Check if the room exists and room owner is correct
  if(!(await roomAndOwnerValidation(id, owner, res))){
    return
  }

  // Check if username exists
  const [user] = await query('SELECT `id` FROM `user` WHERE `username` = ?', [username])
  if(user === undefined){
    return res.status(400).json({msg: "User was not found"})
  }

  // Check if user is inside the room
  const [userInRoom] = await query('SELECT `user_id` FROM `user_in_room` WHERE `room_id` = ? AND `user_id` = ?', [id, user.id])
  if(userInRoom === undefined){
    return res.status(400).json({msg: "User is not in the room"})
  }

  // Remove the user from the room and decrement the room current user count
  await query('DELETE FROM `user_in_room` WHERE `room_id` = ? AND `user_id` = ?', [id, user.id])
  await query('UPDATE `rooms` SET `current_count` = `current_count` - 1 WHERE `id` = ?', [id])
  res.status(200).json({msg: "User was removed from the room"})
})

// Show all the rooms the user belongs to
// Requires authentication
router.get('/show', async (req, res) => {
  // Extract the user ID from the request
  const user = req.body.id

  // Grab all rooms the user belongs to
  const rooms = await query('SELECT `rooms`.* FROM `user_in_room` INNER JOIN `rooms` ON `room_id` = `id` WHERE `user_id` = ?', [user])
  if(rooms.length == 0){  // User is not in any rooms
    return res.status(404).json({msg: "No rooms found"})
  }

  // Return the rooms
  res.status(200).json(rooms)
})

// Show all the users in specific room
// Requires authentication
router.get('/show/:id', async (req, res) => {
  // Extract the data from request body
  const id = req.params.id
  const user = req.body.id

  // Check if the room exists
  const [room] = await query('SELECT * FROM `rooms` WHERE `id` = ?', [id])
  if(room === undefined){
    return res.status(400).json({msg: "Room doesn't exist"})
  }

  // Check if the user belongs to the specified room
  const [userInRoom] = await query('SELECT * FROM `user_in_room` WHERE `room_id` = ? AND `user_id` = ?', [id, user])
  if(userInRoom === undefined){
    return res.status(403).json({msg: "You don't belong to this room"})
  }

  // Grab all the users from that room
  const users = await query('SELECT `user`.`id`, `user`.`userName` FROM `user_in_room` INNER JOIN `user` ON `user_in_room`.`user_id` = `user`.`id` WHERE `user_in_room`.`room_id` = ?', [id])
  res.status(200).json(users)
})

// Room validation and owner validation
const roomAndOwnerValidation = async (id, owner, res) => {
  const [room] = await query('SELECT `owner` FROM `rooms` WHERE `id` = ?', [id])
  if(room === undefined){  // Room doesn't exist
    res.status(400).json({msg: "Invalid room id"})
    return false
  }
  if(room.owner !== owner){      // Room owner doesn't match
    res.status(403).json({msg: "Permission denied"})
    return false
  }
  return true
}

module.exports = router