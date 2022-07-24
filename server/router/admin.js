const express = require("express");
const adminRouter = express.Router();
const admin = require("../middleware/admin");
const {Product} = require("../model/product");



// add product
adminRouter.post("/api/admin/add-product", admin, async (req, res) => {
  try {
    const { name, description, images, quantity, price, category } = req.body;

    let product = new Product({
      name,
      description,
      images,
      quantity,
      price,
      category,
    });

    product = await product.save();
    res.json(product);

  } catch (e) 
  {
    res.status(500).json({ msg: e.message });
  }
});

// get all products
adminRouter.get("/api/admin/get-products", admin, async(req,res)=>
{
    try
    {
      const products = await Product.find();
      res.status(200).json(products)
    }catch(e)
    {
      res.status(500).json({msg:e.message});
    }
});

// delete a single product

adminRouter.post("/api/admin/delete-product", admin, async(req, res)=>
{
  try
  {
    const {product_id} = req.body;
    let product = await Product.findByIdAndDelete(product_id);
    res.json(product);
  }
  catch(e)
  {
    res.status(500).json({msg:e.message});
  }
})
module.exports = adminRouter;
