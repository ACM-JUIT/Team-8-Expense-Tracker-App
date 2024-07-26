import 'package:flutter/widgets.dart';
import 'package:gap/gap.dart';

class BuySellTile extends StatelessWidget {
  const BuySellTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 150,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.8
            ),
            color: const Color(0xFFB1D1D8),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              bottomLeft: Radius.circular(40),
            ),
          ),
          child: Center(
            child: Text(
              "Buy",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ),
        const Gap(10),
        Container(
          width: 150,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.8
            ),
            color: const Color(0xFFEFDAC7),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
          ),
          child: Center(
            child: Text(
              "Sell",
              style: TextStyle(
                fontSize: 25
              ),
            ),
          ),
        ),
      ],
    );
  }
}
