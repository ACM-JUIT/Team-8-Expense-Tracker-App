import 'package:basecode/services/auth/repository/auth_repository.dart';
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
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9FC),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                context.read<AuthRepository>().signOut(context);
              },
              icon: Icon(Icons.logout))
        ],
        backgroundColor: const Color(0xFFF9F9FC),
        leading: const Icon(Icons.account_circle),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello!",
              style: TextStyle(fontSize: 15, color: Color(0xFFEFDAC7)),
            ),
            Text(
              "Dummy User",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF322F50),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(context.read<AuthRepository>().user.email!),
      ),
    );
  }
}
