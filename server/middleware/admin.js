  const jwt = require("jsonwebtoken");
const User = require("../model/user");

// Creating admin middleware
  const admin = async (req, res, next) =>
  {
  try 
  {
    const token = req.header("x-auth-token");
    if (!token)
      return res.status(401).json({ msg: "No acces token, Access denied" });
    const verified = jwt.verify(token, "passwordKey");
    if (!verified)
      return res
        .status(401)
        .json({ msg: "Token verification failed, Access denied" });
    const user = await User.findById(verified.id);
    if(user.type === "user" || user.type === "seller")
    {
      return res.status(401).json({msg:"You are not an admin"});
    }
    req.user = verified.id;
    req.token = token;
    next();
  } catch (error) 
  {
    res.status(500).json({ msg: error.message });
  }
  }

  module.exports = admin;