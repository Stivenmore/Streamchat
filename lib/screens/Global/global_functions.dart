import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:streamchat/domain/models/usermodel.dart';

namechannelTocontact(Channel channel, List<UserModel> contacts) {
  final value =
      contacts.where((element) => channel.name!.contains(element.name)).first;
  return value.name;
}

imgchannelTocontact(Channel channel, List<UserModel> contacts) {
  final value =
      contacts.where((element) => channel.name!.contains(element.name));
  return value.first.img;
}
