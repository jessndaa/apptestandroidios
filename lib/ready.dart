import 'package:apptest/main_app.dart';
import 'package:apptest/theme/apptheme.dart';
import 'package:apptest/utils/ColorUtil.dart';
import 'package:flutter/material.dart';

class ReadyWidget extends StatefulWidget {
  ReadyWidget({Key key}) : super(key: key);

  @override
  _ReadyWidgetState createState() => _ReadyWidgetState();
}

class _ReadyWidgetState extends State<ReadyWidget> with SingleTickerProviderStateMixin {

  Animation<double> helloAnimation, preparingAnimation, endAnimation ;

  AnimationController controller;
  bool animEnded = false;
  @override
  void initState() { 
    super.initState();
    controller = new AnimationController(duration: Duration(milliseconds: 2000 ), vsync: this);
    helloAnimation = new Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      curve: Curves.easeOutSine,
      parent: controller,
    ));
    helloAnimation.addStatusListener((AnimationStatus status){
      if (status == AnimationStatus.completed) {
        setState(() {
          animEnded= true;
        });
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
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Transform(
                      transform: Matrix4.translationValues(0.0, helloAnimation.value* -100.0, 0.0),
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(35.0),
                          child: Text(
                            "Tout est prêt, vous pouvez commencez",
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
                  SizedBox(
                    height: 50.0,
                  ),
                  Opacity(
                    opacity: animEnded? 1.0 : 0.0 ,
                    child: InkWell(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                          return MainApp();
                        }));
                      },
                      child: Container(
                        child: Padding(
                          child: Text(
                            "Commencez",
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
                  )
                ],
              );
            }
          )
        )
      )
    );
  }
}