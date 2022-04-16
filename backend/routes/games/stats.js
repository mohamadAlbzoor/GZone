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
        if(cat === "Stat"){
          console.log(allData[i]);
        }
        obj[cat] = obj[cat] ? obj[cat] + 1 : 1
      })
    });
    console.log(obj);
    res.json({})
  }
  catch(err){
    console.log(err);
  }
})

module.exports = router