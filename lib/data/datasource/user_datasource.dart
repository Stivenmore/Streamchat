

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:streamchat/data/contracts/contract.dart';
import 'package:streamchat/domain/models/usermodel.dart';

class UserDataSource implements ContractUserDataSource{
  
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  @override
  Future<UserModel> user() async{
       try {
     final resp = await _firestore.collection("Users").doc('vBzVATuCrYoKxBjL7OY7').get();
      UserModel list = UserModel.fromFirebase(resp.data()!);
      return list;
    } catch (e) {
      throw Exception(e);
    }
  }
}