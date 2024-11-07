import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_wall/cubits/login_cubit/login_cubit.dart';
import 'package:the_wall/cubits/register_cubit/register_cubit.dart';
import 'package:the_wall/firebase_options.dart';
import 'package:the_wall/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TheWall());
}

class TheWall extends StatelessWidget {
  const TheWall({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.grey,
          useMaterial3: false,
          fontFamily: 'SanFrancisco',
        ),
        home: LoginPage(),
      ),
    );
  }
}
