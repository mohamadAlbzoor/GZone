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

router.get('/:result',async(req,res,next)=>{
  const parameter = '%'+req.params.result+'%';
  try{
    result =  await query('SELECT * from `steam` WHERE `name` LIKE ?', [parameter]);
  }
  catch(err){
    throw err;
  }
  if(result.length==0)res.status(404).json({msg:'no results'});
  else res.status(200).json({result});
});
module.exports = router