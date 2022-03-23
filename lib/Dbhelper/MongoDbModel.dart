import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';

MongoDbModel mongoDbModelFromJson(String str) =>
    MongoDbModel.fromJson(json.decode(str));
String mongoDbModelToJson(MongoDbModel data) => json.encode(data.toJson());
var date = new DateTime.now().toString();

class MongoDbModel {
  MongoDbModel({
    required this.id,
    this.date='1',
    this.firstName='name',
    this.status='status',
    this.amount='amount',
    this.mobile='mobile',
  });
  ObjectId id;
  String date;
  String firstName;
  String status;
  String amount;
  String mobile;


  factory MongoDbModel.fromJson(Map<String, dynamic> json) => MongoDbModel(
    id: json["_id"],
    firstName: json["firstName"],
    status: json["status"],
    date: json["date"],
    amount:json['amount'],
    mobile:json['mobile'],


  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    'firstName': firstName,
    'status': status,
    'amount':amount,
    'mobile':mobile,
    'date': new DateTime.now().toString(),
  };
}
