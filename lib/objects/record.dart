import 'package:cloud_firestore/cloud_firestore.dart';

class Record {
  Record (DocumentSnapshot doc) {
    Map<String, dynamic> extractdata = doc.data() as Map<String, dynamic>;
    this.documentReference = doc.reference;
    this.nickname = extractdata['nickname'];
    this.DiffCondition = extractdata['DiffCondition'];
    this.Condition = extractdata['Condition'];
    this.age = extractdata['age'];
    this.memo = extractdata['memo'];
    final Timestamp timestamp = extractdata['date'];
    this.date = timestamp.toDate();
  }

  String? nickname;
  String? age;
  String? Condition;
  String? memo;
  String? DiffCondition;
  DateTime? date;
  DocumentReference? documentReference;
}