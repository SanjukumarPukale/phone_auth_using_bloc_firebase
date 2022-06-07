import 'package:firebase_auth_bloc/screens/sign_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit/auth_cubit.dart';
import '../cubit/auth_cubit/auth_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthLoggedOutState) {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => SignInScreen(),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return CupertinoButton(
                  child: Text('Log out'),
                  onPressed: () {
                    BlocProvider.of<AuthCubit>(context).logOut();
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
