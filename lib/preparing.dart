import 'package:apptest/ready.dart';
import 'package:flutter/material.dart';
import './theme/apptheme.dart';
import './utils/ColorUtil.dart';

class PreparingWidget extends StatefulWidget {
  PreparingWidget({Key key}) : super(key: key);

  @override
  _PreparingState createState() => _PreparingState();
}

class _PreparingState extends State<PreparingWidget> with SingleTickerProviderStateMixin {

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
            return new ReadyWidget();
          }
        ));
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    controller.forward();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
                        child: Padding(
                          padding: const EdgeInsets.all(50.0),
                          child: const Text(
                            "Nous préparons votre environement ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0
                            ),
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
      )
    );
  }
}