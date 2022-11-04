// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:foodji_ui/misc/app_util.dart';
import 'package:foodji_ui/widgets/app_text.dart';

class ReorderableTextFormFields extends StatefulWidget {
  ReorderableTextFormFields(
      {Key? key,
      this.color,
      this.includeDivider = true,
      required this.scrollController,
      required this.items,
      required this.newItem,
      this.hasCustomListTile = false,
      this.custombuildTenableListTile,
      required this.onChanged,
      required this.validator})
      : super(key: key);

  final Color? color;
  final bool includeDivider;
  final ScrollController scrollController;
  List items;
  final dynamic newItem;
  final bool hasCustomListTile;
  final ListTile Function(int)? custombuildTenableListTile;
  final Function onChanged;
  final String? Function(String?)? validator;

  @override
  AppReorderableTextFormFieldsState createState() =>
      AppReorderableTextFormFieldsState();
}

class AppReorderableTextFormFieldsState
    extends State<ReorderableTextFormFields> {
  List items = [];

  @override
  Widget build(BuildContext context) {
    items = widget.items;

    return Column(
      children: [
        ReorderableListView.builder(
          key: ValueKey('${widget.key}-list'),
          shrinkWrap: true,
          onReorder: onReorder,
          itemCount: items.length,
          scrollController: widget.scrollController,
          itemBuilder: (context, index) {
            return Material(
              key: ValueKey('m_${widget.key}-${AppUtil.intKeys[index]}'),
              color: widget.color ?? Colors.transparent,
              child: widget.hasCustomListTile
                  ? widget.custombuildTenableListTile!(index)
                  : buildTenableListTile(index),
            );
          },
        ),
        ElevatedButton(
            onPressed: () {
              setState(() => items.add(widget.newItem));
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    AppUtil().lastTile)),
            child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                child: const AppText(text: 'Add'))),
      ],
    );
  }

  ListTile buildTenableListTile(int index) => ListTile(
        key: ValueKey('lt_${widget.key}-${AppUtil.intKeys[index]}'),
        leading: Column(
          children: [
            Text("${index + 1}"),
            IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => setState(() => items.removeAt(index)))
          ],
        ),
        title: TextFormField(
            initialValue: items[index],
            decoration: const InputDecoration(
              hintText: 'Step', // TODO : i10n
            ),
            maxLength: 300,
            minLines: 1,
            maxLines: 6,
            validator: widget.validator,
            onSaved: (value) {
              items[index] = value!;
              widget.onChanged(items);
            }),
      );

  onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final String item = items[oldIndex];
      items.removeAt(oldIndex);
      items.insert(newIndex, item);
    });
    widget.onChanged.call(items);
  }
}
