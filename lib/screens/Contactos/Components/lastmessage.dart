import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';

Widget buildLastMessage(Channel channel) {
  return BetterStreamBuilder<int>(
    stream: channel.state!.unreadCountStream,
    initialData: channel.state?.unreadCount ?? 0,
    builder: (context, count) {
      return BetterStreamBuilder<Message>(
        stream: channel.state!.lastMessageStream,
        initialData: channel.state!.lastMessage,
        builder: (context, lastMessage) {
          return Align(
              alignment: Alignment.centerLeft, child: typeMessage(lastMessage));
        },
      );
    },
  );
}

Widget typeMessage(Message message) {
  if (message.text != null && message.text!.isNotEmpty) {
    return SizedBox(
      width: 150,
      child: Text(
        message.text!,
        style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
        overflow: TextOverflow.ellipsis,
      ),
    );
  } else if (message.attachments.isNotEmpty && message.attachments.last.type == 'image') {
    return FadeInImage.assetNetwork(
      height: 20,
      width: 20,
      placeholder: 'assets/placeholder.jpg',
      image: message.attachments.first.imageUrl!,
    );
  } else {
    return Text(
      '...',
      style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
    );
  }
}
