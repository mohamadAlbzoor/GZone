const express =require('express');
const app =express();
const router = express.Router();
var mysql = require('mysql');
const pool = mysql.createPool({
  connectionLimit: 10,
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_DATABASE
});

const query = (...args) => {
  return new Promise((resolve, reject) => {
    pool.query(...args, (err, ...res) => {
      if(err) return reject(err)
      resolve(...res)
    })
  })
}

// Searches for a game accord to the title
router.get('/:title', async (req,res) => {
  // Extract the title and add the wild card
  const title = '%' + req.params.title + '%'
  const result = await query('SELECT * from `steam` WHERE `name` LIKE ?', [title])

  // Handle 0 games returned
  if(result.length == 0){
    return res.status(404).json({msg: "No games found"})
  }

  // Return the list of games
  res.status(200).json({result})
});

module.exports = router