
import 'dart:async';

import 'package:apptest/bloc/news.stream.dart';
import 'package:apptest/hello.dart';
import 'package:apptest/model/user.model.dart';
import 'package:apptest/service/NewsService.dart';
import 'package:apptest/service/UserService.dart';
import 'package:apptest/states/user.state.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../dialog/error.dialog.dart';
import '../main_app.dart';
import '../utils/ColorUtil.dart';
// import 'package:lukapay/utils/ColorUtil.dart';

class SimPage extends StatefulWidget {
  SimPage({Key key, this.onCompleted}) : super(key: key);

  final Function onCompleted;
  @override
  _SimPageState createState() => _SimPageState();
}
class _SimPageState extends State<SimPage> {
  String passwordError = "";
  String pseudodError = "";
  var animationFinished = false;
  TextEditingController _textPseudoController = new TextEditingController();
  TextEditingController _textPasswordController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _textPasswordController.addListener((){
      print(_textPasswordController.text);
      if (_textPasswordController.text.contains(" ")) {
        setState(() {
          passwordError = "Erreur: le mot de passe ne doit pas contenir d'espace";
        });
      }
      else{
        setState(() {
          passwordError = "";
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 50.0,),
              Text(
                "Inscrivez-vous",
                style: TextStyle(
                  color: Color(ColorUtil.getColorHexFromStr("#828282")),
                  fontSize: 25.0
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 12.0),
                child: Text(
                  "Nous t’aidons à partager vos avis et émotions grâce à notre application, créer un compte pour commencer",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(ColorUtil.getColorHexFromStr("#828282")),
                    fontSize: 14,
                    textBaseline: TextBaseline.ideographic
                  ),
                ),
              ),
              SizedBox(
                height: 25.0,
              ),
              CustumTextField(
                hintText: "Pseudo",
                controller: _textPseudoController, 
                errorMessage: pseudodError,
                isPassword: false,
              ),
              CustumTextField(
                controller: _textPasswordController, 
                errorMessage: passwordError,
                hintText: "Mot de passe",
                isPassword: true,
              ),
            ],
          ),
          Positioned(
            bottom: 55,
            right: 30,
            child: InkWell(
              onTap: (){
                if (_textPasswordController.text.contains(" ")) {
                  ErrorInfoDialog.showInfoDialog(context, "Vous ne pouvez pas soumettre un mot de passe contenant des erreur");
                }
                UserService.instance.getUserPseudoExist(_textPseudoController.text)
                  .then((exist) async{
                    if (exist) {
                      ErrorInfoDialog.showInfoDialog(context, "Erreur le pseudo que vous avez entré est déjà pris.");
                    }else{
                      var user = new UserModel(
                        password: _textPasswordController.text,
                        pseudo: _textPseudoController.text
                      );
                      SharedPreferences _prefs = await SharedPreferences.getInstance();
                      _prefs.setString("pseudo", _textPseudoController.text.trim());
                      UserService.instance.post(user).then((e){
                        UserState.intance.currentUser = user;
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return HellWidget();
                        }));
                      });
                
                    }
                  });
                  widget.onCompleted();

              },
              child: Container(
                child: Padding(
                  child: Text(
                    "Suivant",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ), 
                  padding: EdgeInsets.symmetric(horizontal: 21, vertical: 10),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Color(ColorUtil.getColorHexFromStr("#2f2e41"))
                ),
              ),
            ),
          ),
        ],
       ),
    );
  }
}

class CustumTextField extends StatelessWidget {


  const CustumTextField({
    Key key,
    @required TextEditingController controller,
    @required this.errorMessage,
    this.hintText,
    this.isPassword
  }) : _controller = controller, super(key: key);

  final String hintText;
  final String errorMessage;
  final TextEditingController _controller;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 100.0, vertical: 0.0),
    child: Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Color(ColorUtil.getColorHexFromStr("#828282")), width: 1.5),
            borderRadius: BorderRadius.circular(50.0)
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: _controller,
              obscureText: this.isPassword,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                border: InputBorder.none,
                hintText: this.hintText
              ),
            ), 
          ),
        ),
        this.errorMessage == "" ?
        Text("") :
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            this.errorMessage,
            style: TextStyle(
              color: Colors.red.withOpacity(0.6)
            ),
          ),
        ) 
      ],
    ),
              );
  }
}