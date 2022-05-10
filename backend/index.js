require('dotenv').config()
const express = require('express')
const app = express()
const cors = require('cors')
const user = require('./routes/users/user');
const gameStats = require('./routes/games/stats')
const homePage = require('./routes/games/home')
const rooms = require('./routes/rooms/rooms')
const likes = require('./routes/users/likes')
const moment = require('moment')
const search = require('./routes/games/search')

app.use(express.json())
app.use(express.urlencoded({extended: false}))
app.use(cors())

app.use((req, res, next) => {
  console.log(req.url, moment().format('LTS'))
  next()
})

app.use('/user', user)
app.use('/games/stats', gameStats)
app.use('/rooms', rooms)
app.use('/likes', likes)
app.use('/home', homePage)
app.use('/search', search)

app.listen(process.env.PORT || 3000, () => {
  console.log(`Listining to port ${process.env.PORT || 3000}`);
});