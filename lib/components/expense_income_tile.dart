import 'package:flutter/material.dart';

class ExpenseIncomeTile extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  const ExpenseIncomeTile({
    super.key,
    required this.title,
    required this.value,
    required this.color, 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 130,
      width: MediaQuery.of(context).size.width * 0.45,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                "\₹ " + value,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.add,
                size: 40,
              )
            ],
          )
        ],
      ),
    );
  }
}
