import 'dart:async';

import 'package:flutter/material.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';

class PaymentResponse extends StatefulWidget {
  final String token;
  final int status; // sucess =>1 or faield =>.0
  final int user_id;
  final String salon_name;
  final String bill_number;
  final String city;
  final String bill_cost;
  final String opertion_date;
  PaymentResponse({this.token, this.status = 1, this.user_id,this.salon_name,this.city,this.bill_cost,this.bill_number,this.opertion_date});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return PaymentResponseState();
  }
}

class PaymentResponseState extends State<PaymentResponse> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            AppLocalization.of(context).translate('bill'),
            style: TextStyle(fontFamily: AqarFont.font_family),
          ),
          backgroundColor: AppColor.primary_color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
        ),
        body: (widget.status==0) ?
        Directionality(
          textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,
          child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.payment,
                  size: 50,
                ),
                SizedBox(
                  height: 20,
                ),
                 Text(
                  AppLocalization.of(context).translate('bill_problem'),
                  style: TextStyle(
                      fontFamily: AqarFont.font_family,
                      color: Color(0xFFC5ABAB),
                      fontWeight: FontWeight.bold,
                      fontSize: 21),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.width / 7,
                    child: new RaisedButton(
                      onPressed: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                              builder: (BuildContext contex) => OrdersPage(
                                token: widget.token,
                                user_id: widget.user_id,
                              )));
                        
                      },
                      child: new Text(
                        "أنهاء ",
                        style: TextStyle(
                            color: AppColor.primary_color,
                            fontFamily: AqarFont.font_family,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        side: BorderSide(
                          color: Color(0xFF707070),
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        )
            : Directionality(
          textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,
          child: Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15,right: 0,left: 10),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 5,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Column(
                        children: [
                          Text(
                            AppLocalization.of(context).translate('city'),
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: AqarFont.font_family,
                                fontSize: 18),
                          ),
                          Text(
                            '${widget.city}',
                            style: TextStyle(
                                color: AppColor.primary_color,
                                fontFamily: AqarFont.font_family,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15,right: 0,left: 10),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width / 5,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Column(
                        children: [
                          Text(
                            AppLocalization.of(context).translate('bill_num'),
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: AqarFont.font_family,
                                fontSize: 18),
                          ),
                          Text(
                            '${widget.bill_number}',
                            style: TextStyle(
                                color: AppColor.primary_color,
                                fontFamily: AqarFont.font_family,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20,right: 0,left: 10),
                  child: Table(
                    textDirection: TextDirection.ltr,
                    border: TableBorder.all(width: 1.0, color: Colors.grey),
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    children: [
                      TableRow(
                          children: [
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            "${widget.salon_name}  ",
                            textScaleFactor: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color:AppColor.primary_color,
                              fontFamily: AqarFont.font_family,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8),
                          child: Text(
                            AppLocalization.of(context).translate('center_name'),
                            textScaleFactor: 1,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: AqarFont.font_family,
                                fontSize: 16),
                          ),
                        ),
                      ]),

                      TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "${widget.status==1? AppLocalization.of(context).translate('sucess'):AppLocalization.of(context).translate('fail')}  ",
                                textScaleFactor: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColor.primary_color,
                                    fontFamily: AqarFont.font_family,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                AppLocalization.of(context).translate('pay_status'),

                                textScaleFactor: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: AqarFont.font_family,
                                    fontSize: 16),
                              ),
                            ),
                          ]),
                      TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "${widget.bill_cost} ${AppLocalization.of(context).translate('sr')}  ",
                                textScaleFactor: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColor.primary_color,
                                    fontFamily: AqarFont.font_family,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                AppLocalization.of(context).translate('bill_value'),
                                textScaleFactor: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: AqarFont.font_family,
                                    fontSize: 16),
                              ),
                            ),
                          ]),
                      TableRow(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "${widget.opertion_date}  ",
                                textScaleFactor: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColor.primary_color,
                                    fontFamily: AqarFont.font_family,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                AppLocalization.of(context).translate('bill_date'),
                                textScaleFactor: 1,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontFamily: AqarFont.font_family,
                                    fontSize: 16),
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.width / 7,
                    child: new RaisedButton(
                      onPressed: () {
                        if (widget.status == 1) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext contex) =>
                                      MyReservation(
                                        token: widget.token,
                                        user_id: widget.user_id,
                                      )));
                        } else {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (BuildContext contex) => OrdersPage(
                                        token: widget.token,
                                        user_id: widget.user_id,
                                      )));
                        }
                      },
                      child: new Text(
                       AppLocalization.of(context).translate('end'),
                        style: TextStyle(
                            color: AppColor.primary_color,
                            fontFamily: AqarFont.font_family,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        side: BorderSide(
                          color: Color(0xFF707070),
                        ),
                      ),
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
