import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:streamchat/domain/logic/stream/stream_cubit.dart';
import 'package:streamchat/domain/logic/user/user_cubit.dart';
import 'package:streamchat/screens/Chats/Layouts/contacts_screen.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      context.read<UserCubit>().getuser();
      context.read<UserCubit>().contacts();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Center(
          child: Builder(builder: (context) {
            final userState = context.select((UserCubit bloc) => bloc.state);
            final user = context.select((UserCubit value) => value.state.user);
            final contacts =
                context.select((UserCubit value) => value.state.listuser);
            if (userState.enumuser == StateUser.success &&
                userState.enumlistuser == StateListUsers.success) {
              final streamClient = StreamChatCore.of(context).client;
              streamClient.disconnectUser().whenComplete(() {
                context
                    .read<StreamCubit>()
                    .initClient(streamClient, user, contacts);
              });
              final streamState =
                  context.select((StreamCubit bloc) => bloc.state.stateClient);
              if (streamState == StateClient.success) {
                final statecontact = context.select(
                    (StreamCubit bloc) => bloc.state.stateUploadContacts);
                if (statecontact == StateUploadContacts.success) {
                  Future.delayed(Duration.zero, () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContactsScreen()),
                        (route) => false);
                  });
                }
              }
            }
            return TweenAnimationBuilder(
                tween: Tween<double>(begin: 0.0, end: 60.0),
                duration: const Duration(seconds: 100),
                builder: (context, double value, child) {
                  return Transform.rotate(
                    angle: value,
                    child: const Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 50,
                    ),
                  );
                });
          }),
        ),
      ),
    );
  }
}
