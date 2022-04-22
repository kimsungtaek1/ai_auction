import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';

const String kakaoMapKey = 'd6095ebc8ddebfaf71ea969d77669780';

class KakaoMapPage extends StatefulWidget {
  final String second_text;
  final double lat;
  final double lng;
  const KakaoMapPage(
      {Key? key,
      required this.second_text,
      required this.lat,
      required this.lng})
      : super(key: key);
  @override
  _KakaoMapPageState createState() => _KakaoMapPageState();
}

//********개발노트*******
//1. 지도 범위 내에 있는 마커들을 불러온다
//2. 지도를 움직이면 새로 마커들을 불러온다
class _KakaoMapPageState extends State<KakaoMapPage> {
  List data = [];
  late final String previous_value; //지역
  late final double previous_lat;
  late final double previous_lng;
  var i;
  var overlay_i;
  var predict;
  var predict_won;
  var result_price;
  var predict_range_text = "";
  var json_string;
  var json_text;
  var name;
  var latNE;
  var latSW;
  var lngNE;
  var lngSW;
  var _mapController;
  final List<int> showIndexes = const [4];
  final List<FlSpot> allSpots = const [
    FlSpot(0, 1),
    FlSpot(1, 2),
    FlSpot(2, 1.5),
    FlSpot(3, 3),
    FlSpot(4, 3.5),
    FlSpot(5, 1.5),
    FlSpot(6, 1),
  ];
  @override
  void initState() {
    //1번만 실행
    super.initState();
    previous_value = widget.second_text; //전에 값 받기
    previous_lat = widget.lat;
    previous_lng = widget.lng;
    latNE = (previous_lat + 0.03);
    latSW = (previous_lat - 0.03);
    lngNE = (previous_lng + 0.03);
    lngSW = (previous_lng - 0.03);
  }

  // Fetch content from the json file
  Future<String> readJson2() async {
    var time0 = DateTime.now().millisecondsSinceEpoch;
    print('받은 값: ' +
        latNE.toString() +
        ' ' +
        latSW.toString() +
        ' ' +
        lngNE.toString() +
        ' ' +
        lngSW.toString());
    http.Response res = await http.post(
      Uri.parse('http://kstbook1.dothome.co.kr/apt_json_test.php'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{
        'latNE': (previous_lat + 0.03).toString(),
        'latSW': (previous_lat - 0.03).toString(),
        'lngNE': (previous_lng + 0.03).toString(),
        'lngSW': (previous_lng - 0.03).toString(),
      },
    );
    var time1 = (DateTime.now().millisecondsSinceEpoch - time0).toString();
    time1 =
        ' 시간2: ' + time1.substring(0, 1) + '.' + time1.substring(1, 2) + ' 초';
    print(time1);
    List data = jsonDecode(res.body); //0.05초
    json_text = data.toList(); //0.01초
    //특정마커를 클릭하면 그 클릭한 위도,경도로 찾게하자.
    return res.body;
  }

  // Fetch content from the json file
  Future<String> readJson3() async {
    var time0 = DateTime.now().millisecondsSinceEpoch;
    http.Response res = await http.post(
      Uri.parse('http://kstbook1.dothome.co.kr/apt_json_test.php'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{
        'latNE': latNE.toString(),
        'latSW': latSW.toString(),
        'lngNE': lngNE.toString(),
        'lngSW': lngSW.toString(),
      },
    );
    var time1 = (DateTime.now().millisecondsSinceEpoch - time0).toString();
    time1 =
        ' 시간3: ' + time1.substring(0, 1) + '.' + time1.substring(1, 2) + ' 초';
    print(time1);

    List data = jsonDecode(res.body); //0.05초
    json_text = data.toList(); //0.01초
    return res.body;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final lineBarsData = [
      LineChartBarData(
          showingIndicators: showIndexes,
          spots: allSpots,
          isCurved: true,
          barWidth: 4,
          shadow: const Shadow(
            blurRadius: 8,
            color: Colors.black,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: [
              const Color(0xff12c2e9).withOpacity(0.4),
              const Color(0xffc471ed).withOpacity(0.4),
              const Color(0xfff64f59).withOpacity(0.4),
            ],
          ),
          dotData: FlDotData(show: false),
          colors: [
            const Color(0xff12c2e9),
            const Color(0xffc471ed),
            const Color(0xfff64f59),
          ],
          colorStops: [
            0.1,
            0.4,
            0.9
          ]),
    ];

    final tooltipsOnBar = lineBarsData[0];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('VERITAS AI 경매 예측시스템'),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                FutureBuilder(
                    future: readJson3(), // future 작업을 진행할 함수
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return KakaoMapView(
                            width: size.width,
                            height: 400,
                            kakaoMapKey: kakaoMapKey,
                            lat: previous_lat,
                            lng: previous_lng,
                            zoomLevel: 7,
                            mapController: (controller) {
                              _mapController = controller;
                            },
                            customScript: '''
    var latlng;
    var zIndex=1;
    var overlays = [];
    var positions =
    ''' +
                                snapshot.data.toString() +
                                ''';
    map.setMinLevel(3); //최대확대레벨 자세히보인다
    map.setMaxLevel(9); //최대축소레벨 멀리보인다


    makeOverlay();
    kakao.maps.event.addListener(map, "idle", function () {
    var bounds = map.getBounds(); // 지도의 현재 영역을 얻어옵니다
    var swLatLng = bounds.getSouthWest(); // 영역의 남서쪽 좌표를 얻어옵니다
    var neLatLng = bounds.getNorthEast(); // 영역의 북동쪽 좌표를 얻어옵니다
    var bounds_SWNE = '('+neLatLng.getLat()+','+swLatLng.getLat()+','+neLatLng.getLng()+','+swLatLng.getLng()+')';
    console.log(bounds_SWNE);
    cameraIdle.postMessage(bounds_SWNE);

    });
    function makeOverlay() {
    for(var i = 0 ; i < positions.length ; i++){
    latlng = new kakao.maps.LatLng(positions[i].lat,positions[i].lng);
    var overlay = new kakao.maps.CustomOverlay({
    map: map,
    content: '<style>.customOverlay{position:relative;bottom:40px;width:100px;height:30px;background:#fff;</style><div class="customOverlay" onclick="onTapOverlay.postMessage('+i+');this.parentElement.style.zIndex=zIndex;zIndex++;"><div style="font-size:10px;padding:2px;">'+positions[i].apt_name+'</div><div style="font-size:8px;padding:2px;">'+positions[i].date_+'</div></div>',
    //클릭하면 오버레이에서 string메세지를 dart파일에 보냄, 그리고 z-index를 클릭할때 클릭한 요소를 계속해서 1씩 올림. 그렇게 하는 이유는 z-index를 초기화하려면 전체 오버레이 z-index를 전부다 0으로 초기화해야하기 때문, 그리고 지도를 이동시키면 자동으로 오버레이들이 한번 삭제되므로(removeOverlay 함수에서) z-index가 자동으로 초기화됨
    position: latlng,
    yAnchor: 1,
    zIndex: 0
    });
    overlay.setMap(map);
    overlays.push(overlay); //overlay를 리스트(overlays)에 넣음
    }
    }
    function removeOverlay() { // 지도 위에 표시되고 있는 오버레이 제거
    for (var i = 0; i < overlays.length; i++) {
    overlays[i].setMap(null);
    }
    overlays = [];
    }

    var zoomControl = new kakao.maps.ZoomControl(); //지도 줌 보여주기
    map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
    var mapTypeControl = new kakao.maps.MapTypeControl(); //지도 유형 보여주기
    map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
    ''',
                            onTapOverlay: (message) {
                              setState(() {
                                i = message.message;
                                overlay_i = int.parse(i);
                                predict = json_text[overlay_i]['predict'];
                                predict_won = (int.parse(predict) / 100000000)
                                        .toStringAsFixed(2) +
                                    '억 원';
                                if (json_text[overlay_i]['result_price'] !=
                                    '0') {
                                  result_price =
                                      json_text[overlay_i]['result_price'];
                                } else {
                                  result_price = '유찰';
                                }
                              });
                            },
                            cameraIdle: (message) {
                              KakaoMapUtil util = KakaoMapUtil();
                              KakaoBounds latlng =
                                  util.getBound(message.message);
                              setState(() {
                                latNE = latlng.latNE + 0.03;
                                latSW = latlng.latSW - 0.03;
                                lngNE = latlng.lngNE + 0.03;
                                lngSW = latlng.lngSW - 0.03;
                              });
                              _mapController.evaluateJavascript(
                                  'removeOverlay();positions=' +
                                      snapshot.data.toString() +
                                      ';makeOverlay();');
                            });
                      }
                      // 에러 수신 시 에러 메시지 출력
                      else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      // 상태처리 인디케이터 표시. 앱 초기에 출력
                      return SizedBox(
                          width: size.width,
                          height: 400,
                          child: Center(child: CircularProgressIndicator()));
                    }),
                if (overlay_i != null)
                  Text("사건번호: " +
                      json_text[overlay_i]['court_'] +
                      " " +
                      json_text[overlay_i]['case_']),
                if (overlay_i != null)
                  Text("아파트명: " + json_text[overlay_i]['apt_name']),
                if (overlay_i != null)
                  Text("주소: " + json_text[overlay_i]['address_']),
                if (overlay_i != null) Text("예측가: " + predict),
                if (overlay_i != null) Text("낙찰가: " + result_price),
                if (overlay_i != null)
                  Text("경매개시일: " + json_text[overlay_i]['date_']),
                if (overlay_i != null)
                  SizedBox(
                    height: 30,
                  ),
                if (overlay_i != null)
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: LineChart(
                      LineChartData(
                        rangeAnnotations: RangeAnnotations(
                          verticalRangeAnnotations: [
                            VerticalRangeAnnotation(
                              x1: 3,
                              x2: 5,
                              color: const Color(0xffD5DAE5),
                            ),
                          ],
                        ),
                        showingTooltipIndicators: showIndexes.map((index) {
                          return ShowingTooltipIndicators([
                            LineBarSpot(
                                tooltipsOnBar,
                                lineBarsData.indexOf(tooltipsOnBar),
                                tooltipsOnBar.spots[index]),
                          ]);
                        }).toList(),
                        lineTouchData: LineTouchData(
                          enabled: false,
                          getTouchedSpotIndicator: (LineChartBarData barData,
                              List<int> spotIndexes) {
                            return spotIndexes.map((index) {
                              return TouchedSpotIndicatorData(
                                FlLine(
                                  color: Colors.green,
                                ),
                                FlDotData(
                                  show: true,
                                  getDotPainter:
                                      (spot, percent, barData, index) =>
                                          FlDotCirclePainter(
                                    radius: 8,
                                    color: lerpGradient(barData.colors,
                                        barData.colorStops!, percent / 100),
                                    strokeWidth: 2,
                                    strokeColor: Colors.black,
                                  ),
                                ),
                              );
                            }).toList();
                          },
                          touchTooltipData: LineTouchTooltipData(
                            tooltipBgColor: Colors.red,
                            tooltipRoundedRadius: 8,
                            getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                              return lineBarsSpot.map((lineBarSpot) {
                                return LineTooltipItem(
                                  predict_won, //텍스트 내용
                                  const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                );
                              }).toList();
                            },
                          ),
                        ),
                        lineBarsData: lineBarsData,
                        maxY: 5,
                        minY: 0,
                        titlesData: FlTitlesData(
                          leftTitles: SideTitles(
                            showTitles: false,
                          ),
                          bottomTitles: SideTitles(
                            showTitles: false,
                          ),
                          rightTitles: SideTitles(showTitles: false),
                          topTitles: SideTitles(showTitles: false),
                        ),
                        axisTitleData: FlAxisTitleData(
                          topTitle: AxisTitle(
                              showTitle: true,
                              titleText: '예측가 차트',
                              textAlign: TextAlign.left),
                        ),
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(
                          show: false,
                        ),
                      ),
                    ),
                  ),
                if (overlay_i != null)
                  SizedBox(
                    height: 100,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Lerps between a [LinearGradient] colors, based on [t]
Color lerpGradient(List<Color> colors, List<double> stops, double t) {
  if (colors.isEmpty) {
    throw ArgumentError('"colors" is empty.');
  } else if (colors.length == 1) {
    return colors[0];
  }

  if (stops.length != colors.length) {
    stops = [];

    /// provided gradientColorStops is invalid and we calculate it here
    colors.asMap().forEach((index, color) {
      final percent = 1.0 / (colors.length - 1);
      stops.add(percent * index);
    });
  }

  for (var s = 0; s < stops.length - 1; s++) {
    final leftStop = stops[s], rightStop = stops[s + 1];
    final leftColor = colors[s], rightColor = colors[s + 1];
    if (t <= leftStop) {
      return leftColor;
    } else if (t < rightStop) {
      final sectionT = (t - leftStop) / (rightStop - leftStop);
      return Color.lerp(leftColor, rightColor, sectionT)!;
    }
  }
  return colors.last;
}
