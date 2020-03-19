import 'package:apptest/api/base.dart';
import 'package:apptest/model/NewsModel.dart';
import 'package:apptest/model/postpesponse.dart';
import 'package:apptest/states/user.state.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/user.model.dart';

class NewsService {
  String root="news";
  static NewsService _instance;
  static NewsService get instance{
    if (_instance == null ) {
      _instance = new NewsService();
    }
    return _instance;
  }
  Future<bool> getUserPseudoExist(String pseudo) async{
    http.Response val = await http.get(Base.baseUrl+root+"?id="+pseudo);
    print("data fetched:");
    print(val.body);
    Map<String, dynamic> result = json.decode(val.body);
    return Future.value(result["exist"]);
  }
  Future<List<NewsModel>> get all async{
    http.Response val = await http.get(Base.baseUrl+root);
    List<dynamic> result = json.decode(val.body);
    return result != null ? result.map((e)=> UserModel.fromJson(e)).toList() : [];
  }

  Future<List<NewsModel>> getAllExecpt(String me) async{
    http.Response val = await http.get(Base.baseUrl+root+"?id="+ UserState.intance.currentUser.pseudo);
    List<dynamic> result = json.decode(val.body);
    return result != null ? result.map((e)=> NewsModel.fromJson(e)).toList() : [];
  }

  Future<PostResponse> post(NewsModel produitModel) {
    return Base.instance.createPost(root, body: produitModel.toMap());
  }
}