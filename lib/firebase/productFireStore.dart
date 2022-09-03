import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

addProduct(String color, int price, String type) async {
  CollectionReference proudct =
  FirebaseFirestore.instance.collection('products');
  proudct.add({"color": color, "type": type, "price": price,"uid":FirebaseAuth.instance.currentUser!.uid});
}

updateProductType(String type,String id) async {
  try{
    CollectionReference proudct = FirebaseFirestore.instance.collection('products');
    proudct.doc(id).update({"type":type});
    return "done";
  }
  catch(e){
    return "faild";
  }

}

deleteProduct(String id) async {
  try {
    CollectionReference proudct = FirebaseFirestore.instance.collection('products');

    proudct.where('',isEqualTo: "").get();
    proudct.doc(id).delete();
    return "done";
  }
  catch (e) {
    return "faild";
  }
}

updateProductWhereColorIsRed(int price) async {
  try {
    CollectionReference proudct = FirebaseFirestore.instance.collection('products');
    var query=await proudct.where("color",isEqualTo: "red").get();
    for(var e in query.docs){
      String id=e.id;
      proudct.doc(id).update({"price":price});
    }

    return "done";
  }
  catch (e) {
    return "faild";
  }
}


