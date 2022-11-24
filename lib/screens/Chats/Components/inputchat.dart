import 'dart:async';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter_core/stream_chat_flutter_core.dart';
import 'package:streamchat/screens/Chats/Components/actionbutton.dart';

class InputChat extends StatefulWidget {
  const InputChat({Key? key}) : super(key: key);

  @override
  InputChatState createState() => InputChatState();
}

class InputChatState extends State<InputChat> {
  final StreamMessageInputController controller =
      StreamMessageInputController();

  Timer? _debounce;
  final colororange = Color(0xffFB7F6B);

  Future sendMessage(Message message) async {
    if (message.text != null && message.text!.isNotEmpty ||
        message.attachments.isNotEmpty) {
      StreamChannel.of(context).channel.sendMessage(message);
      controller.clear();
      FocusScope.of(context).unfocus();
    }
  }

  void sendImage() async {
    Navigator.of(context).pop();
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png'],
        allowMultiple: true);
    if (result != null && result.files.isNotEmpty) {
      for (var i = 0; i < result.files.length; i++) {
        final file = AttachmentFile(
            size: result.files[i].size,
            path: result.files[i].path,
            bytes: result.files[i].bytes,
            name: result.files[i].name);
        await StreamChannel.of(context).channel.sendImage(file,
            extraData: {"name": result.files[i].name}).then((value) {
          final attachment = Attachment(type: 'image', imageUrl: value.file);
          sendMessage(
              Message(attachments: [attachment], text: controller.text.trim()));
        });
      }
      controller.clear();
      FocusScope.of(context).unfocus();
    }
  }

  void sendVideos() async {
    Navigator.of(context).pop();
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['mp4', 'm4a'],
        allowMultiple: true);
    if (result != null && result.files.isNotEmpty) {
      for (var i = 0; i < result.files.length; i++) {
        final file = AttachmentFile(
            size: result.files[i].size,
            path: result.files[i].path,
            bytes: result.files[i].bytes,
            name: result.files[i].name);
        await StreamChannel.of(context).channel.sendFile(file,
            extraData: {"name": result.files[i].name}).then((value) {
          final attachment = Attachment(
              type: 'video', imageUrl: value.file, thumbUrl: value.thumbUrl);
          sendMessage(
              Message(attachments: [attachment], text: controller.text.trim()));
        });
      }
      controller.clear();
      FocusScope.of(context).unfocus();
    }
  }

  void sendPDF() async {
    Navigator.of(context).pop();
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['PDF', 'pdf'],
        allowMultiple: true);
    if (result != null && result.files.isNotEmpty) {
      for (var i = 0; i < result.files.length; i++) {
        final file = AttachmentFile(
            size: result.files[i].size,
            path: result.files[i].path,
            bytes: result.files[i].bytes,
            name: result.files[i].name);
        await StreamChannel.of(context).channel.sendFile(file,
            extraData: {"name": result.files[i].name}).then((value) {
          final attachment = Attachment(
              type: 'PDF', imageUrl: value.file, thumbUrl: value.thumbUrl);
          sendMessage(
              Message(attachments: [attachment], text: controller.text.trim()));
        });
      }
      controller.clear();
      FocusScope.of(context).unfocus();
    }
  }

  showModel() {
    return showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            side: BorderSide(
              color: colororange,
              strokeAlign: StrokeAlign.outside,
              width: 2,
              style: BorderStyle.solid
            )),
        builder: (context) {
          return Container(
            height: 200,
            width: double.infinity,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () => sendImage(),
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 40,
                              color: colororange,
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text("Imagen")
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () => sendVideos(),
                        child: Column(
                          children: [
                            Icon(
                              Icons.movie_outlined,
                              size: 40,
                              color: colororange,
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text("Video")
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () => sendPDF(),
                        child: Column(
                          children: [
                            Icon(
                              Icons.file_copy,
                              size: 40,
                              color: colororange,
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text("File")
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _onTextChange() {
    controller.textFieldController.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 200), () {
      if (mounted) {
        StreamChannel.of(context).channel.keyStroke();
      }
      controller.textFieldController.selection = TextSelection.fromPosition(
          TextPosition(offset: controller.text.length));
    });
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(_onTextChange);
  }

  @override
  void dispose() {
    controller.removeListener(_onTextChange);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8, left: 10, right: 10),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[300], borderRadius: BorderRadius.circular(34)),
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Row(
                    children: [
                      IconButton(
                          padding: EdgeInsets.only(left: 2, right: 5),
                          onPressed: () => showModel(),
                          icon: Icon(CupertinoIcons.layers_alt_fill)),
                      Expanded(
                        child: TextField(
                          cursorColor: colororange,
                          controller: controller.textFieldController,
                          style: const TextStyle(fontSize: 14),
                          decoration: const InputDecoration(
                            hintText: 'Escribe algo...',
                            border: InputBorder.none,
                          ),
                          onSubmitted: (_) => sendMessage(controller.message),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 4,
                  right: 4.0,
                ),
                child: GlowingActionButton(
                  color: Color(0xffFB7F6B),
                  icon: Icons.send_rounded,
                  onPressed: () => sendMessage(controller.message),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
