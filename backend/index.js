require('dotenv').config()
const express = require('express')
const app = express()
const cors = require('cors')
const user = require('./routes/users/user');
const gameStats = require('./routes/games/stats')
const rooms = require('./routes/rooms/rooms')
const likes = require('./routes/users/likes')

app.use(express.json())
app.use(express.urlencoded({extended: false}))
app.use(cors())
app.use('/user', user)
app.use('/games/stats', gameStats)
app.use('/rooms', rooms)
app.use('/likes', likes)

app.listen(process.env.PORT || 3000, () => {
  console.log(`Listining to port ${process.env.PORT || 3000}`);
});