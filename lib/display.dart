
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'Dbhelper/MongoDbModel.dart';
import 'Dbhelper/mongodb.dart';
class MongoDbInsert extends StatefulWidget {
  MongoDbInsert({this.prevdata});
  final prevdata;
  @override
  _MongoDbInsertState createState() => _MongoDbInsertState();
}

class _MongoDbInsertState extends State<MongoDbInsert> {
  @override
  void initState() {

    super.initState();
    print(widget.prevdata);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: FutureBuilder(
            future: MongoDatabase.getData(),
            builder: (context,AsyncSnapshot snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);

              }
              else{
                if(snapshot.hasData){
                  var totaldata= snapshot.data.length;
                  print(totaldata);
                  return ListView.builder(
                      reverse: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context,index) {
                        return displayCard(MongoDbModel.fromJson(snapshot.data[index]));

                      });

                }

                else{
                  return Center(child: Text("No data"));
                }
              }

            }
        ),
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
            FlatButton(onPressed:()
            {/*Navigator.push(context, MaterialPageRoute(
                    builder: (_) => ViewQueryData(query: data.id,)));*/},
                child: Text("View"))

          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,


        ),
      ),

    );
  }
}
