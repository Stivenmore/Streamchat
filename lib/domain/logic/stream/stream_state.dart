part of 'stream_cubit.dart';

enum StateClientStep {zero ,first, second, tercer}

class StreamState extends Equatable {
  late final StreamChatClient client;
  late final StateClientStep stateStep;

  StreamState(
      {StreamChatClient? client,
      StateClientStep? stateStep}) {
    this.client = client ?? StreamChatClient('');
    this.stateStep = stateStep ?? StateClientStep.zero;
  }

  StreamState copyWith(
      {StreamChatClient? client,
      StateClientStep? stateStep}) {
    return StreamState(
        client: client ?? this.client,
        stateStep: stateStep ?? this.stateStep);
  }

  @override
  List<Object?> get props => [client, stateStep];
}
