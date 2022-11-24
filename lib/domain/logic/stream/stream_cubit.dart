import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:streamchat/domain/models/usermodel.dart';

part 'stream_state.dart';

class StreamCubit extends Cubit<StreamState> {
  StreamCubit() : super(StreamState());

  Future initClient(StreamChatClient client, UserModel model,
      List<UserModel> contacts) async {
    try {
      emit(state.copyWith(stateClient: StateClient.loading));
      final current = client.state.currentUser;
      if (current?.id != model.id) {
        await client.connectUser(
            User(
                id: model.id.trim(),
                extraData: {"image": model.img, "name": model.name}),
            client.devToken(model.id).rawValue);
        await createListChannels(client, contacts, model);
      }
      emit(state.copyWith(client: client, stateClient: StateClient.success));
    } catch (e) {
      emit(state.copyWith(stateClient: StateClient.error));
    }
  }

  Future createListChannels(StreamChatClient client, List<UserModel> contacts,
      UserModel currentUser) async {
    emit(state.copyWith(stateUploadContacts: StateUploadContacts.loading));
    try {
      await client.disconnectUser();
      await createUsers(contacts, client);
      await client.disconnectUser();
      await client.connectUser(
          User(
            id: 'dualbp',
          ),
          client.devToken('dualbp').rawValue);
      for (var i = 0; i < contacts.length; i++) {
        await client.createChannel('messaging',
            channelId: '${contacts[i].name}And${currentUser.name}',
            channelData: {
              "members": [contacts[i].id.trim(), currentUser.id.trim()],
              "name": "${contacts[i].name}And${currentUser.name}"
            });
      }
      await client.disconnectUser();
      await client.connectUser(
          User(
              id: currentUser.id.trim(),
              extraData: {"image": currentUser.img, "name": currentUser.name}),
          client.devToken(currentUser.id).rawValue);
      emit(state.copyWith(stateUploadContacts: StateUploadContacts.success));
    } catch (e) {
      emit(state.copyWith(stateUploadContacts: StateUploadContacts.error));
    }
  }

  Future createUsers(List<UserModel> contacts, StreamChatClient client) async {
    for (int i = 0; i < contacts.length; i++) {
      await client.disconnectUser();
      await client.connectUser(
          User(id: contacts[i].id.trim(), extraData: {
            "image": contacts[i].img,
            "name": contacts[i].name,
            "role": "admin"
          }),
          client.devToken(contacts[i].id.trim()).rawValue);
    }
  }
}
