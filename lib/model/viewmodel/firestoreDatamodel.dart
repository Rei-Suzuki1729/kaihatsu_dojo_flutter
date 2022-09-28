import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kaihatsu_dojo_flutter/model/symplemodel/dayModel.dart';
import 'package:kaihatsu_dojo_flutter/objects/record.dart';

///provider
final firestoreDataModelProvider =
    StateNotifierProvider<DataModelState, DataModel>((ref) => DataModelState());

///properties
class DataModel {
  DataModel({required this.newage});
  String newage;
}

///model
class DataModelState extends StateNotifier<DataModel> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Map<DateTime, double> gotDateAndcondition = {};
  final _dayModel = DayModel();
  QueryDocumentSnapshot? lastVisible;
  bool hitTheBottom = false;

  DataModelState() : super(DataModel(newage: ''));

  ///firestoreのデータ(今月)をRecord型のオブジェクトにして監視
  Future<List<Record>> getDateAndcondition() async {
    final _email = auth.currentUser!.email;
    List<Record> recordList = [];


    final _collectionRef = firestore
        .collection('user')
        .doc(_email)
        .collection(_dayModel.getYearAndMonthString(date: DateTime.now()))
        .orderBy('date');

    QuerySnapshot _collection = await _collectionRef.get();

    //取得件数０だったらリターン（snapshots.docs[ここがマイナスになったら怒られる]）
    if (_collection.docs.isEmpty) {
      print('first get nothing');
      hitTheBottom = true;
      return recordList;
    }
    lastVisible = _collection.docs[_collection.docs.length - 1];
    // ignore: join_return_with_assignment
    recordList = _collection.docs.map((doc) => Record(doc)).toList();
    return recordList;

    // final recordList = _collection.docs.map((e) => Record(e)).toList();
    // print(recordList[0]);
    // state = DataModel(recordList: recordList);
  }

  Future<String> maxcondition () async {
    String _condition;
    List<dynamic> _conditionList = [];
    final _email = auth.currentUser!.email;
    final _collectionRef = firestore
        .collection('user')
        .doc(_email)
        .collection(_dayModel.getYearAndMonthString(date: DateTime.now()))
        .orderBy('condition');

    final _collection = await _collectionRef.get();
    _conditionList = _collection.docs.map((e) => e.data()['condition']).toList();

    _condition = _conditionList[0];
    return _condition;
  }

  // ///リストの単純な型変換
  // List<double> typeChange ({required List list}) {
  //   List<double> changedList = [];
  //   changedList = list as List<double>;
  //   return changedList;
  // }

  ///最新の身長データをとってくる
  Future<void> getAgeData () async {
    final _email = auth.currentUser!.email;
    final _collectionRef = firestore
        .collection('user')
        .doc(_email)
        .collection(_dayModel.getYearAndMonthString(date: DateTime.now()))
        .orderBy('date');

    final _doc = await _collectionRef.get();
    final _data = _doc.docs.map((e) => e.data()['age']).toList();
    state = DataModel(newage: _data[0]);
  }

}
