import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/app_cubits.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.dark(),
            home: SignInScreen(
              providerConfigs: const [
                EmailProviderConfiguration(),
              ],
              headerBuilder: (context, constraints, shrinkOffset) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: Image.asset('img/logo.png'),
                );
              },
              subtitleBuilder: (context, action) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: action == AuthAction.signIn
                      ? Text(AppLocalizations.of(context)!
                          .authentification_sign_in)
                      : Text(AppLocalizations.of(context)!
                          .authentification_sign_up),
                );
              },
              footerBuilder: (context, action) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    AppLocalizations.of(context)!
                        .authentification_sign_up_instructions,
                    style: const TextStyle(color: Colors.grey),
                  ),
                );
              },
              sideBuilder: (context, shrinkOffset) {
                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Image.asset('img/logo-black.png'),
                  ),
                );
              },
            ),
          );
        }
        BlocProvider.of<AppCubits>(context).retrieveUserData();
        return const SizedBox.shrink();
      },
    );
  }
}
