import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';
import 'package:salonic/View/Notifications/notification_model.dart';

class Notifications extends StatefulWidget {
  final String token;
  final int user_id;
  Notifications({this.token, this.user_id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Notifications_state();
  }
}

class Notifications_state extends State<Notifications> {
  bool notifications_found = true;
  var style = TextStyle(fontFamily: AqarFont.font_family);
  int _currentIndex;
  Future<List<NotificationModel>> notificationsList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = 2;
    if (widget.token == StaticMethods.vistor_token) {
      notificationsList = null;
    } else {
      notificationsList = ApiProvider.getUserNotifications(
          widget.token, widget.user_id, context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    notificationsList = null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(
              AppLocalization.of(context).translate('notification'),
              style: TextStyle(fontFamily: AqarFont.font_family),
            ),
            backgroundColor: AppColor.primary_color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigation(
            index: _currentIndex,
          ),
          body: Directionality(
            textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,
            child: (notificationsList == null)
                ? VistorMessage()
                : FutureBuilder<List<NotificationModel>>(
                    future: notificationsList,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasData) {
                          if (snapshot.data.length != 0) {
                            return ListView.builder(
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, index) {
                                  return Container(
                                      padding: EdgeInsets.all(10),
                                      width: MediaQuery.of(context).size.width,
                                      //height:  MediaQuery.of(context).size.width/3,
                                      child: Row(
                                        children: <Widget>[
                                          Expanded(
                                              flex: 2,
                                              child: Container(
                                                child: Image(
                                                  //width:MediaQuery.of(context).size.width/8 ,
                                                  image: AssetImage(
                                                      'images/notifications/Hair_Salon.png'),
                                                  fit: BoxFit.fitHeight,
                                                  alignment: Alignment.topCenter,
                                                ),
                                              )
                                          ),
                                          Expanded(
                                              flex: 5,
                                              child: Directionality(
                                                  textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,
                                                  child:Container(
                                                padding:
                                                    EdgeInsets.only(right: 10,left: 10),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      '${(snapshot.data[index].salon == null) ? ' ' : snapshot.data[index].salon.name}',
                                                      style: TextStyle(
                                                          fontFamily: AqarFont.font_family,
                                                          fontSize: 14),
                                                    ),
                                                    Text(
                                                      '${(snapshot.data[index].title == null) ? ' ' : snapshot.data[index].title}',
                                                      style: TextStyle(
                                                          fontFamily: AqarFont.font_family,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12),
                                                    ),
                                                    Text(
                                                      '${(snapshot.data[index].message == null) ? ' ' : snapshot.data[index].message}',
                                                      style: TextStyle(
                                                          fontFamily: AqarFont.font_family,
                                                          fontSize: 12),
                                                    ),
                                                  ],
                                                ),
                                              )),
                                          ),
                                          Expanded(
                                              flex: 3,
                                              child: Column(
                                                children: <Widget>[
                                                  Container(
                                                      padding: EdgeInsets.only(
                                                          top: 7),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 5),
                                                        child:Directionality(
                                                          textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,
                                                          child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Icon(
                                                              Icons.access_time,
                                                              color: Color(
                                                                  0xFF292929),
                                                              size: 15,
                                                            ),
                                                            SizedBox(
                                                              width: 3,
                                                            ),
                                                            Text(
                                                              ' ${snapshot.data[index].time}',
                                                              style: TextStyle(
                                                                color: Color(
                                                                    0xFF292929),
                                                                fontFamily:
                                                                    AqarFont.font_family,
                                                                fontSize: 12
                                                              ),
                                                            ),
                                                          ],
                                                        ),),
                                                      )),
                                                  SizedBox(
                                                    height: 5,
                                                  ),
                                                  InkWell(
                                                    child: Image(
                                                      image: AssetImage(
                                                          'images/notifications/delete1.png'),
                                                      fit: BoxFit.cover,
                                                      width: 20,
                                                    ),
                                                    onTap: () {
                                                      setState(() {
                                                        ApiProvider
                                                            .deleteNotification(
                                                                widget.token,
                                                                snapshot
                                                                    .data[index]
                                                                    .id,
                                                                context);
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (BuildContext
                                                                        context) =>
                                                                    super
                                                                        .widget));
                                                      });

                                                      // delete one notification
                                                    },
                                                  )
                                                ],
                                              )),
                                        ],
                                      ),
                                    );
                                });
                          } else {
                            return Directionality(
                              textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,
                              child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image(
                                      image: AssetImage(
                                          'images/notifications/notification.png'),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      AppLocalization.of(context).translate('no_notification'),
                                      style: TextStyle(
                                          fontFamily: AqarFont.font_family,
                                          color: Color(0xFFC5ABAB),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 21),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                        } else {
                          return Directionality(
                            textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,
                            child: Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image(
                                    image: AssetImage(
                                        'images/notifications/notification.png'),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    AppLocalization.of(context).translate('no_notification'),
                                    style: TextStyle(
                                        fontFamily: AqarFont.font_family,
                                        color: Color(0xFFC5ABAB),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 21),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
          ),
        ));
  }
}
