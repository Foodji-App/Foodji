import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodji_ui/misc/colors.dart';
import 'package:foodji_ui/models/unit_type_convertible_enum.dart';
import 'package:foodji_ui/models/unit_type_volume_map.dart';
import 'package:foodji_ui/models/unit_type_weight_map.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubit/app_globals.dart' as globals;
import '../cubit/app_cubit_states.dart';
import '../cubit/app_cubits.dart';
import '../misc/app_util.dart';

class ConverterPageV1 extends StatefulWidget {
  const ConverterPageV1({Key? key}) : super(key: key);

  @override
  ConverterPageV1State createState() => ConverterPageV1State();
}

class ConverterPageV1State extends State<ConverterPageV1> {
  final TextEditingController _controller = TextEditingController();
  num measurement = 0;
  num result = 0;
  String originUnit = UnitTypeConvertible.values.first.name;
  String destinationUnit = "";
  List<DropdownMenuItem<String>> destinationUnitType = [
    const DropdownMenuItem<String>(value: "", child: Text(""))
  ];

  String getUnitString(unit) {
    if (unit == UnitTypeConvertible.cup.name) {
      return AppLocalizations.of(context)!.unit_type_cup;
    } else if (unit == UnitTypeConvertible.fluidOunce.name) {
      return AppLocalizations.of(context)!.unit_type_fluidOunce;
    } else if (unit == UnitTypeConvertible.gram.name) {
      return AppLocalizations.of(context)!.unit_type_gram;
    } else if (unit == UnitTypeConvertible.kilogram.name) {
      return AppLocalizations.of(context)!.unit_type_kilogram;
    } else if (unit == UnitTypeConvertible.liter.name) {
      return AppLocalizations.of(context)!.unit_type_liter;
    } else if (unit == UnitTypeConvertible.milliliter.name) {
      return AppLocalizations.of(context)!.unit_type_milliliter;
    } else if (unit == UnitTypeConvertible.ounce.name) {
      return AppLocalizations.of(context)!.unit_type_ounce;
    } else if (unit == UnitTypeConvertible.pound.name) {
      return AppLocalizations.of(context)!.unit_type_pound;
    } else if (unit == UnitTypeConvertible.tablespoon.name) {
      return AppLocalizations.of(context)!.unit_type_tablespoon;
    } else if (unit == UnitTypeConvertible.teaspoon.name) {
      return AppLocalizations.of(context)!.unit_type_teaspoon;
    } else {
      return unit;
    }
  }

  getOriginUnitTypes() {
    List<DropdownMenuItem> unitTypes =
        UnitTypeConvertible.values.map((UnitTypeConvertible el) {
      return DropdownMenuItem<String>(
          value: el.name, child: Text(getUnitString(el.name)));
    }).toList();
    originUnit = unitTypes[0].value;
    /*unitTypes.forEach((el) => print("list element : ${el.value}"));*/
    return unitTypes;
  }

  setMeasurement(value) {
    setState(() {
      measurement = value != "" ? num.parse(value) : 0;
    });
    convert(destinationUnit);
  }

  setDestinationUnitType(String? originUnitType) {
    setState(() {
      originUnit = originUnitType ?? UnitTypeConvertible.values.first.name;
      if (unitTypeVolume.containsKey(originUnitType)) {
        destinationUnitType = unitTypeVolume.keys
            .map((el) => DropdownMenuItem<String>(
                value: el.toString(),
                child: Text(getUnitString(el.toString()))))
            .toList();
        destinationUnit = unitTypeVolume.keys.first.toString();
      } else if (unitTypeWeight.containsKey(originUnitType)) {
        destinationUnitType = unitTypeWeight.keys
            .map((el) => DropdownMenuItem<String>(
                value: el.toString(),
                child: Text(getUnitString(el.toString()))))
            .toList();
        destinationUnit = unitTypeWeight.keys.first.toString();
      } else {}
    });
  }

  convert(newDestinationUnit) {
    setState(() {
      destinationUnit = newDestinationUnit;
    });
    _controller.text = AppUtil()
        .unitConvert(measurement, originUnit, destinationUnit)
        .toString();
  }

  // testPrint(context) {
  //   print("searched in list 1 : $originUnit");
  //   UnitType.values.forEach((el) => print("list 1 element : ${el.name}"));
  //   print("searched in list 2 : $destinationUnit");
  //   destinationUnitType
  //       .forEach((el) => print("list 2 element : ${el.value.toString()}"));
  // }

  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) => testPrint(context));
    globals.setActivePage(4);
    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      return Scaffold(
          body: Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('img/background-gradient.png'),
                      fit: BoxFit.fill)),
              alignment: Alignment.center,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Material(
                            color: AppColors.backgroundColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(0)),
                            child: TextField(
                              decoration: const InputDecoration(hintText: '0'),
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              onChanged: (v) => setMeasurement(v),
                            ))),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Material(
                            color: AppColors.backgroundColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(0)),
                            child: InputDecorator(
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppColors.backgroundColor,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                        value: originUnit,
                                        items: getOriginUnitTypes(),
                                        onChanged: (destinationUnit) =>
                                            setDestinationUnitType(
                                                destinationUnit)))))),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Material(
                            color: AppColors.backgroundColor,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(0)),
                            child: InputDecorator(
                                decoration: InputDecoration(
                                    filled: true,
                                    fillColor: AppColors.backgroundColor,
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0))),
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                        value: destinationUnit,
                                        items: destinationUnitType,
                                        onChanged: (destinationUnit) =>
                                            convert(destinationUnit)))))),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Material(
                            color: AppColors.backgroundColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(0),
                                topRight: Radius.circular(0),
                                bottomLeft: Radius.circular(0),
                                bottomRight: Radius.circular(20.0)),
                            child: TextField(
                              controller: _controller,
                              autofocus: false,
                              readOnly: true,
                            )))
                  ])));
    });
  }
}
