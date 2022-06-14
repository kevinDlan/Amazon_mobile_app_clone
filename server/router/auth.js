const express = require("express");
const mongoose = require("mongoose");
const User = require("../model/user");
const bcryptjs = require('bcryptjs');
const link  = require('./mongoose-link');
const jwt = require('jsonwebtoken');
  

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
   const user = await User.findOne({email},{_id:1,email:1,password:1, type:1})
   console.log(user)
   if(!user)
   {
        return res.status(400).json({mgs : `User with this ${email} does not exist`})
   }
   const isGoodPwd = await bcryptjs.compare(password, user.password);
   if(!isGoodPwd)
   {
        return res.status(400).json({mgs : "Please enter a correct password"})
   }

   token = await jwt.sign({id:user._id},"passwordKey");
   return res.status(200).json({token, ...user._doc})

 }catch(e)
 {
    res.status(500).json({msg:e.message})
 }
})

module.exports = authRouter;
