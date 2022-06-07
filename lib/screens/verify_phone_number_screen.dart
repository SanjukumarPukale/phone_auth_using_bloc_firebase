import 'package:firebase_auth_bloc/cubit/auth_cubit/auth_state.dart';
import 'package:firebase_auth_bloc/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit/auth_cubit.dart';

class VerifyPhoneNumberScreen extends StatelessWidget {

  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Phone Number'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 30,
                vertical: 20,
              ),
              child: Column(
                children: [
                  TextField(
                    controller: otpController,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '6-Digit OTP',
                      counterText: '',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if(state is AuthLoggedInState){
                        Navigator.popUntil(context, (route) => route.isFirst);  // this will restrict user to go back to previous page
                        Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => HomeScreen(),));
                      }
                      else if(state is AuthErrorState){
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(state.error),
                            duration: Duration(microseconds: 6000),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      
                      if(state is AuthLodingState){
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: CupertinoButton(
                          child: Text('Verify'),
                          color: Colors.blue,
                          onPressed: () {
                            BlocProvider.of<AuthCubit>(context).verifyOTP(otpController.text);
                          },
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
