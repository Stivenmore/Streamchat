class ContactsModel {
  final String nameUser;
  final String nameChannel;
  final String idChannel;
  final String img;

  ContactsModel(
      {required this.nameUser,
      required this.nameChannel,
      required this.idChannel,
      required this.img});

  factory ContactsModel.fromFirebase(Map<String, dynamic> map) {
    return ContactsModel(
        nameUser: map["nameUser"] as String? ?? "",
        nameChannel: map["nameChannel"] as String? ?? "",
        idChannel: map["idChannel"] as String? ?? "",
        img:
            "https://firebasestorage.googleapis.com/v0/b/comics-decc0.appspot.com/o/img%2FSolo%20leveling%2F1.png?alt=media&token=b46591c8-ffd8-43b3-91fe-0479ffd065c0");
  }
}
