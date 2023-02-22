import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:streamchat/data/contracts/contract.dart';
import 'package:streamchat/data/source/source.dart';
import 'package:streamchat/domain/models/usermodel.dart';

class UserDataSource implements ContractUserDataSource {
  @override
  Future<UserModel> user() async {
    try {
      return usermodel;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<UserModel>> contacts() async {
    try {
      return usermodelList;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future createUsers(List<UserModel> contacts, StreamChatClient client) async {
    try {
      for (int i = 0; i < contacts.length; i++) {
        await client.disconnectUser();
        await client.connectUser(
            User(id: contacts[i].id.trim(), extraData: {
              "image": contacts[i].img,
              "name": contacts[i].name,
            }),
            client.devToken(contacts[i].id.trim()).rawValue);
      }
      await client.disconnectUser();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future connectUserSingle(UserModel contacts, StreamChatClient client) async {
    try {
      await client.connectUser(
          User(id: contacts.id.trim(), extraData: {"name": contacts.name}),
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiU3RpdmVuX2YwNGNiYTcxLTk5YzgtNDllYS05YjcwLWIyMzM1MTRjYzBlZiJ9.q-FUs5VIOUU82HyntmxYY0mhXFZmByisQc98Rffkb7w');
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future createChannel(List<UserModel> contacts, StreamChatClient client,
      UserModel currentUser) async {
    try {
      for (var i = 0; i < contacts.length; i++) {
        await client.createChannel('messaging',
            channelId: '${contacts[i].name}And${currentUser.name}',
            channelData: {
              "members": [contacts[i].id.trim(), currentUser.id.trim()],
              "name": "${contacts[i].name}And${currentUser.name}"
            });
      }
      await client.disconnectUser();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future disconnectUser(StreamChatClient client) async {
    try {
      await client.disconnectUser();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future connectUserForClient(
      User user, String token, StreamChatClient client) async {
    try {
      await client.connectUser(user, token);
    } catch (e) {
      throw Exception(e);
    }
  }
}
