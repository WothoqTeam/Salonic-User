import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';

void errorDialog({BuildContext context, String text, Function function}) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Container(
            height: MediaQuery.of(context).size.width / 2,
            width: MediaQuery.of(context).size.width / 2,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    text ?? "",
                    style: TextStyle(
                        color:AppColor.primary_color,
                        fontFamily: "Cairo",
                        fontSize: 18),
                  )
                ],
              ),
            ),
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text(
                "ok",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: "Cairo",
                  color: AppColor.primary_color,
                ),
              ),
              onPressed: function ?? () => Navigator.pop(context),
            )
          ],
        );
      });
}
