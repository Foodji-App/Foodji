import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/app_cubits.dart';
//import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterfire_ui/auth.dart';

import '../widgets/app_text.dart';

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
                  child: AppText(
                    text: action == AuthAction.signIn
                        //TODO - AppLocalizations retourne null
                        ? /*AppLocalizations.of(context)!.authentification_sign_in*/ "Welcome to Foodji! Sign in or create a new account to discover everything we have to offer."
                        : /*AppLocalizations.of(context)!
                            .authentification_sign_up*/
                        "Welcome to Foodji! Sign up by entering your informations below.",
                    size: AppTextSize.normal,
                    color: Colors.grey,
                    backgroundColor: Colors.transparent,
                  ),
                );
              },
              footerBuilder: (context, action) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: AppText(
                    text: /*AppLocalizations.of(context)!
                        .authentification_sign_up_instructions*/
                        "By using Foodji, you agree to terms and conditions we haven't exactly defined yet. When you think about it, it's like choosing the red pill. Be a Neo. We can only promise you one thing for joining us ; we have cookie... recipes.",
                    size: AppTextSize.normal,
                    color: Colors.grey,
                    backgroundColor: Colors.transparent,
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
