

import 'package:streamchat/domain/models/usermodel.dart';

abstract class ContractUserDataSource {

  Future<UserModel> user();
  
}