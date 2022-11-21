  import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:streamchat/domain/models/contactsmodel.dart';

namechannelTocontact(Channel channel, List<ContactsModel> contacts) {
    final value =
        contacts.where((element) => element.nameChannel == channel.name).first;
    return value.nameUser;
  }

  imgchannelTocontact(Channel channel, List<ContactsModel> contacts) {
    final value =
        contacts.where((element) => element.nameChannel == channel.name);
    return value.first.img;
  }