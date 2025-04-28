import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LiveActivityChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(

      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),

        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 5),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Live Activity Chart',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Color(0xFF09345D),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Text(
                      'Day',
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  horizontalInterval: 10,
                  drawVerticalLine: true,
                  getDrawingVerticalLine: (value) => FlLine(
                    color: Colors.grey.withOpacity(0.1),
                    strokeWidth: 1,
                  ),
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey.withOpacity(0.1),
                    strokeWidth: 1,
                  ),
                ),
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 3,
                      getTitlesWidget: (value, meta) {
                        const labels = ['12 Am', '01 Am', '03 Am', '06 Am', '09 Am', '12 Pm', '02 Pm', '05 Pm'];
                        int index = value ~/ 3;
                        return Text(
                          labels[index < labels.length ? index : labels.length - 1],
                          style: TextStyle(fontSize: 10),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 10,
                      getTitlesWidget: (value, meta) => Text('${value.toInt()}'),
                    ),
                  ),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: 21,
                minY: 0,
                maxY: 50,
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 25),
                      FlSpot(3, 20),
                      FlSpot(6, 30),
                      FlSpot(9, 20),
                      FlSpot(12, 30),
                      FlSpot(15, 25),
                      FlSpot(18, 30),
                      FlSpot(21, 22),
                    ],
                    isCurved: true,
                    color: Colors.blue,
                    barWidth: 3,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 6,
                          color: Colors.blue,
                          strokeWidth: 2,
                          strokeColor: Colors.white,
                        );
                      },
                    ),
                  ),
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 30),
                      FlSpot(3, 25),
                      FlSpot(6, 20),
                      FlSpot(9, 30),
                      FlSpot(12, 20),
                      FlSpot(15, 30),
                      FlSpot(18, 25),
                      FlSpot(21, 22),
                    ],
                    isCurved: true,
                    color: Colors.amber,
                    barWidth: 3,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 6,
                          color: Colors.amber,
                          strokeWidth: 2,
                          strokeColor: Colors.white,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Legend(color: Colors.blue, text: "In Branch"),
              SizedBox(width: 16),
              Legend(color: Colors.amber, text: "Rented"),
            ],
          )
        ],
      ),
    );
  }
}

class Legend extends StatelessWidget {
  final Color color;
  final String text;

  const Legend({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 12, height: 12, color: color),
        SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}
