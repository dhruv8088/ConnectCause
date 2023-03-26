import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:io';

class MyAlertDialog extends StatefulWidget {
  @override
  _MyAlertDialogState createState() => _MyAlertDialogState();
}

class _MyAlertDialogState extends State<MyAlertDialog> {
  List<List<TextEditingController>> _controllers = [
    [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ],
  ];

  List<List<String>> _values = [[]];
  String tempPath = "";

  Map<String , dynamic>? UserMap;
  List<dynamic> followerList = [];
  bool isLoading = false;
  Future<void> getFollowers() async{
    FirebaseAuth _auth = FirebaseAuth.instance;
    DocumentSnapshot userSnapshot = (await FirebaseFirestore.instance.collection("users").doc(_auth.currentUser?.email).get());


    Map<String, dynamic> userMap = userSnapshot.data() as Map<String, dynamic>;
            // for(int i =0;i<value.data()!['followers'].length;i++) {
            //   followerList = (value.data()!['followers']);
            // }
            followerList = (userMap!['followers']);
            print("followerList inside setStae:${followerList}");




        }
  //
  //
  // }


  void _convertToPDF() async {
    // Create a new PDF document
    final pdf = pw.Document();
    // await getFollowers();
    print("followerList inside convert to pdf : ${followerList}");
    print("inside pdf convertor:${pdf}");

    // Add a page to the PDF document
    pdf.addPage(pw.Page(
      pageFormat: PdfPageFormat.a4,
      margin: pw.EdgeInsets.all(32),
      build: (context) {
        // Create a widget tree that represents the content of the PDF page
        return pw.Column(
          children: [
            for (int i = 0; i < _values.length; i++)
              pw.Row(
                children: [
                  for (int j = 0; j < 3; j++)
                    pw.Expanded(
                      child: pw.Text(_values[i][j]),
                    ),
                ],
              ),
          ],
        );
      },
    ));

    // Save the PDF document to disk
    final bytes = await pdf.save();
    final directory = await getTemporaryDirectory();

    tempPath = directory.path;
    print("temp path: ${tempPath}");

    // Create a file in the temporary directory with the PDF bytes
    final file = File('${directory.path}/example.pdf');
    await file.writeAsBytes(bytes);

    // Open the PDF file in an external application
    // await OpenFile.open(file.path);
    // Do something with the bytes, such as sending them to a server or writing them to a file
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Enter your details"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (int i = 0; i < _controllers.length; i++)
            Row(
              children: <Widget>[
                for (int j = 0; j < 3; j++)
                  Expanded(
                    child: TextFormField(
                      controller: _controllers[i][j],
                      decoration: InputDecoration(
                        hintText: "Column ${j + 1}, Row ${i + 1}",
                      ),
                    ),
                  ),
              ],
            ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: Text("Add"),
                onPressed: () {
                  List<TextEditingController> newControllers = [
                    TextEditingController(),
                    TextEditingController(),
                    TextEditingController(),
                  ];
                  List<String> newValues = [];
                  setState(() {
                    _controllers.add(newControllers);
                    _values.add(newValues);
                  });
                },
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          child: Text("CANCEL"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text("OK"),
          onPressed: () async {
            for (int i = 0; i < _controllers.length; i++) {
              List<String> rowValues = [];
              for (int j = 0; j < 3; j++) {
                String value = _controllers[i][j].text;
                print("inside for:${value}");
                rowValues.add(value);
                _values[i].add(value);
              }
            }
            _convertToPDF();
            // Map<String , dynamic>? UserMap;
            // List<dynamic> followerList = [];
            // bool isLoading = false;
            // FirebaseAuth _auth = FirebaseAuth.instance;
            //  FirebaseFirestore.instance.collection("users").doc(_auth.currentUser?.email).get().then(
            //     (value) {
            //       print("inside setState:${value.data()}");
            //       setState(() {
            //         UserMap = value.data();
            //         // for(int i =0;i<value.data()!['followers'].length;i++) {
            //         //   followerList = (value.data()!['followers']);
            //         // }
            //           followerList = (value.data()!['followers']);
            //           print("followerList inside setStae:${followerList}");
            //
            //           isLoading = true;
            //           });
            //           if(isLoading){
            //           return;
            //           }
            //       }
            //       );
              await getFollowers();
              print("inside send email:${followerList}${UserMap}" );
              List<String> fll = [];
              for(int i=0;i<followerList.length;i++) {
                fll.add(followerList[i]);
              }
              String str="Thank you for your support!\n\n";
              for(int i =0;i<_values.length;i++) {

                  str = str + "Donated By: ${_values[i][0]}; \t Donation: ${_values[i][1]}; \t Donated to: ${_values[i][2]}\n\n";

              }

            final Email send_email = Email(

              body: str,
              subject: 'Donation data',
              recipients: ['${fll[0]}'],
              bcc: fll,

              // attachmentPaths: ['${tempPath}.example.pdf'],
              isHTML: false,
            );

            await FlutterEmailSender.send(send_email);

            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}