

import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:streamchat/domain/models/usermodel.dart';

abstract class ContractUserDataSource {

  Future<UserModel> user();

  Future<List<UserModel>> contacts();

  Future createUsers(List<UserModel> contacts, StreamChatClient client);
  
  Future createChannel(List<UserModel> contacts, StreamChatClient client, UserModel currentUser);

  Future connectUserSingle(UserModel contacts, StreamChatClient client);

  Future connectUserForClient(User user, String token, StreamChatClient client);

  Future disconnectUser(StreamChatClient client);
}