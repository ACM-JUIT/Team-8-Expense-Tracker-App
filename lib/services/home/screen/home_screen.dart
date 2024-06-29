import 'package:basecode/services/add_expense/screen/add_expense_screen.dart';
import 'package:basecode/services/home/screen/main_screen.dart';
import 'package:basecode/services/savings/screen/savings_screen.dart';
import 'package:basecode/services/user_profile/screen/user_profile_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentPage = 0;
  List<Widget> screens = const [
    MainScreen(),
    AddExpenseScreen(),
    UserProfileScreen(),
    SavingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FC),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.white,
        elevation: 0,
        onTap: (value) {
          setState(() {
            currentPage = value;
          });
        },
        currentIndex: currentPage,
        selectedIconTheme:
            const IconThemeData(color: Color(0xFF322F50), size: 30),
        unselectedIconTheme: IconThemeData(color: Colors.grey.shade300),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.stacked_bar_chart_rounded),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.savings),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_rounded),
            label: "",
          ),
        ],
      ),
      body: IndexedStack(
        index: currentPage,
        children: screens,
      ),
    );
  }
}
