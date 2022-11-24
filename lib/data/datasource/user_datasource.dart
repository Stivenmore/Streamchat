

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:streamchat/data/contracts/contract.dart';
import 'package:streamchat/domain/models/usermodel.dart';

class UserDataSource implements ContractUserDataSource{
  
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  @override
  Future<UserModel> user() async{
       try {
     final resp = await _firestore.collection("Admin").doc('SXECbstqaD8AkQufIIxd').get();
      UserModel list = UserModel.fromFirebase(resp.data()!);
      return list;
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<List<UserModel>> contacts() async{
    try {
     final resp = await _firestore.collection("Users").get();
      List<UserModel> list = (resp.docs).map((e) => UserModel.fromFirebase(e.data())).toList();
      return list;
    } catch (e) {
      throw Exception(e);
    }
  }
}