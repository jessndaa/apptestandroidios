import 'dart:async';

import 'package:apptest/model/NewsModel.dart';
import 'package:apptest/service/NewsService.dart';
import 'package:apptest/states/user.state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import './dialog/info.dialog.dart';
import 'bloc/news.stream.dart';

class MainApp extends StatefulWidget {
  MainApp({Key key}) : super(key: key);

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  final Firestore firestore = new Firestore();
  
  bool isInitial = true;
  @override
  void initState() {
    
    // NewsService.instance.getAllExecpt("cpp").then((news){
    //   NewsStream.intance.setNews(news);
    // });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            InfoDialog.showInfoDialog(context);
          },
          child: Icon(Icons.message),
        ),
        body: SingleChildScrollView(
          child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                   SafeArea(
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 45.0,
                          ),
                          Container(
                           child: Row(
                             children: <Widget>[
                               Expanded(child: Container(
                                 alignment: Alignment.centerLeft,
                                 height: 40,
                                 child: Stack(
                                   children: <Widget>[
                                     StreamBuilder<int>(
                                       stream: NewsStream.intance.newsComeEventHandler$,
                                       builder: (context, snapshot) {
                                         return (snapshot.hasData &&  snapshot.data >= 1) ?
                                          Positioned(
                                          left: 25.0,
                                          child: InkWell(
                                            onTap: (){
                                              NewsStream.intance.resetCount();
                                            },
                                            child: Container(
                                               width: 22,
                                               height: 22,
                                               child: Center(
                                                 child: Text(snapshot.data.toString(), style: TextStyle(
                                                   color: Colors.white,
                                                   fontWeight: FontWeight.bold
                                                 ),),
                                               ),
                                               decoration: BoxDecoration(
                                                 shape: BoxShape.circle,
                                                 color: Colors.red
                                               ),
                                             ),
                                          ),
                                         ) : Container();
                                       }
                                     ),
                                     IconButton(icon: Icon(Icons.notifications), onPressed: null),
                                   ],
                                 ),
                               )),
                               Expanded(
                                 child: Container(
                                 height: 40,
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.center,
                                   crossAxisAlignment: CrossAxisAlignment.end,
                                   children: <Widget>[
                                      Padding(
                                       padding: EdgeInsets.only(right: 15),
                                      child: Container(
                                         width: 120,
                                         height: 35,
                                         child: Row(
                                           children: <Widget>[
                                            Padding(
                                              child: Icon(Icons.search, color: Colors.black45,), 
                                              padding: EdgeInsets.only(
                                                left: 12.0
                                              ),
                                            ),
                                             Text("Rechercher",
                                             style: TextStyle(
                                               fontSize: 13.0,
                                               color: Colors.black54
                                             ),)
                                           ],
                                         ),
                                         decoration: BoxDecoration(
                                           borderRadius: BorderRadius.circular(20.0),
                                           color: Colors.black12.withOpacity(0.1)
                                         ),
                                       ),
                                     ),

                                   ],
                                 ),
                               )),
                             ],
                           ),
                     ),
                        ],
                      ),
                   ),
                   //text indication
                   Expanded(
                     flex: 1,
                     child: 
                   Container(
                     padding: EdgeInsets.only(left: 35.0),
                     alignment: Alignment.topLeft,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: <Widget>[
                         SizedBox(
                           height: 15.0,
                         ),
                         Text("Ajourd'hui", style: TextStyle(
                           fontSize: 25.0,
                           color: Colors.black87
                         ),),
                         SizedBox(
                           height: 5.0,
                         ),
                         Text("12 Mars 2020", style: TextStyle(
                           fontSize: 14.0,
                           color: Colors.black45
                         ),)
                       ],
                     ),
                   )),
                   // text diffusseur
                  //  Expanded(
                  //    flex: 2,
                  //    child: 
                  //  Container(
                  //    child: Column(
                  //      mainAxisAlignment: MainAxisAlignment.start,
                  //      children: <Widget>[
                  //        Container(
                  //          width: 380,
                  //          height: 80,
                  //          decoration: BoxDecoration(
                  //            color: Colors.white,
                  //            borderRadius: BorderRadius.circular(15.0),
                  //            boxShadow: [
                  //              BoxShadow(color: Colors.black45.withOpacity(0.02), blurRadius: 10.0
                  //           )]
                  //          ),
                  //        )
                  //      ],
                  //    ),
                  //  )),
                   // app conten filter
                  Expanded(
                    flex: 8,
                    child: StreamBuilder<QuerySnapshot>(
                      stream: firestore.collection("news")
                        .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData ) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(child: CircularProgressIndicator()),
                            ],
                          );
                        }
                        return ListView.builder(
                          itemCount: snapshot.data.documents.length,
                          itemBuilder: (context, i) {
                            print(UserState.intance.isInitial);
                            if (!(snapshot.data.documents[i]
                                    .data["sender"].toString() == 
                                    UserState.intance.currentUser.pseudo)) {
                              if (!UserState.intance.isInitial) {
                                UserState.intance.isInitial = false;
                                NewsStream.intance.setCount(snapshot.data.documentChanges.length);
                              }
                            }
                            print(snapshot.data.documents[i].data["title"]);
                            return snapshot.data.documents[i]
                                    .data["sender"].toString() == 
                                    UserState.intance.currentUser.pseudo ? Container() : Column(
                              children: <Widget>[
                                ActualiteWidget(
                                  title: snapshot.data.documents[i].data["title"],
                                  message: snapshot.data.documents[i].data["message"],
                                  sender: snapshot.data.documents[i].data["sender"],
                                  dateTime: snapshot.data.documents[i].data["time"],
                                ),
                                SizedBox(height: 35.0,)
                              ],
                            );
                          }
                        );
                      }
                    )
                  ),
                 ],
               ),
            ),
          ],
      ),
        ),
    );
  }
}

class ActualiteWidget extends StatelessWidget {
  const ActualiteWidget({
    Key key,
    this.title,
    this.message,
    this.dateTime,
    this.sender
  }) : super(key: key);

  final String title;
  final String message;
  final String dateTime;
  final String sender;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              children: <Widget>[
                Container(
                  height: 45.0,
                  width: 45.0,
                  child: Center(child: Text(this.sender.toUpperCase().substring(0, 1), style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white
                  ),)),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(width: 15,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(this.sender, style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16.0
                    ),),
                    SizedBox(
                      height: 3.0,
                    ),
                    Text(this.dateTime, style: TextStyle(
                      color: Colors.black45,
                      fontSize: 11.0
                    ),)
                  ],
                )
              ],
            ),
          ),
          // ListView.builder(itemBuilder: (context, i){
          //   return 
          // });
          SizedBox(
            height: 15.0,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(this.title,
                  style: TextStyle(
                    fontSize: 25.0
                  ),
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text(this.message,
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 15.0
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}