import 'package:basecode/components/show_snackbar.dart';
import 'package:basecode/model/category_model.dart';
import 'package:basecode/model/expense_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class ExpenseRepository {
  ExpenseRepository();

  CollectionReference get _expense =>
      FirebaseFirestore.instance.collection('expense');
  CollectionReference get _category =>
      FirebaseFirestore.instance.collection('category');

  Future<Category> getCategory(String uid) async {
    DocumentReference docRef = _category.doc(uid);
    DocumentSnapshot docSnapshot = await docRef.get();
    return Category.fromMap(docSnapshot.data() as Map<String,dynamic>);
  }

  Future<void> addCategory(
    String uid,
    Category category,
    BuildContext context,
  ) async {
    try {
      await _category.doc(uid).set(category.toMap());
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  Future<void> addExpense(
    String uid,
    Expense expense,
    BuildContext context,
  ) async {
    try {
      await _expense.doc(uid).set(expense.toMap());
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }
}
