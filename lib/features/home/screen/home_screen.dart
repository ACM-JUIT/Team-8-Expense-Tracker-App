import 'package:basecode/features/add_expense/screen/add_expense_screen.dart';
import 'package:basecode/features/home/screen/main_screen.dart';
import 'package:basecode/features/savings/screen/savings_screen.dart';
import 'package:basecode/features/stats/screen/statistics_screen.dart';
import 'package:basecode/features/user_profile/screen/user_profile_screen.dart';
import 'package:flutter/cupertino.dart';
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
    StatisticsScreen(),
    AddExpenseScreen(),
    SavingsScreen(),
    UserProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF0F0F2),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: SizedBox(
          height: 70,
          width: 70,
          child: FloatingActionButton(
            shape: const CircleBorder(),
            backgroundColor: const Color(0xFF322F50),
            onPressed: () {
              setState(() {
                currentPage = 2;
              });
            },
            child: const Icon(
              size: 30,
              Icons.add,
              color: Colors.white,
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 90,
          color: const Color(0xFFF0F0F2),
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentPage = 0;
                      });
                    },
                    icon: Icon(
                      size: 30,
                      currentPage == 0
                          ? CupertinoIcons.house_alt_fill
                          : CupertinoIcons.house_alt,
                      color: const Color(0xFF322F50),
                    ),
                  ),
                  Text(
                    "Home",
                    style: TextStyle(
                        color: const Color(0xFF322F50),
                        fontSize: 12,
                        fontWeight: currentPage == 0
                            ? FontWeight.w900
                            : FontWeight.normal),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentPage = 1;
                      });
                    },
                    icon: Icon(
                      size: 30,
                      currentPage == 1
                          ? CupertinoIcons.chart_bar_circle_fill
                          : CupertinoIcons.chart_bar_circle,
                      color: const Color(0xFF322F50),
                    ),
                  ),
                  Text(
                    "Statistics",
                    style: TextStyle(
                        color: const Color(0xFF322F50),
                        fontSize: 12,
                        fontWeight: currentPage == 1
                            ? FontWeight.w900
                            : FontWeight.normal),
                  ),
                ],
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(
                        () {
                          currentPage = 3;
                        },
                      );
                    },
                    icon: Icon(
                      size: 30,
                      currentPage == 3 ? Icons.savings : Icons.savings_outlined,
                      color: const Color(0xFF322F50),
                    ),
                  ),
                  Text(
                    "Savings",
                    style: TextStyle(
                      color: const Color(0xFF322F50),
                      fontSize: 12,
                      fontWeight: currentPage == 3
                          ? FontWeight.w900
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentPage = 4;
                      });
                    },
                    icon: Icon(
                      size: 30,
                      currentPage == 4
                          ? Icons.account_circle
                          : Icons.account_circle_outlined,
                      color: const Color(0xFF322F50),
                    ),
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(
                        color: const Color(0xFF322F50),
                        fontSize: 12,
                        fontWeight: currentPage == 4
                            ? FontWeight.w900
                            : FontWeight.normal),
                  ),
                ],
              ),
            ],
          ),
        ),
        body: screens[currentPage]);
  }
}
