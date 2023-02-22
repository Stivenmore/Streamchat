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
      context.read<UserCubit>().getuser().whenComplete(() {
        context.read<StreamCubit>().initProcess();
      });
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
            child: BlocListener<StreamCubit, StreamState>(
          listenWhen: (previous, current) =>
              previous.stateStep != current.stateStep,
          listener: (context, state) {
            final streamClient = StreamChatCore.of(context).client;
            if (state.stateStep == StateClientStep.first) {
              UserState userState = context.read<UserCubit>().state;
              context
                  .read<StreamCubit>()
                  .initClient(streamClient, userState.user);
            }
            if (state.stateStep == StateClientStep.tercer) {
              UserState userState = context.read<UserCubit>().state;
              context
                  .read<StreamCubit>()
                  .createController(streamClient, userState.user.id.trim());
              Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => ContactsScreen()),
                    (route) => false);
            }
          },
          child: TweenAnimationBuilder(
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
              }),
        )),
      ),
    );
  }
}
