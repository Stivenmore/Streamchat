part of 'stream_cubit.dart';

enum StateClient { loading, success, error, none }
enum StateContacts { loading, success, error, none }
enum StateUploadContacts {loading, success, error, none}

class StreamState extends Equatable {
  late final StreamChatClient client;
  late final StateClient stateClient;
  late final StateUploadContacts stateUploadContacts;

  StreamState(
      {StreamChatClient? client,
      StateClient? stateClient,
      StateUploadContacts? stateUploadContacts}) {
    this.client = client ?? StreamChatClient('');
    this.stateClient = stateClient ?? StateClient.none;
    this.stateUploadContacts = stateUploadContacts ?? StateUploadContacts.none;
  }

  StreamState copyWith(
      {StreamChatClient? client,
      StateClient? stateClient,
      StateUploadContacts? stateUploadContacts}) {
    return StreamState(
        client: client ?? this.client,
        stateClient: stateClient ?? this.stateClient,
        stateUploadContacts: stateUploadContacts ?? this.stateUploadContacts);
  }

  @override
  List<Object> get props => [client, stateClient, stateUploadContacts];
}
