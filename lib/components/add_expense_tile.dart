import 'package:flutter/material.dart';

class AddExpenseTile extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final void Function()? onTap;
  const AddExpenseTile({super.key, required this.controller, required this.hint,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return  TextField(
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20),
        hintText: hint,
        hintStyle: TextStyle(
          color: Colors.grey
        )
      ),
    );
  }
}
