import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/app_cubit_states.dart';
import '../cubit/app_cubits.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  SplashPageState createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      //Delayed to simulate loading
      Future.delayed(const Duration(seconds: 3),
          () => BlocProvider.of<AppCubits>(context).getInitialData());
      return Scaffold(
          body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('img/background-gradient.png'),
                fit: BoxFit.fill)),
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.hardEdge,
          alignment: Alignment.centerLeft,
          children: [
            Positioned(
              left: 0,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('img/background-bookmark.png'),
                        fit: BoxFit.fill),
                  )),
            ),
            Positioned(
              left: 0,
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('img/splash-fr.png'),
                        fit: BoxFit.fitWidth),
                  )),
            ),
          ],
        ),
      ));
    });
  }
}
