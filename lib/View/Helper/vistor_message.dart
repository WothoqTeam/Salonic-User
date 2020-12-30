import 'package:flutter/material.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';
import 'package:salonic/View/User_Sign/user_sigin.dart';

class VistorMessage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return VistorMessageStatus();
  }
}

class VistorMessageStatus extends State<VistorMessage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(
            image: AssetImage('images/background/salonic_logo.png'),
            fit: BoxFit.fill,
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.width / 2,
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              AppLocalization.of(context).translate('visitor_txt'),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
          ),
          RaisedButton(
            color: AppColor.primary_color,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                AppLocalization.of(context).translate('visitor_btn'),
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserSignIn()));
            },
          )
        ],
      ),
    );
  }
}
