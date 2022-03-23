
import 'package:flutter/material.dart';
import 'query.dart';
import 'querystatus.dart';
class status extends StatefulWidget {
  @override
  _statusState createState() => _statusState();
}
class _statusState extends State<status> {
  var snameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(


          children:[ TextField(
            controller: snameController,
            decoration: const InputDecoration(hintText: "Enter status(success or failure):"),),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () {

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => Querystatus(
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
