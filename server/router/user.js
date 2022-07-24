const express = require('express');
const userRouter = express.Router();
const auth = require('../middleware/auth');
const { Product } = require('../model/product');
const User = require('../model/user');

// add product
userRouter.post("/api/add-to-cart", admin, async (req, res) => {
  try 
  {
    const {id} = req.body;
    const product = await Product.findById(id);
    let user = User.findById(req.user);
    if(user.cart.length == 0) 
    {
        user.cart.push({product, quantity:1});
    }else
    {
        let isProductFound = false;
        for(let i = 0; i < user.cart.length; i++)
        {
            if(user.cart[i].product._id.equals(product._id))
            {
                isProductFound = true;
            }
        }

        if(isProductFound)
        {
            let foundedProd = user.cart.find((prod)=>prod.product._id.equals(product._id));
            foundedProd.quantity += 1;
        }else
        {
            user.cart.push({product, quantity:1});
        }
        user = await user.save();
        res.json(user);
    }
  } catch (e) 
  {
    
  }
});
module.exports = userRouter;

