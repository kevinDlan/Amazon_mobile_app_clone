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

// get search product
productRouter.get("/api/products/search/:searchQuery", async(req, res)=>
{
  try
  {
    const products = await Product.find({
      name:{$regex: req.params.searchQuery, $options:"i"}
    });
    res.json(products);
  }catch(e)
  {
    res.status(500).json({msg:e.message})
  }
} );

// rating

productRouter.post("/api/rate-product",auth ,async (req, res)=>
{
  try{
    const {id, rating} = req.body;
    let product = await Product.findById(id);
    for(let i = 0; i < product.ratings.length; i++)
    {
        if(product.ratings[i].userId == req.user)
        {
          product.ratings.splice(i, 1);
          break;
        }
    }
    
    const ratingSchema = 
    {
      userId : req.user,
      rating : rating
    }

    product.ratings.push(ratingSchema);
    console.log(product);
    product = await product.save();
    res.json(product);
  }catch(e)
  {
    res.status(500).json({error: e.message})
  }
});

productRouter.get("/api/deal-of-day", auth, async(req, res)=>
{
  try

  {
    let products =  await Product.find({});

    products = products.sort((fProd, sProd)=>{
      fProdRatingSum = 0;
      sProdRatingSum = 0;

      for(let i = 0; i < fProd.ratings.length; i++)
      {
          fProdRatingSum += fProd.ratings[i].rating;
      }

      for(let i = 0; i < sProd.ratings.length; i++)
      {
          sProdRatingSum += sProd.ratings[i].rating;
      }

      return fProdRatingSum < sProdRatingSum ? 1 : -1 ;

    });

    res.json(products[0]);

  }catch(e)
  {
    console.log(e.message);
    res.status(500).json({error: e.message});
  }

});





module.exports = productRouter