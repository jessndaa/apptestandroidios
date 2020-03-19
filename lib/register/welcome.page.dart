
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../theme/apptheme.dart';
import '../utils/ColorUtil.dart';
// import 'package:lukapay/utils/ColorUtil.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key, this.onCompleted}) : super(key: key);

  final Function onCompleted;
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: <Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 150,
                  child: Image(image: AssetImage("assets/images/welcome.png")),
                ),
                SizedBox(height: 50.0,),
                Text(
                  "Bienvenue",
                  style: TextStyle(
                    color: Color(ColorUtil.getColorHexFromStr("#828282")),
                    fontSize: 25.0
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 25.0),
                  child: Text(
                    "Nous t’aidons à utiliser ton savoir pour poster des informations partout sur vos comptes mobile à travers le monde.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(ColorUtil.getColorHexFromStr("#828282")),
                      fontSize: 14,
                      textBaseline: TextBaseline.ideographic
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 55,
            right: 30,
            child: InkWell(
              onTap: widget.onCompleted,
              child: SafeArea(
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
          ),
         ],
       ),
    );
  }
}