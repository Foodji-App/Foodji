import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodji_ui/models/unit_type_convertible_enum.dart';
import 'package:foodji_ui/models/unit_type_volume_map.dart';
import 'package:foodji_ui/models/unit_type_weight_map.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../cubit/app_globals.dart' as globals;
import '../cubit/app_cubit_states.dart';
import '../cubit/app_cubits.dart';
import '../misc/app_util.dart';
import '../misc/colors.dart';

class ConverterPage extends StatefulWidget {
  const ConverterPage({Key? key}) : super(key: key);

  @override
  ConverterPageState createState() => ConverterPageState();
}

class ConverterPageState extends State<ConverterPage> {
  final TextEditingController _controller = TextEditingController();
  final _scrollController = ScrollController();
  final _formKey = GlobalKey<FormState>();

  List<DropdownMenuItem<String>> _originUnitTypes = [];
  List<DropdownMenuItem<String>> _volumeUnits = [];
  List<DropdownMenuItem<String>> _weightUnits = [];

  num _originValue = 0;
  String _originUnit = "";
  String _destinationUnit = "";

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

  initUnits() {
    var units = UnitTypeConvertible.values
        .map((UnitTypeConvertible el) => DropdownMenuItem<String>(
            value: el.name, child: Text(getUnitString(el.name))))
        .toList();

    _volumeUnits = unitTypeVolume.keys
        .map((el) => DropdownMenuItem<String>(
            value: el.toString(), child: Text(getUnitString(el.toString()))))
        .toList();

    _weightUnits = unitTypeWeight.keys
        .map((el) => DropdownMenuItem<String>(
            value: el.toString(), child: Text(getUnitString(el.toString()))))
        .toList();

    _originUnitTypes = units;
    _originUnit =
        _originUnit == "" ? UnitTypeConvertible.values.first.name : _originUnit;
    _destinationUnit = _destinationUnit == ""
        ? UnitTypeConvertible.values.first.name
        : _destinationUnit;
  }

  convert() {
    String result = AppUtil()
        .unitConvert(_originValue, _originUnit, _destinationUnit)
        .toString();
    _controller.text = num.parse(result) == 0 ? "" : result;
  }

  @override
  Widget build(BuildContext context) {
    globals.setActivePage(4);
    initUnits();
    return BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
      return Scaffold(
          body: Stack(children: [
        Container(
          width: double.maxFinite,
          height: double.maxFinite,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('img/background-gradient.png'),
                  fit: BoxFit.fill)),
        ),
        SingleChildScrollView(
            controller: _scrollController,
            child: Padding(
                padding: const EdgeInsets.all(12),
                child: Form(
                    key: _formKey,
                    child: Material(
                        shape: AppUtil.fullTile,
                        color: AppColors.backgroundColor,
                        child: ListTile(
                            title: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                              Row(children: [
                                Expanded(
                                    flex: 1, child: buildOriginMeasurement()),
                                const SizedBox(width: 12),
                                Expanded(flex: 1, child: buildOriginUnitType())
                              ]),
                              const SizedBox(height: 12),
                              Row(children: [
                                Expanded(
                                    flex: 1, child: buildConversionResult()),
                                const SizedBox(width: 12),
                                Expanded(
                                    flex: 1, child: buildDestinationUnitType())
                              ]),
                            ]))))))
      ]));
    });
  }

  Widget buildOriginMeasurement() {
    return Material(
        color: AppColors.backgroundColor,
        child: TextFormField(
          decoration: const InputDecoration(hintText: '0'),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          onChanged: (v) {
            setState(() => _originValue = v != "" ? num.parse(v) : 0);
            convert();
          },
        ));
  }

  Widget buildOriginUnitType() {
    return DropdownButtonFormField<String>(
        value: _originUnit,
        items: _originUnitTypes,
        onChanged: (String? unit) {
          setState(() => _originUnit = unit!);
          convert();
        });
  }

  Widget buildDestinationUnitType() {
    return unitTypeVolume.containsKey(_originUnit)
        ? buildDestinationUnitTypeVolume()
        : buildDestinationUnitTypeWeight();
  }

  Widget buildDestinationUnitTypeVolume() {
    _destinationUnit = _volumeUnits.first.value!;
    return DropdownButtonFormField<String>(
        value: _destinationUnit,
        items: _volumeUnits,
        onChanged: (unit) {
          setState(() => _destinationUnit = unit!);
          convert();
        });
  }

  Widget buildDestinationUnitTypeWeight() {
    _destinationUnit = _weightUnits.first.value!;
    return DropdownButtonFormField<String>(
        value: _destinationUnit,
        items: _weightUnits,
        onChanged: (unit) {
          setState(() => _destinationUnit = unit!);
          convert();
        });
  }

  Widget buildConversionResult() {
    return Material(
        color: AppColors.backgroundColor,
        // use controller istead of formfield
        child: TextField(
          controller: _controller,
          autofocus: false,
          readOnly: true,
        ));
  }
}
