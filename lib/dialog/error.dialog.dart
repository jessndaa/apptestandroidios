import 'package:flutter/material.dart';
import '../utils/ColorUtil.dart';

class ErrorInfoDialog {
  static showInfoDialog(BuildContext context, String message){
showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 55.0, horizontal: 50.0),
                child: Text(message, style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.red.withOpacity(0.4)
                ),),
              )
            )
          ],
        );
      });
  }
}

class TextBoxWidget extends StatelessWidget {
  final double width;
  final double height;
  final TextEditingController controller;
  final String hintText;
  const TextBoxWidget({
    Key key,
    this.width,
    this.height,
    this.controller,
    this.hintText
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: <Widget>[
        Positioned(
          top: 0.0,
          left: 0,
          child: Container(
            width: this.width,
            height: this.height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.black12.withOpacity(0.04),

            ),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          width: this.width,
          height: this.height,
          child: TextField(
            controller: this.controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
              border: InputBorder.none,
              hintText: this.hintText
            ),
          ),
        ),
      ],
    );
  }
}