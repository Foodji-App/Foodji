// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import '../../misc/colors.dart';
import '../../widgets/app_text.dart';

class ShowRecipeSteps extends StatelessWidget {
  List<String> steps;

  ShowRecipeSteps({Key? key, required this.steps}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return Center(
      child: ListView.separated(
          scrollDirection: Axis.vertical,
          itemCount: steps.length,
          itemBuilder: (context, index) {
            return ListTile(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(25),
                      bottomLeft: Radius.circular(10))),
              tileColor: AppColors.highlightColor1,
              textColor: AppColors.textColor,
              leading: CircleAvatar(
                backgroundColor: AppColors.highlightColor2,
                child: AppText(
                  color: AppColors.backgroundColor,
                  text: (index + 1).toString(),
                ),
              ),
              title: Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: AppText(text: steps[index])),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(
              height: 10,
            );
          }),
    );
  }
}
