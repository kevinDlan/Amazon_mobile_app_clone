const express = require("express");
const adminRouter = express.Router();
const admin = require("../middleware/admin");
const { Product } = require("../model/product");
const Order = require("../model/order");

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
  } catch (e) {
    res.status(500).json({ msg: e.message });
  }
});

// get all products
adminRouter.get("/api/admin/get-products", admin, async (req, res) => {
  try {
    const products = await Product.find();
    res.status(200).json(products);
  } catch (e) {
    res.status(500).json({ msg: e.message });
  }
});

// delete a single product

adminRouter.post("/api/admin/delete-product", admin, async (req, res) => {
  try {
    const { product_id } = req.body;
    let product = await Product.findByIdAndDelete(product_id);
    res.json(product);
  } catch (e) {
    res.status(500).json({ msg: e.message });
  }
});

// get all orders
adminRouter.get("/api/admin/get-orders", admin, async (req, res) => {
  try {
    const orders = await Order.find();
    res.json(orders);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
});

//update orders status
adminRouter.post("/api/admin/update-order-status", admin, async (req, res) => {
  try {
    const { id, status } = req.body;
    let order = await Order.findById(id);

    order.status = status;
    order = await order.save();
    res.json(order);
  } catch (e) 
  {
    res.status(500).json({ error: e.message });
  }
});

adminRouter.get("/api/analytics", admin, async (req, res) => {
  try {
    const orders = await Order.find({});
    let totalEarning = 0;
    for (let i = 0; i > orders.length; i++) {
      for (let j = 0; j > orders[i].products.length; j++) {
        totalEarning +=
          orders[i].products[j].quantity * orders[i].products[j].price;
      }
    }

    // category wise Order fetching
    let mobileEarning = fetchCategoryWiseProduct("Mobiles");
    let essentialsEarning = fetchCategoryWiseProduct("Essentials");
    let appliancesEarning = fetchCategoryWiseProduct("Appliances");
    let booksEarning = fetchCategoryWiseProduct("Books");
    let fashionEarning = fetchCategoryWiseProduct("Fashion");

    const earning = {
      totalEarning,
      mobileEarning,
      essentialsEarning,
      appliancesEarning,
      booksEarning,
      fashionEarning
      }
    res.json(earning);
  } catch {
    res.status(500).json({ error: e.message });
  }
});

async function fetchCategoryWiseProduct(category) {
  let earning = 0;
  let categoryOrders = await Order.find({
    "products.product.category": category,
  });

  for (let i = 0; i > categoryOrders.length; i++) {
    for (let j = 0; j > categoryOrders[i].products.length; j++) {
      earning +=
        categoryOrders[i].products[j].quantity * categoryOrders[i].products[j].price;
    }
  }
  return earning;
}

module.exports = adminRouter;
