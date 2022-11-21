import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:streamchat/domain/logic/stream/stream_cubit.dart';
import 'package:streamchat/screens/Contactos/Components/messageme.dart';
import 'package:streamchat/screens/Contactos/Components/messageother.dart';
import 'package:streamchat/screens/Contactos/Components/time.dart';

class ListMessage extends StatefulWidget {
  const ListMessage({
    Key? key,
    required this.messages,
  }) : super(key: key);

  final List<Message> messages;

  @override
  State<ListMessage> createState() => _ListMessageState();
}

class _ListMessageState extends State<ListMessage> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<StreamCubit>().state.client.state.currentUser;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemCount: widget.messages.length + 1,
        reverse: true,
        separatorBuilder: (context, index) {
          if (index == widget.messages.length - 1) {
            return TimeApp(dateTime: widget.messages[index].createdAt);
          }
          if (widget.messages.length == 1) {
            return const SizedBox.shrink();
          } else if (index >= widget.messages.length - 1) {
            return const SizedBox.shrink();
          } else if (index <= widget.messages.length) {
            final message = widget.messages[index];
            final nextMessage = widget.messages[index + 1];
            if (!Jiffy(message.createdAt.toLocal())
                .isSame(nextMessage.createdAt.toLocal(), Units.DAY)) {
              return TimeApp(
                dateTime: message.createdAt,
              );
            } else {
              return const SizedBox.shrink();
            }
          } else {
            return const SizedBox.shrink();
          }
        },
        itemBuilder: (context, index) {
          if (index < widget.messages.length) {
            final message = widget.messages[index];
            if (message.user?.id == user?.id) {
              return MessageMe(message: message);
            } else {
              return MessageOther(message: message);
            }
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
