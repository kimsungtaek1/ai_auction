import 'package:ai_auction/app/controller/mypage/mypage_controller.dart';
import 'package:ai_auction/app/controller/root/root_controller.dart';
import 'package:ai_auction/app/data/model/bookmark_model.dart';
import 'package:ai_auction/app/data/provider/storage.dart';
import 'package:ai_auction/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:kakaomap_webview/kakaomap_webview.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';
import 'package:ai_auction/app/data/provider/request.dart';
import 'package:ai_auction/app/data/provider/url.dart';

const String kakaoMapKey = 'd6095ebc8ddebfaf71ea969d77669780';

class Service extends StatefulWidget {
  final String no;
  final double lat;
  final double lng;
  const Service(
      {Key? key,
        required this.no,
      required this.lat,
      required this.lng})
      : super(key: key);
  @override
  _KakaoMapPageState createState() => _KakaoMapPageState();
}

//********개발노트*******
//1. 지도 범위 내에 있는 마커들을 불러온다
//2. 지도를 움직이면 새로 마커들을 불러온다
class _KakaoMapPageState extends State<Service> {
  List data = [];
  late final double previous_lat;
  late final double previous_lng;
  var i;
  var overlay_i;
  var overlay_no;
  var predict_range_text = "";
  var json_string;
  var json_list;
  var name;
  var latNE;
  var latSW;
  var lngNE;
  var lngSW;
  var _mapController;
  var user_id = '';
  bool favorite_bool = false;
  var fav_list = [];
  int index = -1;
  final SecureStorage storage = SecureStorage();
  final List<int> showIndexes = const [10];
  final List<FlSpot> allSpots = const [
    FlSpot(0, 0.0009),
    FlSpot(1, 0.0044),
    FlSpot(2, 0.0175),
    FlSpot(3, 0.0540),
    FlSpot(4, 0.1295),
    FlSpot(5, 0.2420),
    FlSpot(6, 0.3521),
    FlSpot(7, 0.3989),
    FlSpot(8, 0.3521),
    FlSpot(9, 0.2420),
    FlSpot(10, 0.1295),
    FlSpot(11, 0.0540),
    FlSpot(12, 0.0175),
    FlSpot(13, 0.0044),
    FlSpot(14, 0.0009),
  ];
  @override
  void initState() {
    previous_lat = widget.lat;
    previous_lng = widget.lng;
    latNE = (previous_lat + 0.04);
    latSW = (previous_lat - 0.04);
    lngNE = (previous_lng + 0.04);
    lngSW = (previous_lng - 0.04);
    storage.readSecureData('user_id').then((value) {
      if (value == null) {
        user_id = 'null';
      } else {
        user_id = value;
        print('서비스:' + user_id);
      }
    });
    if (widget.no!=0){
      //해당 물건만 가져오기
      //readJsonBookmark();
    }
    readJson().then((value) {
      List data = jsonDecode(value);
      print(data);
      index = data.indexWhere((item) => item["no"] == widget.no);
      print(index);
      json_list = data.toList();
      setState(() {
        if (index>=0){
          overlay_no=index;
        }
      });
    });

    //1번만 실행
    super.initState();
  }

  // Fetch content from the json file
  Future<String> readJson() async {
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
    List data = jsonDecode(res.body);
    json_list = data.toList();
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
                    future: readJson(), // future 작업을 진행할 함수
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return buildKakaoMapView(size, snapshot);
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
                if (overlay_no != null)
                  Text("No: " + json_list[overlay_no]['no']),
                if (overlay_no != null)
                  Text("오버레이 넘버: " + overlay_no.toString()),
                if (overlay_no != null)
                  Text("사건번호: " +
                      json_list[overlay_no]['court_'] +
                      " " +
                      json_list[overlay_no]['case_']),
                if (overlay_no != null)
                  Text("아파트명: " + json_list[overlay_no]['apt_name']),
                if (overlay_no != null)
                  Text("주소: " + json_list[overlay_no]['address_']),
                if (overlay_no != null && user_id != 'null')
                  Text("예측가: " + json_list[overlay_no]['predict'])
                else if (overlay_no != null && user_id == 'null')
                  Row(
                    children: [
                      Text("예측가: "),
                      lockButton(),
                    ],
                  ),
                if (overlay_no != null) (json_list[overlay_no]['result_price'] != '0')?Text("낙찰가: " + json_list[overlay_no]['result_price']):Text("낙찰가: " + '유찰'),
                if (overlay_no != null)
                  Text("경매개시일: " + json_list[overlay_no]['date_']),
                if (overlay_no != null)
                  SizedBox(
                    height: 30,
                  ),
                if (overlay_no != null)
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text('즐겨찾기 :'),
                        IconButton(
                          onPressed: () {
                            //즐겨찾기 버튼을 누르면 해당 오버레이 넘버 또는 위치 좌표, 이름 저장,
                            // => 개인용 DB 테이블이 필요하고 JSON string 으로 관리 해야 한다. 과거에 했었던 결제 날짜들, 저장한 물건 넘버 및 좌표
                            setState(() {
                              if (favorite_bool == false) {
                                favorite_bool = true; //빈하트이면 채워진 하트로 바꿈
                              } else {
                                favorite_bool = false;
                              }
                              Request request = Request(
                                  url: urlUserBookmarkUpdate,
                                  body: {
                                    'user_id': user_id,
                                    'item_no': json_list[overlay_no]['no']
                                  });
                              request.post().then((value) async {
                                print('즐겨찾기된 리스트: ${value.body}');
                                MypageController controller =
                                    Get.find(); // controller  접근하기
                                controller.loadUserProfile(); // update mypage
                              }).catchError((onError) {});
                              //마이페이지 바꾸기
                            });
                          },
                          icon: favorite_bool == true
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : Icon(
                                  Icons.favorite_border,
                                  color: Colors.red,
                                ),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          padding: const EdgeInsets.fromLTRB(0, 5, 10, 0),
                          iconSize: 30.0,
                        ),
                      ]),
                if (overlay_no != null)
                  SizedBox(
                    width: 300,
                    height: 300,
                    child: LineChart(
                      LineChartData(
                        rangeAnnotations: RangeAnnotations(
                          verticalRangeAnnotations: [
                            VerticalRangeAnnotation(
                              x1: 9, //회색 투명 박스 시작
                              x2: 11, //회색 투명 박스 끝
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
                                  (user_id != 'null')
                                      ? (int.parse(json_list[overlay_no]['predict']) / 100000000).toStringAsFixed(2) + '억 원'
                                      : '?', //텍스트 내용
                                  const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                );
                              }).toList();
                            },
                          ),
                        ),
                        lineBarsData: lineBarsData,
                        maxY: 0.5, //최대 높이
                        minY: 0, //최저 높이
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
                              titleText: '예측가 차트 제목(차트 안에 있음)',
                              textAlign: TextAlign.left),
                        ),
                        gridData: FlGridData(show: false),
                        borderData: FlBorderData(
                          show: false,
                        ),
                      ),
                    ),
                  ),
                if (overlay_no != null)
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

  KakaoMapView buildKakaoMapView(Size size, AsyncSnapshot<dynamic> snapshot) {
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
  //overlay_no를 null로 초기화 시켜야함.
  });
  function makeOverlay() {
  for(var i = 0 ; i < positions.length ; i++){
  latlng = new kakao.maps.LatLng(positions[i].lat,positions[i].lng);
  var overlay = new kakao.maps.CustomOverlay({
  map: map,
  content: '<style>.customOverlay{position:relative;bottom:40px;width:100px;height:30px;background:#fff;</style><div class="customOverlay" onclick="onTapOverlay.postMessage('+positions[i].no+');this.parentElement.style.zIndex=zIndex;zIndex++;"><div style="font-size:10px;padding:2px;">'+positions[i].apt_name+'</div><div style="font-size:8px;padding:2px;">'+positions[i].date_+'</div></div>',
  //클릭하면 오버레이에서 string메세지를 dart파일에 보냄, 그리고 z-index를 클릭할때 클릭한 요소를 계속해서 1씩 올림. 그렇게 하는 이유는 z-index를 초기화하려면 전체 오버레이 z-index를 전부다 0으로 초기화해야하기 때문, 그리고 지도를 이동시키면 자동으로 오버레이들이 한번 삭제되므로(removeOverlay 함수에서) z-index가 자동으로 초기화됨
  //***클릭하면 리스트를 가져와서 있으면 하트 없으면 빈하트
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
            for (var j = 0; j < json_list.length; j++) {
              if (json_list[j]['no'] == i) {
                overlay_no = j;
              }
            }
            //탭을 누르면 로그인 했을시 북마크 되어 있는지를 불러온다. 로그인을 안하면 로그인화면으로 간다.
            Request request = Request(url: urlUserBookmarkGet, body: {
              'user_id': user_id,
              'item_no': json_list[overlay_no]['no']
            });
            request.post().then((value) async {
              print('오버레이를 누르면 나오는 값:' + value.body);
              setState(() {
                if (value.body == 'true') {
                  favorite_bool = true;
                } else {
                  favorite_bool = false;
                }
              });
            }).catchError((onError) {});
          });
        },
        cameraIdle: (message) {
          KakaoMapUtil util = KakaoMapUtil();
          KakaoBounds bound = util.getBound(message.message);
          setState(() {
            latNE = bound.latNE + 0.03;
            latSW = bound.latSW - 0.03;
            lngNE = bound.lngNE + 0.03;
            lngSW = bound.lngSW - 0.03;
          });
          overlay_no = null; //지도를 움직이면 초기화 함.
          _mapController.evaluateJavascript('removeOverlay();positions=' +
              snapshot.data.toString() +
              ';makeOverlay();');
        });
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

class lockButton extends StatefulWidget {
  @override
  lockButtonState createState() => lockButtonState();
}

class lockButtonState extends State<lockButton> {
  bool _active = false;

  _setActive() {
    setState(() {
      _active = !_active;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        RootController controller = Get.find(); // controller  접근하기
        controller.changeRootPageIndex(2);
        //Get.offAllNamed(AppRoutes.ROOT, arguments: 'service');
        _setActive();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: _active ? Colors.red : Colors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        width: 80,
        height: 25,
        //alignment: Alignment.center,
        child: Icon(Icons.lock_outline_rounded),
      ),
    );
  }
}
