

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:streamchat/data/contracts/contract.dart';
import 'package:streamchat/domain/models/usermodel.dart';

class UserDataSource implements ContractUserDataSource{
  
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  @override
  Future<UserModel> user() async{
       try {
     final resp = await _firestore.collection("Users").doc('XR5t0NEIa61Qh6FUlpIx').get();
      UserModel list = UserModel.fromFirebase(resp.data()!);
      return list;
    } catch (e) {
      throw Exception(e);
    }
  }
}