import 'package:basecode/components/budget_container.dart';
import 'package:basecode/components/expense_income_tile.dart';
import 'package:basecode/features/add_expense/repository/expense_repository.dart';
import 'package:basecode/features/auth/repository/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    return StreamBuilder(
      stream: Provider.of<ExpenseRepository>(context).getAllExpense(uid),
      builder: (context, expenses) {
        if (expenses.hasData) {
          return StreamBuilder(
            stream: Provider.of<AuthRepository>(context).getUserData(uid),
            builder: (context, user) {
              if (user.hasData) {
                double totalAmount = expenses.data!
                    .fold<double>(0.0, (acc, e) => acc + e.amount);
                double budget = user.data!.budget;
                double limit = user.data!.limit;
                return Scaffold(
                  backgroundColor: const Color(0xFFF0F0F2),
                  appBar: AppBar(
                    backgroundColor: const Color(0xFFF0F0F2),
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(user.data!.avatar),
                      ),
                    ),
                    actions: [
                      (budget - totalAmount) <= limit
                          ? IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            "Ok",
                                            style: TextStyle(
                                              color: Colors.green,
                                            ),
                                          ),
                                        ),
                                      ],
                                      title: Text(
                                        "Limit reached",
                                        style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      content: Text(
                                        "Hey your expenses are passing limit, hold it down nigga or increase your limit.",
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: Icon(
                                Icons.notification_important_rounded,
                                color: Colors.red,
                              ),
                            )
                          : const SizedBox()
                    ],
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello!",
                          style:
                              TextStyle(fontSize: 15, color: Color(0xFFB8B9C2)),
                        ),
                        Text(
                          user.data!.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF322F50),
                          ),
                        ),
                      ],
                    ),
                  ),
                  body: expenses.data!.length == 0
                      ? Center(
                          child: Text("Add Expense"),
                        )
                      : Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            children: [
                              BudgetContainer(
                                  balance: (budget - totalAmount).toString(),
                                  ratio1: (totalAmount / budget) * 100,
                                  ratio2: 100 - (totalAmount / budget) * 100),
                              const SizedBox(height: 40),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ExpenseIncomeTile(
                                    title: "Expense",
                                    value: totalAmount.toString(),
                                    color: Color(0xFFB1D1D8),
                                  ),
                                  ExpenseIncomeTile(
                                    title: "Income",
                                    value: (budget - totalAmount).toString(),
                                    color: Color(0xFFEFDAC7),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Recent Expenses",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Expanded(
                                child: expenses.data!.length == 0
                                    ? Center(
                                        child: Container(
                                          child: Text(
                                            "Add Expense",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20),
                                          ),
                                        ),
                                      )
                                    : ListView.separated(
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: expenses.data!.length,
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                          height: 20,
                                        ),
                                        itemBuilder: (context, index) {
                                          final expense = expenses.data![index];
                                          return Dismissible(
                                            key: Key(expense.id),
                                            background: Container(
                                              color: Colors.green,
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.white,
                                              ),
                                            ),
                                            secondaryBackground: Container(
                                              color: Colors.green,
                                            ),
                                            onDismissed: (direction) {
                                              Provider.of<ExpenseRepository>(
                                                      context,
                                                      listen: false)
                                                  .deleteExpense(
                                                      uid, expense, context);
                                            },
                                            child: GestureDetector(
                                              onTap: () {
                                                print(expense.description);
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return AlertDialog(
                                                      title: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            expense
                                                                .category.name,
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  expense
                                                                      .category
                                                                      .color),
                                                            ),
                                                          ),
                                                          Text(
                                                            "\₹" +
                                                                expense.amount
                                                                    .toString(),
                                                            style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text(
                                                            "Ok",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.green,
                                                            ),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            Provider.of<ExpenseRepository>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .deleteExpense(
                                                                    uid,
                                                                    expense,
                                                                    context);
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text(
                                                            "Delete",
                                                            style: TextStyle(
                                                              color: Colors.red,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                      content: Container(
                                                        child: Text(
                                                          "${expense.description}",
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(20),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          child: Material(
                                                            shape:
                                                                const CircleBorder(),
                                                            color: Color(expense
                                                                .category
                                                                .color),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(15),
                                                              child:
                                                                  Image.asset(
                                                                'assets/${expense.category.icon}.png',
                                                                height: 40,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 15,
                                                        ),
                                                        Text(
                                                          expense.category.name,
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 16,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                    Column(
                                                      children: [
                                                        Text(
                                                          "- ₹ ${expense.amount}",
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16,
                                                                  color: Colors
                                                                      .red),
                                                        ),
                                                        Text(
                                                          DateFormat(
                                                                  'dd/MM/yyyy')
                                                              .format(
                                                                  expense.date),
                                                          style: TextStyle(
                                                            color: Colors
                                                                .grey.shade400,
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                              )
                            ],
                          ),
                        ),
                );
              }
              if (user.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Scaffold(
                appBar: AppBar(),
                body: Center(
                  child: Text("User not found"),
                ),
              );
            },
          );
        }
        if (expenses.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text("Expenses not found"),
          ),
        );
      },
    );
  }
}
