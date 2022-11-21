import 'package:streamchat/domain/models/contactsmodel.dart';

class UserModel {
  final String name;
  final String img;
  final String id;
  final List<ContactsModel> contacts;

  UserModel(
      {required this.name,
      required this.img,
      required this.id,
      required this.contacts});

  factory UserModel.fromFirebase(Map<String, dynamic> map) {
    return UserModel(
        name: map["name"] as String? ?? "",
        img: map["img"] as String? ?? "",
        id: map["id"] as String? ?? "",
        contacts: (map["contacts"] as Iterable)
            .map((e) => ContactsModel.fromFirebase(e))
            .toList());
  }
}
