import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:streamchat/screens/Contactos/Components/inputchat.dart';
import 'package:streamchat/screens/Contactos/Components/listmessage.dart';

class ChatScreen extends StatefulWidget {
  final String img, name;
  ChatScreen({Key? key, required this.img, required this.name})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late StreamSubscription<int> unreadCountSubscription;

  @override
  void initState() {
    super.initState();
    unreadCountSubscription = StreamChannel.of(context)
        .channel
        .state!
        .unreadCountStream
        .listen(_unreadCountHandler);
  }

  Future<void> _unreadCountHandler(int count) async {
    if (count > 0) {
      await StreamChannel.of(context).channel.markRead();
    }
  }

  @override
  void dispose() {
    unreadCountSubscription.cancel();
    unreadCountSubscription.onDone(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Color(0xffFAFAFA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leadingWidth: 54,
          leading: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              icon: Icon(
                CupertinoIcons.back,
                color: Colors.grey,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          //title: const _AppBarTitle(),
          actions: [],
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(56),
                  child: Container(
                    height: 35,
                    width: 35,
                    child: FadeInImage.assetNetwork(
                        placeholder: 'assets/placeholder.jpg', image: widget.img),
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(widget.name, style: TextStyle(color: Colors.black, fontSize: 16),)
              
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: MessageListCore(
                loadingBuilder: (context) {
                  return const Center(child: CircularProgressIndicator());
                },
                emptyBuilder: (context) => const SizedBox.shrink(),
                errorBuilder: (context, error) => Text(error.toString()),
                messageListBuilder: (context, messages) =>
                    ListMessage(messages: messages),
              ),
            ),
            const InputChat(),
          ],
        ),
      ),
    );
  }
}
