
import 'package:basecode/components/show_snackbar.dart';
import 'package:basecode/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProfileRepository{
  final FirebaseFirestore _firestore;
  UserProfileRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _users =>
      _firestore.collection('users');

  Future<void> editProfile(UserModel user,BuildContext context) async {
    try {
      await _users.doc(user.uid).update(user.toMap());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return showSnackBar(context, e.toString());
    }
  }
}