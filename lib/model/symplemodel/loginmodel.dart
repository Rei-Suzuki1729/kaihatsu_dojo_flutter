import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kaihatsu_dojo_flutter/objects/userdata.dart';


class LoginModel {

  String? nickname;
  String? email;
  String? stringAge;
  bool? isLoginLoading;
  bool? isUserLogin;
  String? uid;
  String exportedAge = '';
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  UserData? userData;


  ///signOut
  Future signOut() async {
    await auth.signOut();
    userData = null;
  }

  ///firestoreにユーザー情報を登録
  Future<void> addUsersName(
      {required nickname, required stringAge, required email}) async {
    final _doc = firestore.collection('user').doc(email);
    await _doc.set({
      'nickname': nickname,
      //'userId': state.uid,
      'email': email,
      'Age': stringAge,
    });
  }

  ///一度入力した年齢を扱えるようにしておく（年齢が頻繁に変化しないものとしてデフォルトでRecordPageに入力しておく）
  String recordAge ({required Age}) {
    exportedAge = Age;
    return exportedAge;
  }

  ///login中
  void startLoginLoading() {
    isLoginLoading = true;
  }

  ///login中でない
  void endLoginLoading() {
    isLoginLoading = false;
  }

  Future<void> getUserData() async {
    // final uid = auth.currentUser!.uid;
    final snapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(email)
        .get();
    userData = UserData(snapshot);
    print('--------------------------user info get');
  }

  Future<UserData?> getUserDataReturn() async {
    //final uid = auth.currentUser!.uid;
    final snapshot = await firestore.collection('user').doc(email).get();
    userData = UserData(snapshot);
    print('----------------------------user info get');
    return userData;
  }
}