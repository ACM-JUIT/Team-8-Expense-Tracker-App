import 'package:basecode/components/budget_container.dart';
import 'package:basecode/components/expense_income_tile.dart';
import 'package:basecode/services/add_expense/repository/expense_repository.dart';
import 'package:basecode/services/auth/repository/auth_repository.dart';
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
  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final expenseRepository = context.read<ExpenseRepository>();

    return StreamBuilder(
      stream: Provider.of<AuthRepository>(context).getUserData(uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: const Color(0xFFF0F0F2),
            appBar: AppBar(
              backgroundColor: const Color(0xFFF0F0F2),
              actions: [
                IconButton(
                    onPressed: () {
                      context.read<AuthRepository>().signOut(context);
                    },
                    icon: Icon(Icons.logout))
              ],
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(snapshot.data!.avatar),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hello!",
                    style: TextStyle(fontSize: 15, color: Color(0xFFB8B9C2)),
                  ),
                  Text(
                    snapshot.data!.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF322F50),
                    ),
                  ),
                ],
              ),
            ),
            body: StreamBuilder(
              stream: Provider.of<ExpenseRepository>(context, listen: false)
                  .getAllExpense(uid),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  double totalAmount = snapshot.data!
                      .fold<double>(0.0, (acc, e) => acc + e.amount);
                  return Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        BudgetContainer(
                            balance: totalAmount == 0
                                ? "Add Expense"
                                : "₹ " + (expenseRepository.budget - totalAmount)
                                    .toString(),
                            ratio1: (totalAmount / 10000) * 100,
                            ratio2: 100 - (totalAmount / 10000) * 100),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ExpenseIncomeTile(
                              title: "Expense",
                              value:  totalAmount.toString(),
                              color: Color(0xFFB1D1D8),
                            ),
                            ExpenseIncomeTile(
                              title: "Income",
                              value: (expenseRepository.budget - totalAmount)
                                  .toString(),
                              color: Color(0xFFEFDAC7),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Recent Expenses",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: snapshot.data!.length == 0
                              ? Center(
                                child: Container(
                                    child: Text("Add Expense",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20
                                    ),),
                                  ),
                              )
                              : ListView.separated(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: snapshot.data!.length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                    height: 20,
                                  ),
                                  itemBuilder: (context, index) {
                                    final expense = snapshot.data![index];
                                    return Dismissible(
                                      key: Key(expense.id),
                                      background: Container(
                                        color: Colors.green,
                                      ),
                                      secondaryBackground: Container(
                                        color: Colors.green,
                                      ),
                                      onDismissed: (direction) {
                                        Provider.of<ExpenseRepository>(context,
                                                listen: false)
                                            .deleteExpense(
                                                uid, expense, context);
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Material(
                                                    shape: const CircleBorder(),
                                                    color: Color(
                                                        expense.category.color),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15),
                                                      child: Image.asset(
                                                        'assets/${expense.category.icon}.png',
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Text(
                                                  expense.category.name,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  "- ₹ ${expense.amount}",
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.red),
                                                ),
                                                Text(
                                                  DateFormat('dd/MM/yyyy')
                                                      .format(expense.date),
                                                  style: TextStyle(
                                                      color:
                                                          Colors.grey.shade400),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        )
                      ],
                    ),
                  );
                }
                return Center(
                  child: Text("Add Expense"),
                );
              },
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
