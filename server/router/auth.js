const express = require("express");
const mongoose = require("mongoose");
const User = require("../model/user");
const bcryptjs = require('bcryptjs');

const DB =
  "mongodb+srv://kevin:kevinKONE@cluster0.srqjw.mongodb.net/?retryWrites=true&w=majority";

const authRouter = express.Router();

// mongoose db connection
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connect successfully.");
  })
  .catch(() => {
    console.log(e);
  });

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

module.exports = authRouter;
