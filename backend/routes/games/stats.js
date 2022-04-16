const express = require('express')
const router = express.Router();
const mysql = require('mysql')

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

router.get('/year', async (req, res) => {
  try{
    // Get games/year from DB
    const data = await query('SELECT COUNT(appid) as "games", YEAR(`release_date`) as "year" FROM `steam` GROUP BY YEAR(`release_date`)')
    res.status(200).json(data)
  }
  catch(err){
    res.status(500).json({msg: "Something went wrong"})
  }
})

router.get('/categories', async (req, res) => {
  try{
    const allData = await query('SELECT `appid`, `categories` FROM `steam`')
    let obj = {}
    allData.forEach((category, i) => {
      const splitCat = category.categories.split(';')
      splitCat.forEach((cat) => {
        obj[cat] = obj[cat] ? obj[cat] + 1 : 1
      })
    });
    console.log(obj);
    res.json(obj)
  }
  catch(err){
    console.log(err);
  }
})

router.get('/genres', async (req, res) => {
  try{
    // const allData = await query('SELECT `appid`, `genres` FROM `steam`')
    // const allGenres = await query('SELECT * FROM `genres`')
    // let genres = {}
    // allGenres.forEach(gen => {
    //   genres[gen.title] = gen.id
    // })

    // allData.forEach((game) => {
    //   const splitGenres = game.genres.split(';')
    //   splitGenres.forEach(async (genre) => {
    //     await query('INSERT INTO `game_includes_genre` VALUES (?, ?)', [game.appid, genres[genre]])
    //   })
    // });

    // console.log("DONE");

    const genres = await query('SELECT * FROM `genres`')
    res.status(200).json(genres)
  }
  catch(err){
    console.log(err);
  }
})

router.get('/genres/top', async (req, res) => {
  try{
    // Top 5 genres 
    const topGenres = await query('SELECT `game_includes_genre`.`genre` AS "id", `genres`.`title`, COUNT(`game_includes_genre`.`appid`) AS "games" FROM `game_includes_genre` INNER JOIN `genres` ON `game_includes_genre`.`genre` = `genres`.`id` GROUP BY `game_includes_genre`.`genre` ORDER BY `games` DESC LIMIT 5')
    res.status(200).json(topGenres)
  }
  catch(err){
    console.log(err);
  }
})

module.exports = router