import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:streamchat/data/contracts/contract.dart';
import 'package:streamchat/domain/models/usermodel.dart';

part 'stream_state.dart';

class StreamCubit extends Cubit<StreamState> {
  final ContractUserDataSource _dataSource;
  StreamCubit(ContractUserDataSource dataSource)
      : _dataSource = dataSource,
        super(StreamState());

  late StreamChannelListController contactschannelsController;
  Future createController(StreamChatClient client, String idUser) async {
    contactschannelsController = StreamChannelListController(
      client: client,
      filter: Filter.and(
        [
          Filter.equal('type', 'messaging'),
          Filter.in_('members', [idUser.trim()])
        ],
      ),
    );
    contactschannelsController.doInitialLoad();
  }

  void initProcess(){
   emit(state.copyWith(stateStep: StateClientStep.first));
  }

  Future initClient(StreamChatClient client, UserModel model) async {
    try {
      emit(state.copyWith(stateStep: StateClientStep.first));
      final current = client.state.currentUser;
      await _dataSource.connectUserSingle(model, client);
      emit(state.copyWith(client: client, stateStep: StateClientStep.tercer));
    } catch (e) {
      emit(state.copyWith(stateStep: StateClientStep.zero));
    }
  }

  Future createListChannels(StreamChatClient client, List<UserModel> contacts,
      UserModel currentUser) async {
    try {
      emit(state.copyWith(client: client, stateStep: StateClientStep.second));
      await _dataSource.createUsers(contacts, client);
      await _dataSource.connectUserForClient(
          User(
            id: 'dualbp',
          ),
          client.devToken('dualbp').rawValue,
          client);
      await _dataSource.createChannel(contacts, client, currentUser);
      await _dataSource.disconnectUser(client);
      await _dataSource.connectUserSingle(currentUser, client);
      emit(state.copyWith(stateStep: StateClientStep.tercer));
    } catch (e) {
      emit(state.copyWith(stateStep: StateClientStep.second));
    }
  }
}
