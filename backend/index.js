require('dotenv').config()
const express = require('express');
const app = express();
const authRouter = require('./routes/users/auth');
const user = require('./routes/users/user');
const gameStats = require('./routes/games/stats')

app.use(express.json())
app.use(express.urlencoded({extended: false}))

app.use('/auth', authRouter)
app.use('/user', user)
app.use('/games/stats', gameStats)

app.listen(process.env.PORT || 3000, () => {
  console.log(`Listining to port ${process.env.PORT || 3000}`);
});