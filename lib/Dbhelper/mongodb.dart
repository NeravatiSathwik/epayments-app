import 'dart:developer';

import 'MongoDbModel.dart';
import 'constants.dart';
import 'package:mongo_dart/mongo_dart.dart';

class MongoDatabase{
  static var db, usercollection;
  static connect() async{
    db= await Db.create(MONGO_CONN_URL);
    await db.open();
    //inspect(db);

    usercollection =db.collection(USER_COLLECTION);

  }
  static Future<List<Map<String,dynamic>>> getData() async{
    final arrData=await usercollection.find().toList();
    return arrData;
  }
  static Future<List<Map<String,dynamic>>>getQueryData(query) async{
    print(query);
    final data = await usercollection.find(where.eq('firstName',query)).toList();
    return data;
  }
  static Future<List<Map<String,dynamic>>>getQueryViewData(query) async{
    print(query);
    final data = await usercollection.find(where.eq('id',query)).toList();
    return data;
  }

  static Future<List<Map<String,dynamic>>>getQuerystatus(query) async{
    print(query);
    final data = await usercollection.find(where.eq('status',query)).toList();
    return data;
  }
  static Future<String> insert(MongoDbModel data) async{
    try {
      var result = await usercollection.insertOne(data.toJson());
      if(result.isSuccess) {
        return "data inserted";
      }
      else{
        return "not inseted";
      }
    }catch(e){
      print(e.toString());
      return e.toString();
    }
  }
}