import 'package:firebase_auth_bloc/cubit/auth_cubit/auth_cubit.dart';
import 'package:firebase_auth_bloc/screens/home_screen.dart';
import 'package:firebase_auth_bloc/screens/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/auth_cubit/auth_state.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter_bloc Auth firebase',
        home: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (previous, current) {
            return previous is AuthInitialState;
          },
          builder: (context, state) {

            if(state is AuthLoggedInState){
              return HomeScreen();
            }
            else if(state is AuthLoggedOutState){
              return SignInScreen();
            }
            else {
              return Scaffold();
            }
          },
        ),
      ),
    );
  }
}
