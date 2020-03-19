import 'package:apptest/api/base.dart';
import 'package:apptest/model/postpesponse.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/user.model.dart';
class UserService {
  String root="user";
  static UserService _instance;
  static UserService get instance{
    if (_instance == null ) {
      _instance = new UserService();
    }
    return _instance;
  }
  Future<bool> getUserPseudoExist(String pseudo) async{
    http.Response val = await http.get(Base.baseUrl+root+"?pseudo="+pseudo);
    print("data fetched:");
    print(val.body);
    Map<String, dynamic> result = json.decode(val.body);
    return Future.value(result["exist"]);
  }
  Future<List<UserModel>> get all async{
    http.Response val = await http.get(Base.baseUrl+root+"?pseudo=");
    List<dynamic> result = json.decode(val.body);
    return result != null ? result.map((e)=> UserModel.fromJson(e)).toList() : [];
  }

  Future<PostResponse> post(UserModel produitModel) {
    return Base.instance.createPost(root, body: produitModel.toMap());
  }
}