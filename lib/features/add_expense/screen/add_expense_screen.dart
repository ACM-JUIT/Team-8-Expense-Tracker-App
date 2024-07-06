import 'package:basecode/components/add_expense_tile.dart';
import 'package:basecode/components/my_button.dart';
import 'package:flutter/material.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final TextEditingController expenseController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0F0F2),
        leading: IconButton(
          onPressed: () {},
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          "Expenses",
          style: TextStyle(
              color: const Color(0xFF322F50),
              fontWeight: FontWeight.w600,
              fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 30.0, right: 30, bottom: 70, top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AddExpenseTile(
              controller: expenseController,
              hint: "Expense",
              onTap: () {},
            ),
            const SizedBox(height: 30),
            AddExpenseTile(
              controller: nameController,
              hint: "Expense Name",
              onTap: () {},
            ),
            const SizedBox(height: 30),
            TextField(
              readOnly: true,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: "Category",
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              readOnly: true,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                hintText: "Date",
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.date_range_rounded),
                ),
              ),
            ),
            const SizedBox(height: 30),
            AddExpenseTile(
              controller: descriptionController,
              hint: "Description",
              onTap: () {},
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: MyButton(
                text: "Add Expense",
                onTap: () {},
                color: const Color(0xFF322F50),
              ),
            )
          ],
        ),
      ),
    );
  }
}
