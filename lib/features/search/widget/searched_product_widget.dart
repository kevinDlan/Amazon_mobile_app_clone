import 'package:amazon/common/widgets/stars.dart';
import 'package:flutter/material.dart';
import '../../../models/product.dart';

class SearchedProductWidget extends StatelessWidget {
  final Product product;
  const SearchedProductWidget({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    double totalRating = 0;
    double avgRating = 0;

    for(int i = 0; i < product.rating!.length; i++)
    {
      totalRating += product.rating![i].rating;
    }

    if (totalRating != 0)
    {
      avgRating = totalRating / product.rating!.length;
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Image.network(product.images[0], fit: BoxFit.fitWidth, height: 135, width: 135),
              Column(
               children: [
                 Container(
                   width: 200,
                   padding: const EdgeInsets.symmetric(horizontal: 10),
                   child: Text(product.name,overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 16), maxLines: 2,),
                 ),
                 Container(
                   width: 200,
                   padding: const EdgeInsets.only(left: 10, top: 5),
                   child: Stars(ratings: avgRating),
                 ),
                 Container(
                   width: 200,
                   padding: const EdgeInsets.only(left: 10, top: 5),
                   child: Text("\$ ${product.price}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), maxLines: 2,),
                 ),
                 Container(
                   width: 200,
                   margin: const EdgeInsets.only(top: 5, bottom: 5),
                   padding: const EdgeInsets.only(left: 10),
                   child: const Text("Eligible for FREE Shipping", style: TextStyle(fontWeight: FontWeight.w500, color: Colors.green),),
                 ),
                 Container(
                   width: 200,
                   padding: const EdgeInsets.only(left: 10),
                   child: const Text("In Stock (10)", style: TextStyle(color: Colors.teal),),
                 )
               ],
              )
            ],
          ),
        )
      ],
    );
  }
}
