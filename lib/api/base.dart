import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/postpesponse.dart';
class Base {
  static String baseUrl = "http://206.189.232.163:5683/api/";
  static String imageBaseUrl = "http://206.189.232.163:5683/";
  static Base _instance;
  static Base get instance{
    if (_instance == null) {
      _instance = new Base();
    }
    return _instance;
  }
  Future<PostResponse> createPost(String path, {Map<String, dynamic> body}) async {
    print(path);
  return http.post( baseUrl + path, body: json.encode(body), headers: {
    "Content-Type": "application/json"
  }).then((http.Response response) {
    // print(body);
    final int statusCode = response.statusCode;
    print("status code:");
    print(statusCode);
    print(response.body);
    // *debug print(json.decode(response.body));
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
      }
      print(response.body);
      return PostResponse.fromJson(json.decode(response.body));
    }).catchError((error){
      print(error);
    });
  }
}