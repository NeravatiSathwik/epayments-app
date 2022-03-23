import 'package:flutter/material.dart';
import 'query.dart';
class dialog extends StatefulWidget {
  @override
  _dialogState createState() => _dialogState();
}
class _dialogState extends State<dialog> {
  var snameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(

          children:[ TextField(
            controller: snameController,
            decoration: const InputDecoration(hintText: "Enter the name:"),),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => QueryDatabase(
                          query: snameController.text,
                        )));
              },
              child: Text('TextButton'),
            )
          ],
          ),

      ),
    );
  }
}
