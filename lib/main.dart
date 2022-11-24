import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';
import 'package:streamchat/data/datasource/user_datasource.dart';
import 'package:streamchat/data/env/env.dart';
import 'package:streamchat/domain/logic/stream/stream_cubit.dart';
import 'package:streamchat/domain/logic/user/user_cubit.dart';
import 'package:streamchat/screens/Splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  final datasource = UserDataSource();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => StreamCubit(),
        ),
        BlocProvider(create: ((context) => UserCubit(datasource)))
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    final streamClient = StreamChatClient(apiKey, logLevel: Level.INFO);
    return MaterialApp(
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: 'Stream Chat',
      builder: (context, child) {
        return StreamChatCore(client: streamClient, child: child!);
      },
      home: SplashScreen(),
    );
  }
}
