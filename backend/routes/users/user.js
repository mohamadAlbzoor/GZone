require('dotenv').config()
const express = require('express');
const mysql = require('mysql')
const router = express.Router();
const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken')
const moment = require('moment')

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

// Sign up route
router.post('/signUp', async (req, res) => {
  try{
    // Extract data from the request body
    const username = req.body.username
    const email = req.body.email
    const password = req.body.password
    const repeatPassword = req.body.repeatPassword

    // Validate email address
    if(!email.match(/^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/)){
      return res.status(400).json({msg: 'Invalid email address'})
    }

    // Validate matching passwords
    if(password !== repeatPassword){
      return res.status(400).json({msg: 'Passwords do not match'})
    }

    // Validate if email does not exist previously
    const dbEmail = await query('SELECT `email` from `user` WHERE `email` = ?', [email])
    if(dbEmail.length){
      return res.status(403).json({msg: 'Email already exists'})
    }

    // Validate if user does not exist previously
    const dbUser = await query('SELECT `userName` from `user` WHERE `userName` = ?', [username])
    if(dbUser.length){
      return res.status(403).json({msg: 'User already exists'})
    }

    // Hash the password
    const hashedPassowrd = await bcrypt.hash(password, 10)

    // Create the user
    const success = await query(('INSERT INTO `user` VALUES (0, ?, ?, ?, "")'), [email, username, hashedPassowrd])

    // Get the user ID
    const id = success.insertId

    // Return the token
    const token = jwt.sign({id}, process.env.ACCESS_TOKEN)
    res.status(201).json({token})

  }
  catch(err){
    console.log(err);
  }
})

// Login route
router.post('/login', async (req, res) => {
  try{
    // Extract data from the request body
    const email = req.body.email
    const password = req.body.password

    // Fetch the user from the database
    const [dbUser] = await query('SELECT `id`, `email`, `password` from `user` WHERE `email` = ?', [email])
    if(dbUser === undefined){
      return res.status(403).json({msg: 'Invalid credentials'})
    }

    // Validate if password is correct
    if(!(await bcrypt.compare(password, dbUser.password))){
      return res.status(403).json({msg: 'Invalid credentials'})
    }

    // Get the user id
    const id = dbUser.id

    // Return the token
    const token = jwt.sign({id}, process.env.ACCESS_TOKEN)
    res.status(201).json({token})
  }
  catch(err){
    console.log(err);
  }
})

module.exports = router;