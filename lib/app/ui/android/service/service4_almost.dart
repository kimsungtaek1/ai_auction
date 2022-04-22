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

    json_string = readJson2();

  }

  // Fetch content from the json file
  Future<String> readJson1() async {
    var time0 = DateTime.now().millisecondsSinceEpoch;
    http.Response res = await http
        .get(Uri.parse('http://kstbook1.dothome.co.kr/apt_json.php')); //2.5초
    //여기서 시간이 오래걸린다. 이걸 해결해야함. compute
    var time1 = (DateTime.now().millisecondsSinceEpoch - time0).toString();
    time1 =
        ' 시간: ' + time1.substring(0, 1) + '.' + time1.substring(1, 2) + ' 초';
    print(time1);
    List data = jsonDecode(res.body); //0.05초
    json_text = data.toList(); //0.01초
    //특정마커를 클릭하면 그 클릭한 위도,경도로 찾게하자.
    return res.body;
  }

  // Fetch content from the json file
  Future<String> readJson2() async {
    var time0 = DateTime.now().millisecondsSinceEpoch;
    http.Response res = await http.post(
      Uri.parse('http://kstbook1.dothome.co.kr/apt_json_test.php'),
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: <String, String>{
        'latNE': (previous_lat+0.02).toString(),
        'latSW': (previous_lat-0.02).toString(),
        'lngNE': (previous_lng+0.02).toString(),
        'lngSW': (previous_lng-0.02).toString(),
      },
    );
    var time1 = (DateTime.now().millisecondsSinceEpoch - time0).toString();
    time1 =
        ' 시간: ' + time1.substring(0, 1) + '.' + time1.substring(1, 2) + ' 초';
    print(time1);
    List data = jsonDecode(res.body); //0.05초
    json_text = data.toList(); //0.01초
    //특정마커를 클릭하면 그 클릭한 위도,경도로 찾게하자.
    return res.body;
  }
  // Fetch content from the json file
  Future<String> readJson3(double latNE,double latSW,double lngNE,double lngSW,) async {
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
        ' 시간: ' + time1.substring(0, 1) + '.' + time1.substring(1, 2) + ' 초';
    print(time1);
    List data = jsonDecode(res.body); //0.05초
    json_text = data.toList(); //0.01초
    //특정마커를 클릭하면 그 클릭한 위도,경도로 찾게하자.
    return res.body;
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                    future: readJson2(), //future작업을 진행할 함수
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
                      if (snapshot.hasData == false) {
                        return SizedBox(
                            width: size.width,
                            height: 400,
                            child: Center(child: CircularProgressIndicator()));
                      }
                      // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.
                      else {
                        print(snapshot.data.toString());
                        return KakaoMapView(
                            width: size.width,
                            height: 400,
                            kakaoMapKey: kakaoMapKey,
                            lat: previous_lat,
                            lng: previous_lng,
                            zoomLevel: 7,
                            customScript: '''
                      var overlays = [];
                      var positions =
                              
                              ''' +
                                snapshot.data.toString() +
                                ''';
                      map.setMinLevel(3); //최대확대레벨 자세히보인다
                      //map.setMaxLevel(7); //최대축소레벨 멀리보인다
                      
                      kakao.maps.event.addListener(map, "idle", function () {
                          var bounds = map.getBounds(); // 지도의 현재 영역을 얻어옵니다 
                          var swLatLng = bounds.getSouthWest(); // 영역의 남서쪽 좌표를 얻어옵니다 
                          var neLatLng = bounds.getNorthEast(); // 영역의 북동쪽 좌표를 얻어옵니다 
                          var bounds_SWNE = '('+neLatLng.getLat()+','+swLatLng.getLat()+','+neLatLng.getLng()+','+swLatLng.getLng()+')';
    
                          var center = map.getCenter();
                          var latlng = '('+center.getLat()+','+center.getLng()+')';
                          cameraIdle.postMessage(bounds_SWNE);
                          
                          
                      });

////////////////////////////////////////////////////                      
                      var latlng;
                      var zIndex=1;
                      makeOverlay();
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
                      
                      var center = map.getCenter(); // 지도의 현재 중심좌표를 얻어옵니다 
                      var bounds = map.getBounds(); // 지도의 현재 영역을 얻어옵니다 

                      var zoomControl = new kakao.maps.ZoomControl(); //지도 줌 보여주기
                      map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
                      var mapTypeControl = new kakao.maps.MapTypeControl(); //지도 유형 보여주기
                      map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);
                    ''',
                            onTapMarker: (message) {
                            },
                            cameraIdle: (message) {
                              KakaoMapUtil util = KakaoMapUtil();
                              KakaoBounds latlng =
                                  util.getBound(message.message);
                              debugPrint(
                                  'bounds : ${latlng.latNE},${latlng.latSW},${latlng.lngNE},${latlng.lngSW}');
                            });
                      }
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
