import 'dart:convert';
import 'package:ai_auction/app/data/model/user_login_model.dart';
import 'package:http/http.dart' as http;

// our base url
const baseUrl = 'https://jsonplaceholder.typicode.com/posts/';

//our class responsible for encapsulating http methods
class MyApiClient {
//your http client can be http, http.Client, dio, just bring your methods here and they will work normally :D
  final http.Client httpClient;
  MyApiClient({required this.httpClient});

  //a quick example, here we are retrieving all posts made available by api(100)
  getAll() async {
    try {
      var response = await httpClient.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        Iterable jsonResponse = json.decode(response.body);
        List<UserLoginModel> listMyModel =
        jsonResponse.map((model) => UserLoginModel.fromJson(model)).toList();
        return listMyModel;
      } else
        print('error');
    } catch (_) {}
  }
  getId(id) async {
    try {
      var response = await httpClient.get(Uri.parse('baseUrlid'));
      if(response.statusCode == 200){
        //Map<String, dynamic> jsonResponse = json.decode(response.body);
      }else print ('erro -get');
    } catch(_){ }
  }
}