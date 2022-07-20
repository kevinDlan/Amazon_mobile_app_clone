const express = require("express");
const auth = require("../middleware/auth");
const { Product } = require("../model/product");
const productRouter = express.Router();

// get products for one category
// /api/product?category=female => req.query.category
// /api/product:category=female => req.params.category
productRouter.get("/api/products", async(req,res)=>
{
    try
    {
      const products = await Product.find({category:req.query.category});
      res.status(200).json(products)
    }catch(e)
    {
      res.status(500).json({msg:e.message});
    }
});




module.exports = productRouter