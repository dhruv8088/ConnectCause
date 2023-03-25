import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDropdownBox extends StatefulWidget {
  final List<String> fields;
  final Function(String) onChanged;



  MyDropdownBox({required this.fields, required this.onChanged});

  @override
  _MyDropdownBoxState createState() => _MyDropdownBoxState();
}

class _MyDropdownBoxState extends State<MyDropdownBox> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  String? _selectedField;
  CollectionReference fieldsRef = FirebaseFirestore.instance.collection('users');

  _addSelectedFieldToFirestore() async {
    if (_selectedField != null) {
      await fieldsRef.doc(_auth.currentUser?.email).set({'selected_field': _selectedField});
    }
  }


  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: _selectedField,
      onChanged: (value) {
        setState(() {
          _selectedField = value;
          _addSelectedFieldToFirestore();
        });

      },
      items: widget.fields
          .map((field) => DropdownMenuItem<String>(
        value: field,
        child: Text(field),
      ))
          .toList(),
      decoration: InputDecoration(
        labelText: 'Select a field',
        border: OutlineInputBorder(),
      ),
    );
  }
}