import 'package:apptest/preparing.dart';
import 'package:apptest/states/user.state.dart';
import 'package:apptest/utils/ColorUtil.dart';
import 'package:flutter/material.dart';
import './theme/apptheme.dart';

class HellWidget extends StatefulWidget {
  HellWidget({Key key}) : super(key: key);

  @override
  _HellWidgetState createState() => _HellWidgetState();
}

class _HellWidgetState extends State<HellWidget> with SingleTickerProviderStateMixin {

  Animation<double> helloAnimation, preparingAnimation, endAnimation ;

  AnimationController controller;
  bool helloEnd = false;
  @override
  void initState() { 
    super.initState();
    helloEnd = false;
    controller = new AnimationController(duration: Duration(milliseconds: 2000 ), vsync: this);
    helloAnimation = new Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      curve: Curves.easeOutSine,
      parent: controller,
    ));
    helloAnimation.addStatusListener((AnimationStatus status){
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(context, new MaterialPageRoute(
          builder: (context){
            return new PreparingWidget();
          }
        ));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    controller.forward();
    return Scaffold(
          body: Container(
        decoration: BoxDecoration(
          color: Color(ColorUtil.getColorHexFromStr(AppTheme.MIN_COLOR_THEME))
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: AnimatedBuilder(
          animation: helloAnimation,
          builder: (BuildContext context, Widget child) { 
            return Stack(
              children: <Widget>[
                Center(
                  child: Transform(
                    transform: Matrix4.translationValues(0.0, helloAnimation.value* -100.0, 0.0),
                    child: Container(
                      child: Text(
                        "Bonjour " + UserState.intance.currentUser.pseudo,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
        )
      ),
    );
  }
}