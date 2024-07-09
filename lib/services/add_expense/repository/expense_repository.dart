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

  Future<Category> getCategory(String uid, String categoryId) async {
    print("getcategory $categoryId");
    DocumentReference docRef =
        _category.doc(uid).collection('user_category').doc(categoryId);
    DocumentSnapshot docSnapshot = await docRef.get();
    return Category.fromMap(docSnapshot.data() as Map<String, dynamic>);
  }

  double _budget = 10000;

  double get budget => _budget;

  set updateBudget(double value) {
    _budget = value;
  }

  Future<void> addCategory(
    String uid,
    Category category,
    BuildContext context,
  ) async {
    try {
      await _category
          .doc(uid)
          .collection('user_category')
          .doc(category.id)
          .set(category.toMap());
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
      QuerySnapshot querySnapshot = await _expense
          .doc(uid)
          .collection('user_expense')
          .where('category.name', isEqualTo: expense.category.name)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        int amount = querySnapshot.docs.first['amount'];
        await querySnapshot.docs.first.reference
            .update({'amount': amount + expense.amount});
      } else {
        await _expense
            .doc(uid)
            .collection('user_expense')
            .doc(expense.id)
            .set(expense.toMap());
      }
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  Future<void> deleteExpense(
    String uid,
    Expense expense,
    BuildContext context,
  ) async {
    try {
      await _expense
          .doc(uid)
          .collection('user_expense')
          .doc(expense.id)
          .delete();
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
  }

  Stream<List<Expense>> getAllExpense(String uid) {
    return _expense
        .doc(uid)
        .collection('user_expense')
        .snapshots()
        .map((snapshot) => snapshot.docs)
        .map((docs) => docs.map((doc) => Expense.fromMap(doc.data())).toList());
  }
}
