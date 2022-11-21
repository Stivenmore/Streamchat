import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:streamchat/domain/models/usermodel.dart';

part 'stream_state.dart';

class StreamCubit extends Cubit<StreamState> {
  StreamCubit() : super(StreamState());


  void initClient(StreamChatClient client, UserModel model) async {
    try {
      final resp = client.state.currentUser;
      if (resp == null) {
        await client.connectUser(
            User(
                id: model.id,
                extraData: {"image": model.img, "name": model.name}),
            client.devToken(model.id).rawValue);
      }
      emit(state.copyWith(client: client));
    } catch (e) {
      print(e);
    }
  }
}
