import 'package:basecode/components/buy_sell_tile.dart';
import 'package:basecode/components/savings_tile.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SavingsScreen extends StatefulWidget {
  const SavingsScreen({super.key});

  @override
  State<SavingsScreen> createState() => _SavingsScreenState();
}

class _SavingsScreenState extends State<SavingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0F0F2),
        title: Text(
          "Savings",
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SavingsTile(
                imagePath: 'assets/wallet.png',
                title: "My Wallet",
                subTitle: "Your Savings",
                amount: "\₹ 20,043",
              ),
              const Gap(20),
              SavingsTile(
                imagePath: 'assets/gold.png',
                title: "Gold",
                subTitle: "Digital Gold Investment",
                amount: "\₹ 20.34g",
              ),
              const Gap(20),
              SavingsTile(
                imagePath: 'assets/bank.png',
                title: "Indian Overseas Bank",
                subTitle: "Your Debit Card",
                amount: "",
              ),
              const Gap(60),
              Image.asset(
                'assets/gold_savings.png',
                height: 150,
              ),
              const Gap(40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BuySellTile(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
