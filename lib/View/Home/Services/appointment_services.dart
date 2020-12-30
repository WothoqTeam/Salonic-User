import 'dart:math';

import 'package:flutter/material.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';

class AppointmentService extends StatefulWidget {
  final String token;

  final int home_services;
  AppointmentService({this.token, this.home_services});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AppointmentServiceState();
  }
}

class AppointmentServiceState extends State<AppointmentService> {
  Future<List<ServiceModel>> appointServiceList;
  SharedPreferences sharedPrefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        sharedPrefs = prefs;
      });
    });
    appointServiceList = ApiProvider.getAppointmentServiceList(
        (widget.token == StaticMethods.vistor_token)
            ? StaticMethods.vistor_token
            : widget.token,
        widget.home_services,
        context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    appointServiceList = null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder<List<ServiceModel>>(
      future: appointServiceList,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            if (snapshot.data.length != 0) {
              return Container(
                height: MediaQuery.of(context).size.width/1.5,
                padding: EdgeInsets.all(15),
                child: GridView.builder(
                    itemCount: snapshot.data.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    gridDelegate:
                    SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio:1.8,
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemBuilder: (BuildContext context, index) {
                      return InkWell(
                        child: Column(children: <Widget>[
                          Card(
                            color: Color(0xFFF6F6F6),
                            child: Image.network(
                              snapshot.data[index].icon,
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context)
                                  .size
                                  .width /
                                  6,
                              height: MediaQuery.of(context)
                                  .size
                                  .width /
                                  7,
                            ),
                          ),
                          Center(
                            child: Text(
                              '${snapshot.data[index].name}',
                              style:
                              TextStyle(fontFamily: AqarFont.font_family),
                            ),
                          )
                        ]),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SalonicListByServiceId(
                                        token: (sharedPrefs.getString(
                                            'user_access_token') ==
                                            null)
                                            ? StaticMethods
                                            .vistor_token
                                            : sharedPrefs.getString(
                                            'user_access_token'),
                                        service_id: snapshot
                                            .data[index].id,
                                        service_type: 0,
                                      )));
                        },
                      );
                    }),
              );
            } else {
              return Directionality(
                textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,                child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.work,
                        size: 80,
                        color: Color(0xFFC5ABAB),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        AppLocalization.of(context).translate('no_service'),
                        style: TextStyle(
                            fontFamily: AqarFont.font_family,
                            color: Color(0xFFC5ABAB),
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )
                    ],
                  ),
                ),
              );
            }
          }
        }

        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
