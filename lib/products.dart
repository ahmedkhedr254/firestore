import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chat/productDetail.dart';

import 'firebase/productFireStore.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  TextEditingController typeController=TextEditingController();
  CollectionReference products = FirebaseFirestore.instance.collection('products');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder<QuerySnapshot>(
            stream:products.snapshots() ,
            builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
              if (snapshot.hasError) {
                return Text("Something went wrong");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(),);
              }
              return ListView(
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 100),
                children:snapshot.data!.docs.map((e) {
                  Map<String, dynamic> data = e.data()! as Map<String, dynamic>;
                  return GestureDetector(
                    onTap: (){
                      String id =e.id;
                      Navigator.push(context, MaterialPageRoute(builder: (context){return ProductDetail(id);}));
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Text(data["type"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          SizedBox(width: 30,),
                          Text(data["price"].toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                          ,Spacer(),
                          GestureDetector(
                              onTap: (){
                                deleteProduct(e.id);
                              },
                              child: Icon(Icons.delete,color:Colors.red,))
                        ],
                      ),
                    ),
                  );
                }).toList() ,
              );


            },
          ),

          Spacer(),
          TextField(
            controller:typeController ,
          ),
          GestureDetector(
            onTap: ()async{
              await addProduct("red",100,typeController.text);
            },
            child: Container(
              color: Colors.blue,
                padding: EdgeInsets.all(10),
                child: Text("add product")
            ),
          ),

          GestureDetector(
            onTap: ()async{
              await updateProductWhereColorIsRed(700);
            },
            child: Container(
                color: Colors.blue,
                padding: EdgeInsets.all(10),
                child: Text("update where color is red")
            ),
          ),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}
