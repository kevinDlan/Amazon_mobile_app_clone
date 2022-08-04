const express = require("express");
const userRouter = express.Router();
const auth = require("../middleware/auth");
const Order = require("../model/order");
const { Product } = require("../model/product");
const User = require("../model/user");

// add product
userRouter.post("/api/add-to-cart", auth, async (req, res) => {
  try {
    const { id } = req.body;
    const product = await Product.findById(id);
    let user = await User.findById(req.user);

    if (user.cart.length == 0) {
      user.cart.push({ product, quantity: 1 });
    } else {
      let isProductFound = false;
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.equals(product._id)) {
          isProductFound = true;
        }
      }

      if (isProductFound) {
        let foundedProd = user.cart.find((prod) =>
          prod.product._id.equals(product._id)
        );
        foundedProd.quantity += 1;
      } else {
        user.cart.push({ product, quantity: 1 });
      }
    }
    user = await user.save();
    console.log("object");
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

// remove from cart
userRouter.delete("/api/remove-from-cart/:id", auth, async (req, res) => {
try
{
  const { id } = req.params;
  const product = await Product.findById(id);
  let user = await User.findById(req.user);

  for (let i = 0; i < user.cart.length; i += 1) {
    if (user.cart[i].product._id.equals(product._id)) {
        if(user.cart[i].quantity == 1)
        {
            user.cart.splice(i, 1);
        }
        else{
            user.cart[i].quantity -= 1;
        }
    }
  }
  user = await user.save();
  res.json(user);
}catch(e)
{
    res.status(500).json({error : e.message});
}
});

// save user address
userRouter.post("/api/save-user-address", auth , async (req,res)=>
{
  try
  {
      const address = req.body;
      let user = await User.findById(req.user);
      user.address = address;
      user = await user.save();
      res.json(user)
  }catch(error)
  {
    res.status(500).json({error:e.message});
  }
});

// order product
userRouter.post("/api/order", auth , async (req,res)=>
{
  try
  {
      const {cart, totalPrice, address} = req.body;
      let products = [];
      for(let i = 0; i < cart.length; i++)
      {
        let product = await Product.findById(cart[i].product._id);
        if(product.quantity >= cart[i].quantity)
        {
          product.quantity -= cart[i].quantity;
          products.push({product,quantity:cart[i].quantity});
          product.save();
        }else
        {
          res.status(400).json({msg:`${product.name} is out of stock!`});
        }
      }
      let user = await User.findById(req.user);
      user.cart = [];{

      }

      let order = new Order({
       products,
       totalPrice,
       address,
       userId:req.user,
       orderAt:new Date().getTime(),
      });
      order = await order.save();
      res.status(200).json(order);
  }catch(error)
  {
    res.status(500).json({error:e.message});
  }
});

//get user orders product
userRouter.get('/api/user-orders', auth, async(req, res)=>
{
  try{
    const orders =  await Order.find({userId:req.user});
    res.json(orders);
  }catch(e)
  {
    res.status(500).json({error: e.message});
  }
})

module.exports = userRouter;
