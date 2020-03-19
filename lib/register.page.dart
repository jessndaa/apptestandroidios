import 'package:flutter/material.dart';
import 'register/sim.page.dart';
import 'register/welcome.page.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final PageController _controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: PageView(
         controller: _controller,
         children: <Widget>[
           WelcomePage(onCompleted: (){
             print("Helo");
             _controller.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
           },),
           SimPage(onCompleted: (){
             
           },)
         ],
       ),
    );
  }
}