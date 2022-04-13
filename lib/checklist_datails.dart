import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterorderto/checkbox_state.dart';

class CheckDetails extends StatefulWidget {
  final CheckBoxState check;

  Function(String, bool) callback;

  CheckDetails(this.check, this.callback, {Key? key}) : super(key: key);

  @override
  State<CheckDetails> createState() => _CheckDetailsState();
}

class _CheckDetailsState extends State<CheckDetails> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      onChanged: (value) => setState(() {
        widget.check.value = value!;
        widget.callback(widget.check.title,widget.check.value);
      }),
      value: widget.check.value,
      controlAffinity: ListTileControlAffinity.leading,
      title: Text(widget.check.title),
    );
  }
}
