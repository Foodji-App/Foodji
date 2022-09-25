import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('img/background-gradient.png'),
              fit: BoxFit.cover)),
      child: Container(
          margin: const EdgeInsets.only(left: 20),
          height: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('img/background-bookmark.png'),
                  fit: BoxFit.fill)),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            Container(
                margin: const EdgeInsets.only(left: 20),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('img/splash-fr.png'),
                        fit: BoxFit.fill)))
          ])),
    )));
  }
}
