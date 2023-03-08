import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _EditFieldDialog extends StatefulWidget {
  final String initialValue;
  final String title;

  _EditFieldDialog({
    required this.initialValue,
    required this.title,
  });

  @override
  _EditFieldDialogState createState() => _EditFieldDialogState();
}

class _EditFieldDialogState extends State<_EditFieldDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.title),
      content: TextField(
        controller: _controller,
      ),
      actions: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: Text('Save'),
          onPressed: () => Navigator.of(context).pop(_controller.text),
        ),
      ],
    );
  }
}