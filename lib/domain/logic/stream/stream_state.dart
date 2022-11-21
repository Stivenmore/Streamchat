part of 'stream_cubit.dart';

enum StateClient { loading, success, error, none }
enum StateListUser { loading, success, error, none }

class StreamState extends Equatable {
  late final StreamChatClient client;
  late final StateClient stateClient;

  StreamState(
      {StreamChatClient? client,
      StateClient? stateClient,
      List<UserModel>? listUser}) {
    this.client = client ?? StreamChatClient('');
    this.stateClient = stateClient ?? StateClient.none;
  }

  StreamState copyWith(
      {StreamChatClient? client,
      StateClient? stateClient,
      List<UserModel>? listUser}) {
    return StreamState(
        client: client ?? this.client,
        stateClient: stateClient ?? this.stateClient);
  }

  @override
  List<Object> get props => [client, stateClient];
}
