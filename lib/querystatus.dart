
import 'package:flutter/material.dart';

import 'Dbhelper/MongoDbModel.dart';
import 'Dbhelper/mongodb.dart';

class Querystatus extends StatefulWidget {

  Querystatus({this.query});
  final query;
  @override
  _QuerystatusState createState() => _QuerystatusState();
}

class _QuerystatusState extends State<Querystatus> {

  void initState() {

    super.initState();
    print(widget.query);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(

          child: FutureBuilder(
              future: MongoDatabase.getQuerystatus(widget.query),
              builder: (context, AsyncSnapshot snapshot){

                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(
                    child:CircularProgressIndicator(),
                  );
                }
                else{
                  if(snapshot.hasData){
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context,index) {
                          return displayCard(MongoDbModel.fromJson(snapshot.data[index]));

                        });
                  }
                  else{
                    return Center(
                      child: Text("data not found"),
                    );
                  }
                }
              })
      ),
    );
  }
  Widget displayCard(MongoDbModel data){
    return Card(
      color: Colors.blueGrey,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Text("${data.id}"),
            SizedBox(height: 10,),
            Text("${data.firstName}"),
            SizedBox(height: 10,),
            Text("${data.date}"),
            SizedBox(height: 10,),
            FlatButton(onPressed:() {}, child: Text("View"))

          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,


        ),
      ),

    );
  }
}
