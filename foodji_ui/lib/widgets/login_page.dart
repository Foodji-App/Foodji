import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/app_cubits.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthStateListener<EmailAuthController>(
        listener: (oldState, newState, controller) {
          if (newState is SignedIn) {
            print('je suis en vie');
            BlocProvider.of<AppCubits>(context).retrieveUserData();
          }
          return null;
        },
        child: const EmailForm());
  }
}
