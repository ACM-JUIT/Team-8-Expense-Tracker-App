import 'package:basecode/features/stats/model/weekly_expense.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> tabs = [
    'Weekly',
    'Monthly',
  ];

  @override
  void initState() {
    _tabController = TabController(
      length: tabs.length,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F0F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF0F0F2),
        title: Text(
          "Statistics",
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          TabBar(
            dividerColor: Colors.transparent,
            tabAlignment: TabAlignment.start,
            isScrollable: true,
            controller: _tabController,
            tabs: tabs
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      e,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                )
                .toList(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: TabBarView(
                controller: _tabController,
                children: [
                  WeeklyExpensesPieChart(),
                  MonthlyRevenueChart(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MonthlyRevenueChart extends StatelessWidget {
  final List<FlSpot> monthlyData = [
    FlSpot(0, 10000),
    FlSpot(1, 25000),
    FlSpot(2, 40000),
    FlSpot(3, 30000),
    FlSpot(4, 50000),
    FlSpot(5, 60000),
    FlSpot(6, 45000),
    FlSpot(7, 70000),
    FlSpot(8, 55000),
    FlSpot(9, 65000),
    FlSpot(10, 75000),
    FlSpot(11, 80000),
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: SizedBox(
          height: screenHeight * 0.4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: false,
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 22,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        const style = TextStyle(
                          color: Color(0xff68737d),
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        );
                        String text = '';
                        if (value.toInt() % 2 == 0) {
                          text = [
                            'JAN',
                            'MAR',
                            'MAY',
                            'JUL',
                            'SEP',
                            'NOV'
                          ][value.toInt() ~/ 2];
                        }
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          space: 8.0,
                          child: Text(text, style: style),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 20000,
                      getTitlesWidget: (value, meta) {
                        const style = TextStyle(
                          color: Color(0xff67727d),
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        );
                        String text = '${value ~/ 1000}k';
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          space: 8.0,
                          child: Text(text, style: style),
                        );
                      },
                      reservedSize: 28,
                    ),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    bottom: BorderSide(color: Colors.grey, width: 1),
                    left: BorderSide.none,
                    right: BorderSide.none,
                    top: BorderSide.none,
                  ),
                ),
                minX: 0,
                maxX: 11,
                minY: 0,
                maxY: 80000,
                lineBarsData: [
                  LineChartBarData(
                    spots: monthlyData,
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(show: false),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WeeklyExpensesPieChart extends StatelessWidget {
  final List<WeeklyExpense> expenses = [
    WeeklyExpense('Mon', 50, Colors.red),
    WeeklyExpense('Tue', 230, Colors.blue),
    WeeklyExpense('Wed', 150, Colors.green),
    WeeklyExpense('Thu', 110, Colors.yellow),
    WeeklyExpense('Fri', 270, Colors.purple),
    WeeklyExpense('Sat', 60, Colors.orange),
    WeeklyExpense('Sun', 190, Colors.pink),
  ];

  @override
  Widget build(BuildContext context) {
    final totalExpenses = expenses.fold(0.0, (sum, item) => sum + item.amount);

    return Center(
      child: SizedBox(
        height: 300,
        child: Stack(
          children: [
            PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 100,
                sections: expenses.map(
                  (expense) {
                    return PieChartSectionData(
                      color: expense.color,
                      value: expense.amount,
                      title: '${expense.day}\n\₹ ${expense.amount.round()}',
                      radius: 40,
                      titleStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    );
                  },
                ).toList(),
              ),
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '₹${totalExpenses.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
