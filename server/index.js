//Create API Endpoint
const express  = require('express')
const PORT = 3000

//import other route from file
const authRouter = require('./router/auth')

// create a port
const app = express()

//middleware
app.use(express.json())
app.use(authRouter)

app.listen(PORT,'0.0.0.0',()=>
{ 
   console.log(`Connected successfully to port : ${PORT}`);
})



