import 'package:firebase_auth_bloc/screens/verify_phone_number_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/auth_cubit/auth_cubit.dart';
import '../cubit/auth_cubit/auth_state.dart';

class SignInScreen extends StatelessWidget {
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in with phone'),
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
                    controller: phoneController,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Phone Number',
                      counterText: '',
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      
                      if(state is AuthCodeSentState){
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => VerifyPhoneNumberScreen(),));
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
                          child: Text('Sign in'),
                          color: Colors.blue,
                          onPressed: () {
                            String phoneNumber = '+91' + phoneController.text;
                            BlocProvider.of<AuthCubit>(context).sendOTP(phoneNumber);
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
