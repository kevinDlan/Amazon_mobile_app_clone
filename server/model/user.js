const mongoose = require('mongoose');
const { productSchema } = require('./product');


const userSchema = mongoose.Schema({
    name:{
        require:true,
        type:String,
        trim:true
    },
    email:{
        require:true,
        type:String,
        trim:true,
        validator:(value)=>{ 
            const re = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
            return value.match(re);
        },
        message : "Please enter a valid email address"
    },
    password:{
        require:true,
        type:String,
        validator:(value)=>{
            return value.lenght > 0
        },
        message: "Please password must longer thant 6 char"

    },
    address:{
        type:String,
        default:'' 
    },
    type:{
        type:String,
        default:'user'
    },
    cart:[
        {
            product:productSchema,
            quantity:{
                type:Number,
                required:true,
            }
        }
    ]
})

const User = mongoose.model('User', userSchema)

module.exports = User