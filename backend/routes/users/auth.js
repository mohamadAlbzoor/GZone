const express = require('express')
const router = express.Router();
const jwt = require('jsonwebtoken')

router.get('/', (req, res) => {
  // Extract the token from the authorization header
  const authBearer = req.headers['authorization']
  if(!authBearer){
    return res.status(401).json({msg: 'Access denied'})
  }
  const token = authBearer.split(' ')[1]

  try{
    // Verify the token
    const auth = jwt.verify(token, process.env.ACCESS_TOKEN)

    // Authorized the user
    res.status(200).json({msg: "OK"})
  }
  catch(err){
    // Forbid invalid tokens
    return res.status(401).json({msg: 'Access denied'})
  }
})

module.exports = router;