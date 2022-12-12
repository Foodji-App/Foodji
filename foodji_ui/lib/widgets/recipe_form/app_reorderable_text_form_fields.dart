// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:foodji_ui/misc/app_util.dart';
import 'package:foodji_ui/widgets/app_text.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReorderableTextFormFields extends StatefulWidget {

  ReorderableTextFormFields(
      {Key? key,
      this.color,
      this.includeDivider = true,
      required this.scrollController,
      required this.items,
      required this.newItem,
      this.hintText,
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
  final String? hintText;
  final bool hasCustomListTile;
  final Widget Function(int)? custombuildTenableListTile;
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
        ReorderableListView(
          key:  ValueKey('reordlv-${widget.key}'),
          shrinkWrap: true,
          onReorder: onReorder,
          scrollController: widget.scrollController,
          children: _getListItems(),
        ),
        ElevatedButton(
            onPressed: () {
              setState(() => items.add(widget.newItem));
            },
            style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    AppUtil.lastTile)),
            child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(vertical: 10),
                alignment: Alignment.center,
                child: const AppText(text: 'Add'))),
      ],
    );
  }

  List<Widget> _getListItems() {
    return items
        .map((item) => widget.hasCustomListTile
            ? widget.custombuildTenableListTile!(items.indexOf(item))
            : _buildTenableListTile(items.indexOf(item)))
        .toList();
  }

  Widget _buildTenableListTile(int index) => Dismissible(
        key: ValueKey('tenable-dism-${widget.key}-${AppUtil.keyDirtyFix[index]}'),
        confirmDismiss: (direction) =>
            Future.value(direction == DismissDirection.endToStart),
        onDismissed: (direction) {
          setState(() {
            items.removeAt(index);
            widget.onChanged(items);
          });

          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('item dismissed')));
        },
        background: Container(color: Colors.red),
        child: Material(
        key: ValueKey('tenable-mat-${widget.key}-${AppUtil.keyDirtyFix[index]}'),
          color: widget.color ?? Colors.transparent,
          child: ListTile(
            key: ValueKey('tenable-lt-${widget.key}-${AppUtil.keyDirtyFix[index]}'),
            title: TextFormField(
                initialValue: items[index],
                decoration: InputDecoration(
                  hintText: widget.hintText ?? AppLocalizations.of(context)!.form_item,
                ),
                maxLength: 300,
                minLines: 1,
                maxLines: 6,
                validator: widget.validator,
                onChanged: (value) {
                  items[index] = value;
                  widget.onChanged(items);
                }),
            //trailing: const Icon(Icons.drag_handle),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.drag_handle,
                  color: Colors.blueGrey,
                ),
              ],
            ),
          ),
        ),
      );

  onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    setState(() {
      var item = items[oldIndex];
      items.removeAt(oldIndex);
      items.insert(newIndex, item);
    });
    widget.onChanged.call(items);
  }
}
