import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_chat/firebase/productFireStore.dart';
class ProductDetail extends StatefulWidget {
  String id;
  ProductDetail(this.id);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  TextEditingController typeController=TextEditingController();

  CollectionReference products = FirebaseFirestore.instance.collection('products');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder<DocumentSnapshot>(
        stream:products.doc(widget.id.toString()).snapshots() ,
        builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot>snapshot){

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 200,),
              Text("type: "+data["type"].toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
              ,Text("price: "+data["price"].toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
              ,Text("color: "+data["color"].toString(),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
              ,Spacer(),
              TextField(
                controller:typeController ,
              ),
              GestureDetector(
                onTap: ()async{
                  updateProductType(typeController.text, widget.id);
                },
                child: Container(
                    color: Colors.blue,
                    padding: EdgeInsets.all(10),
                    child: Text("update product")
                ),
              ),
            ],
          );
        } ,
      ),


    );
  }
}
