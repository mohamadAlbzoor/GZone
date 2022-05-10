const express = require('express')
const router = express.Router();
const mysql = require('mysql')
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

// Gets first 10 games with liked flag
router.get('/', async (req, res) => {
  const user = req.body.id
  const games = await query('SELECT *, CASE WHEN `x`.`user_id` IS NULL THEN "false" ELSE "true" END AS liked FROM (SELECT `steam`.*, `likes`.`user_id` FROM `steam` LEFT JOIN `likes` ON `likes`.`appid` = `steam`.`appid` AND `likes`.`user_id` = ? LIMIT 1) AS x ORDER BY `x`.`appid` ASC', [user])
  res.status(200).json(games)
})

// Gets first X games
router.get('/:count', async (req, res) => {
  const user = req.body.id
  const count = parseInt(req.params.count)
  const games = await query('SELECT *, CASE WHEN `x`.`user_id` IS NULL THEN "false" ELSE "true" END AS liked FROM (SELECT `steam`.*, `likes`.`user_id` FROM `steam` LEFT JOIN `likes` ON `likes`.`appid` = `steam`.`appid` AND `likes`.`user_id` = ? GROUP BY `steam`.`appid` LIMIT ?) AS x ORDER BY `x`.`appid` ASC', [user, count])
  res.status(200).json(games)
})
module.exports = router