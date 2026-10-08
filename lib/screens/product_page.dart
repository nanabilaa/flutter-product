import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/product.dart';


class ProductPage extends StatefulWidget {

  const ProductPage({super.key});


  @override
  State<ProductPage> createState()=>_ProductPageState();

}



class _ProductPageState extends State<ProductPage>{


  late Future<List<Product>> products;



  @override
  void initState(){

    super.initState();

    products = ApiService.getProducts();

  }



  void refresh(){

    setState(() {

      products = ApiService.getProducts();

    });

  }



  @override
  Widget build(BuildContext context){


    return Scaffold(

      appBar:AppBar(
        title:Text("Laravel Products"),
      ),


      body:FutureBuilder<List<Product>>(

        future:products,


        builder:(context,snapshot){


          if(snapshot.connectionState ==
              ConnectionState.waiting){

            return Center(
              child:CircularProgressIndicator()
            );

          }


          if(snapshot.hasError){

            return Center(
              child:Text(snapshot.error.toString())
            );

          }


          final data=snapshot.data!;


          return ListView.builder(

            itemCount:data.length,


            itemBuilder:(context,index){


              final item=data[index];


              return ListTile(

                title:Text(item.name),

                subtitle:Text(
                  "Rp ${item.price}\n${item.description}"
                ),


              );

            },


          );


        },


      ),


    );


  }

}
