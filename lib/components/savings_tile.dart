import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SavingsTile extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subTitle;
  final String amount;
  const SavingsTile({
    super.key,
    required this.title,
    required this.subTitle,
    required this.amount,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 1.5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                height: 50,
                imagePath,
              ),
              const Gap(20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    subTitle,
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              )
            ],
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}
