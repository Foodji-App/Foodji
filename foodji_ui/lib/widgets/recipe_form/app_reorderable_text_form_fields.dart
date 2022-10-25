import 'package:flutter/material.dart';

import '../../misc/colors.dart';

class ReorderableTextFormFields extends StatefulWidget {
  ReorderableTextFormFields(
      {Key? key,
      required this.scrollController,
      required this.items,
      this.hasCustomListTile = false,
      this.custombuildTenableListTile,
      required this.onChanged,
      required this.validator})
      : super(key: key);
  final ScrollController scrollController;
  List items;
  final bool hasCustomListTile;
  final ListTile Function(int)? custombuildTenableListTile;
  final Function onChanged;
  final String? Function(String?)? validator;

  @override
  AppReorderableTextFormFieldsState createState() =>
      AppReorderableTextFormFieldsState();
}

class AppReorderableTextFormFieldsState extends State<ReorderableTextFormFields> {
  List items = [];

  @override
  Widget build(BuildContext context) {
    items = widget.items;

    return Scaffold(
        body: Column(
      children: [
        ReorderableListView.builder(
          shrinkWrap: true,
          onReorder: onReorder,
          itemCount: items.length,
          scrollController: widget.scrollController,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                key: ValueKey(items[index]),
                child: widget.hasCustomListTile ? widget.custombuildTenableListTile!(index) : buildTenableListTile(index));
          },
        ),
        ElevatedButton(
            onPressed: () {
              setState(() => items.add(''));
            },
            child: const Text('Add')),
      ],
    ));
  }

  ListTile buildTenableListTile(int index) => ListTile(
        key: ValueKey(items[index]),
        tileColor: AppColors.highlightColor2,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        leading: Text("${index + 1}"),
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
        trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () => setState(() => items.removeAt(index))),
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
