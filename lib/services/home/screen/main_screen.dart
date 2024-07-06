import 'package:basecode/components/budget_container.dart';
import 'package:basecode/components/expense_income_tile.dart';
import 'package:basecode/services/auth/repository/auth_repository.dart';
import 'package:basecode/services/home/data/dummy_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Provider.of<AuthRepository>(context)
          .getUserData(FirebaseAuth.instance.currentUser!.uid),
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
            body: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  BudgetContainer(balance: "37,540", ratio1: 60, ratio2: 40),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ExpenseIncomeTile(
                        title: "Expense",
                        value: "20,000",
                        color: Color(0xFFB1D1D8),
                      ),
                      ExpenseIncomeTile(
                        title: "Income",
                        value: "50,000",
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
                    child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      itemCount: myData.length,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 20,
                      ),
                      itemBuilder: (context, index) {
                        final item = myData[index];
                        return Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: item['color'],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Material(
                                      shape: const CircleBorder(),
                                      color: item['color'],
                                      child: Padding(
                                        padding: const EdgeInsets.all(15),
                                        child: item['icon'],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    item['name'],
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Text(
                                    item['amount'],
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    item['date'],
                                    style:
                                        TextStyle(color: Colors.grey.shade400),
                                  ),
                                ],
                              )
                            ],
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
