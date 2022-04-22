import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchState();
}

class _SearchState extends State {
  int touchedIndex = -1;

  Color greyColor = Colors.grey;

  List<int> selectedSpots = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('차트'),
      ),
      body: Card(
        color: const Color(0xff222222),
        child: ScatterChart(
          ScatterChartData(
            scatterSpots: [
              ScatterSpot(
                3,
                2,
                color: selectedSpots.contains(0) ? Colors.red : greyColor,
                radius: 36,
              ),
            ],
            minX: 0,
            maxX: 10,
            minY: 0,
            maxY: 10,
            borderData: FlBorderData(
              show: false,
            ),
            gridData: FlGridData(
              show: false,
            ),
            titlesData: FlTitlesData(
              show: false,
            ),
            showingTooltipIndicators: selectedSpots,
            scatterTouchData: ScatterTouchData(
              enabled: true,
              handleBuiltInTouches: false,
              mouseCursorResolver:
                  (FlTouchEvent touchEvent, ScatterTouchResponse? response) {
                return response == null || response.touchedSpot == null
                    ? MouseCursor.defer
                    : SystemMouseCursors.click;
              },
              touchTooltipData: ScatterTouchTooltipData(
                tooltipBgColor: Colors.black,
                getTooltipItems: (ScatterSpot touchedBarSpot) {
                  return ScatterTooltipItem(
                    'X: ',
                    textStyle: TextStyle(
                      height: 1.2,
                      color: Colors.grey[100],
                      fontStyle: FontStyle.italic,
                    ),
                    bottomMargin: 10,
                    children: [
                      TextSpan(
                        text: '${touchedBarSpot.x.toInt()} \n',
                        style: const TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: 'Y: ',
                        style: TextStyle(
                          height: 1.2,
                          color: Colors.grey[100],
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                      TextSpan(
                        text: touchedBarSpot.y.toInt().toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  );
                },
              ),
              touchCallback:
                  (FlTouchEvent event, ScatterTouchResponse? touchResponse) {
                if (touchResponse == null ||
                    touchResponse.touchedSpot == null) {
                  return;
                }
                if (event is FlTapUpEvent) {
                  final sectionIndex = touchResponse.touchedSpot!.spotIndex;
                  setState(() {
                    if (selectedSpots.contains(sectionIndex)) {
                      selectedSpots.remove(sectionIndex);
                    } else {
                      selectedSpots.add(sectionIndex);
                    }
                  });
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
