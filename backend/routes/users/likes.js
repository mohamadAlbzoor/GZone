const express = require('express');
const mysql = require('mysql')
const router = express.Router();
const auth = require('../users/auth')

const pool = mysql.createPool({
  connectionLimit: 10,
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

// User likes a game
// Requires authentication
router.put('/like/:appid', async (req, res) => {
  try{
    // Extract data from the request body
    const appid = req.params.appid
    const user = req.body.id

    // Check if the game exists
    const [game] = await query('SELECT * FROM `steam` WHERE `appid` = ?', [appid])
    if(game === undefined){
      return res.status(400).json({msg: "Game doesn't exist"})
    }

    // Check if the user already liked the game
    const [alreadyLiked] = await query('SELECT * FROM `likes` WHERE `user_id` = ? AND `appid` = ?', [user, appid])
    if(alreadyLiked !== undefined){
      return res.status(403).json({msg: "User already like the game"})
    }

    // Like the game
    await query('INSERT INTO `likes` VALUES (?, ?)', [user, appid])
    res.status(200).json({msg: "Game added to the liked list"})
  }
  catch(err){
    console.log(err);
  }
})

// User dislikes a game
// Requires authentication
router.put('/dislike/:appid', async (req, res) => {
  try{
    // Extract data from the request body
    const appid = req.params.appid
    const user = req.body.id

    // Check if the game exists
    const [game] = await query('SELECT * FROM `steam` WHERE `appid` = ?', [appid])
    if(game === undefined){
      return res.status(400).json({msg: "Game doesn't exist"})
    }

    // Check if the user has the game on the liked list
    const [alreadyLiked] = await query('SELECT * FROM `likes` WHERE `user_id` = ? AND `appid` = ?', [user, appid])
    if(alreadyLiked === undefined){
      return res.status(403).json({msg: "User doesn't have the game on the liked list"})
    }

    // dislike the game
    await query('DELETE FROM`likes` WHERE `user_id` = ? AND `appid` = ?', [user, appid])
    res.status(200).json({msg: "Game disliked"})
  }
  catch(err){
    console.log(err);
  }
})

// Shows the user's liked list
// Requires authentication
router.get('/show', async (req, res) => {
  try{
    // Extract the user id from therequest body
    const user = req.body.id

    // return the list of the liked games
    const liked = await query('SELECT `steam`.`appid`, `steam`.`name` FROM `likes` INNER JOIN `steam` ON `likes`.`appid` = `steam`.`appid` WHERE `likes`.`user_id` = ?', [user])
    if(liked.length === 0){
      return res.status(404).json("No games liked found")
    }
    return res.status(200).json(liked)
  }
  catch(err){
    console.log(err);
  }
})

module.exports = router;