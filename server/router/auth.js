const express = require("express");
const mongoose = require("mongoose");
const User = require("../model/user");
const bcryptjs = require('bcryptjs');
const link  = require('./mongoose-link');
const jwt = require('jsonwebtoken');
const auth = require('../middleware/auth');
  

const authRouter = express.Router();

// mongoose db connection
mongoose
  .connect(link)
  .then(() => {
    console.log("Connect successfully.");
  })
  .catch(() => {
    console.log(e);
  });

//signup route
authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password } = req.body;
    const existingUser = await User.findOne({ email });
    if (existingUser) {
      return res
        .status(400)
        .json({ msg: "user with the same email already exist." });
    }
    const hashPassword = await bcryptjs.hash(password, 8)
    let user = new User({ name, email, password : hashPassword });
    user = await user.save();
    res.json(user);
  }catch(e)
  {
    return res.status(500).json({msg:e.message})
  }
});

//signin route
authRouter.post("/api/signin", async(req, res) =>{
 try
 {
   const {email, password} = req.body
   const user = await User.findOne({email})
  //  console.log(user)
   if(!user)
   {
        return res.status(400).json({msg : `User with this ${email} does not exist`})
   }
   const isGoodPwd = await bcryptjs.compare(password, user.password);
   if(!isGoodPwd)
   {
        return res.status(400).json({msg : "Please enter a correct password"});
   }

   token = await jwt.sign({id:user._id},"passwordKey");
   return res.status(200).json({token, ...user._doc});

 }catch(e)
 {
   return  res.status(500).json({msg:e.message})
 }
})

// check user token
authRouter.post("/api/verified/token", async(req, res)=>{
   try
   {
    const token = req.header('x-auth-token');
    if(!token) return res.json(false);
    const verified = jwt.verify(token, 'passwordKey');
    if(!verified) return res.json(false);
    const user = User.findById(verified.id);
    if(!user) return res.json(false);
    res.json(true);
   }catch(e)
   {
     return res.status(500).json({msg:e.message});
   }
})

// get user data
authRouter.get('/api',auth ,async(req, res)=>{
  const user = await User.findById(req.user);
  res.json({...user._doc, token: req.token});
})

module.exports = authRouter;
