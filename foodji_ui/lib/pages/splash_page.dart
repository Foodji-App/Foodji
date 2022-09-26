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
    return Scaffold(
        body: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('img/background-gradient.png'),
                    fit: BoxFit.fill))));
  }
}

// class SplashPageState extends State<SplashPage> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
//       return Scaffold(
//           body: PageView.builder(
//               scrollBehavior: null,
//               itemBuilder: (_, index) {
//                 return Container(
//                   width: double.maxFinite,
//                   height: double.maxFinite,
//                   child: Stack(children: [
//                     Positioned(
//                         top: 0,
//                         left: 0,
//                         child: Container(
//                             width: double.maxFinite,
//                             height: double.maxFinite,
//                             decoration: const BoxDecoration(
//                                 image: DecorationImage(
//                                     image: AssetImage(
//                                         'img/background-gradient.png'),
//                                     fit: BoxFit.fill)))),
//                     Positioned(
//                         top: 0,
//                         left: 20,
//                         child: Container(
//                             height: double.maxFinite,
//                             decoration: const BoxDecoration(
//                                 image: DecorationImage(
//                                     image: AssetImage(
//                                         'img/background-bookmark.png'),
//                                     fit: BoxFit.contain)))),
//                     Positioned(
//                         top: 0,
//                         left: 20,
//                         child: Container(
//                             decoration: const BoxDecoration(
//                                 image: DecorationImage(
//                                     image: AssetImage('img/splash-fr.png'),
//                                     fit: BoxFit.contain))))
//                   ]),
//                 );
//               }));
//     });
//   }
// }
