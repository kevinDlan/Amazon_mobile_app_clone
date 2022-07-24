//Create API Endpoint
const express  = require('express');
const PORT = 3000
//import other route from file
const authRouter = require('./router/auth');
const adminRouter = require('./router/admin');
const productRouter = require('./router/product');
const userRouter = require('./router/user');

// create a port
const app = express();

//middleware
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

app.get('/api/gretting', (req,res)=>{
   res.send('Welcome to my API main endpoint.');
})
app.get('/api/test', (req, res)=>{
   res.json({message : 'Welcome to sandbox'})
})
app.listen(PORT,'192.168.1.115',()=>
{ 
   console.log(`Connected successfully to port : ${PORT}`);
})



