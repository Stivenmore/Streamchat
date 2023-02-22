import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:streamchat/screens/Chats/Components/view_image.dart';
import 'package:streamchat/screens/Chats/Components/view_video.dart';

class MessageContainer extends StatelessWidget {
  const MessageContainer(
      {Key? key,
      required this.message,
      required this.isGroup,
      required this.itsme,
      required this.alignment,
      required this.boxDecoration,
      required this.colortext,
      required this.crossAxisAlignment})
      : super(key: key);

  final Message message;
  final BoxDecoration boxDecoration;
  final Alignment alignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Color colortext;
  final bool isGroup;
  final bool itsme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: alignment,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: crossAxisAlignment,
          children: [
            Container(
              decoration: boxDecoration,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: typeMessagePaddingHorizontal(message),
                    vertical: typeMessagePaddingVertical(message)),
                child: typeMessage(message, context),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                Jiffy(message.createdAt.toLocal()).jm,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget typeMessage(Message message, BuildContext context) {
    if (message.attachments.isNotEmpty &&
        message.text != null &&
        message.text!.isNotEmpty) {
      return Column(
        children: [
          message.attachments.first.type == 'image'
              ? InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => ViewImage(
                          url: message.attachments.first.imageUrl!)))),
                  child: FadeInImage.assetNetwork(
                    height: 200,
                    placeholderScale: 100,
                    placeholder: 'assets/placeholder.jpg',
                    image: message.attachments.first.imageUrl!,
                  ),
                )
              : message.attachments.first.type == 'video'
                  ? InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => ViewVideo(
                              url: message.attachments.first.imageUrl!)))),
                      child: Stack(
                        children: [
                          Opacity(
                            opacity: 0.5,
                            child: FadeInImage.assetNetwork(
                              height: 200,
                              placeholderScale: 100,
                              placeholder: 'assets/placeholder.jpg',
                              image: message.attachments.first.assetUrl!,
                            ),
                          ),
                          Icon(
                            Icons.play_arrow,
                            size: 40,
                            color: Colors.white,
                          )
                        ],
                      ),
                    )
                  : message.attachments.first.type == 'PDF'
                      ? Icon(
                          Icons.file_copy,
                          size: 44,
                        )
                      : Icon(
                          Icons.file_copy,
                          color: colortext,
                          size: 55,
                        ),
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            width: 120,
            child: Text(
              message.text!,
              style: TextStyle(color: colortext, fontWeight: FontWeight.w600),
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      );
    } else if (message.attachments.isNotEmpty &&
        message.attachments.first.type == 'image') {
      return InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) =>
                ViewImage(url: message.attachments.first.imageUrl!)))),
        child: SizedBox(
          height: 200,
          child: FadeInImage.assetNetwork(
            placeholderScale: 100,
            placeholder: 'assets/placeholder.jpg',
            image: message.attachments.first.imageUrl!,
            fit: BoxFit.fitHeight,
          ),
        ),
      );
    } else if (message.attachments.isNotEmpty &&
        message.attachments.first.type == 'video') {
      return InkWell(
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: ((context) =>
                ViewVideo(url: message.attachments.first.imageUrl!)))),
        child: SizedBox(
          height: 200,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Opacity(
                opacity: 0.5,
                child: FadeInImage.assetNetwork(
                  placeholderScale: 100,
                  placeholder: 'assets/placeholder.jpg',
                  image: message.attachments.first.thumbUrl!,
                ),
              ),
              Icon(
                Icons.play_arrow,
                size: 40,
                color: Colors.white,
              )
            ],
          ),
        ),
      );
    } else if (message.text != null && message.text!.isNotEmpty) {
      return SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            !itsme && isGroup? 
                Text(message.user!.name,) : SizedBox(),
            Text(
              message.text!,
              style: TextStyle(color: colortext, fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );
    } else if (message.attachments.first.type == 'PDF') {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          Icons.file_copy,
          color: colortext,
          size: 44,
        ),
      );
    } else {
      return Text(
        '...',
        style: TextStyle(color: colortext, fontWeight: FontWeight.w600),
      );
    }
  }

  double typeMessagePaddingHorizontal(Message message) {
    if (message.text != null && message.text!.isNotEmpty) {
      return 16.0;
    } else {
      return 0.0;
    }
  }

  double typeMessagePaddingVertical(Message message) {
    if (message.text != null && message.text!.isNotEmpty) {
      return 20.0;
    } else {
      return 0.0;
    }
  }
}
