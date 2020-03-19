import 'package:apptest/model/NewsModel.dart';
import 'package:apptest/service/NewsService.dart';
import 'package:apptest/service/UserService.dart';
import 'package:apptest/states/user.state.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../utils/ColorUtil.dart';

class InfoDialog {
  static showInfoDialog(BuildContext context){
showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {

        TextEditingController _titleController = new TextEditingController();
        TextEditingController _messageController = new TextEditingController();

        return new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)
              ),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    TextBoxWidget(
                      width: 108.0,
                      height: 45.0,
                      hintText: "Titre",
                      controller: _titleController,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    TextBoxWidget(
                      width: 250.0,
                      height: 105.0,
                      hintText: "Message",
                      controller: _messageController,
                    ),
                    Container(
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          SizedBox(height: 20.0,),
                          InkWell(
                            onTap: (){

                              var now = new DateTime.now();
                              NewsService.instance.post(new NewsModel(
                                sender: UserState.intance.currentUser.pseudo,
                                message: _messageController.text,
                                title: _titleController.text,
                                time: now.toIso8601String()
                                        .toUpperCase()
                                          .replaceAll(r"T", " ").split(".")[0]
                              ))
                              .then((c){
                                Navigator.of(context).pop();
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                              child: Text("Poster", style: TextStyle(
                                color: Colors.white
                              ),),
                              decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(20.0)
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
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