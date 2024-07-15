import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BudgetContainer extends StatelessWidget {
  final String balance;
  final double? ratio1;
  final double? ratio2;
  const BudgetContainer(
      {super.key,
      required this.balance,
      required this.ratio1,
      required this.ratio2});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.15,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: const Color(0xFF322F50),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Total Balance",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
              Text(
                balance,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 70,
                width: 70,
                child: PieChart(
                  swapAnimationDuration: Duration(milliseconds: 750),
                  swapAnimationCurve: Curves.easeInOutCirc,
                  PieChartData(
                    centerSpaceRadius: 10,
                    sections: [
                      PieChartSectionData(
                        badgeWidget: Text(
                          "Expense",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w900),
                        ),
                        radius: 35,
                        value: ratio1,
                        showTitle: false,
                        color: const Color(0xFFB1D1D8),
                      ),
                      PieChartSectionData(
                        badgeWidget: Text(
                          "Balance",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w900),
                        ),
                        value: ratio2,
                        radius: 38,
                        showTitle: false,
                        color: Color(0xFFF9F9FC),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
