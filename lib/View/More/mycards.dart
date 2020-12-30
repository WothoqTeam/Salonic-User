import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salonic/Custom_Widgets/custom_textfield.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';
import 'package:salonic/Model/card_model.dart';
import 'package:salonic/Model/order_model.dart';

class MyCards extends StatefulWidget {
  final String token;
  final int user_id;
  MyCards({this.token, this.user_id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyCards_State();
  }
}

class MyCards_State extends State<MyCards> {
  TextEditingController _card_number;
  TextEditingController _exp_month;
  TextEditingController _exp_year;
  TextEditingController _card_name;
  TextStyle style = TextStyle(
      color: Colors.black,
      fontFamily: AqarFont.font_family,
      fontSize: 16,
      fontWeight: FontWeight.bold);

  Future<List<CardModel>> creditCardsList;
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
    _card_number = TextEditingController();
    _exp_month = TextEditingController();
    _exp_year = TextEditingController();
    _card_name = TextEditingController();

    if (widget.token == StaticMethods.vistor_token) {
      creditCardsList = null;
    } else {
      creditCardsList =
          ApiProvider.getUserCards(widget.token, widget.user_id, context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    creditCardsList = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            AppLocalization.of(context).translate('card'),
            style: TextStyle(
              fontFamily: AqarFont.font_family,
              color: Color(0xFFFFFFFF),
            ),
          ),
          backgroundColor: AppColor.primary_color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(10),
            ),
          ),
        ),
        floatingActionButton:(widget.token == StaticMethods.vistor_token)? null: FloatingActionButton(
          backgroundColor: AppColor.primary_color,
          child: Icon(
            Icons.add,
            size: 25,
          ),
          onPressed: () {
            add_card();
          },
        ),
        body: WillPopScope(
          onWillPop: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MorePage()));
          },
          child: Padding(
            padding: EdgeInsets.only(top: 10, left: 5, right: 5),
            child: Directionality(
              textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,              child: (creditCardsList == null)
                  ? VistorMessage()
                  : FutureBuilder<List<CardModel>>(
                      future: creditCardsList,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData) {
                            if (snapshot.data.length != 0) {
                              return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (BuildContext context, index) {
                                    (
                                        'card nuber :${snapshot.data[index].number}');
                                    return Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Card(
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(top: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10,
                                                                right: 10),
                                                        child: Text(
                                                          AppLocalization.of(context).translate('card_num'),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  AqarFont.font_family,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                        ),
                                                        child: new Container(
                                                          child: TextFormField(
                                                            readOnly: true,
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  new EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          5.0,
                                                                      horizontal:
                                                                          5.0),
                                                              filled: true,
                                                              fillColor: Color(
                                                                  0xFFF6F6F6),
                                                              hintText:
                                                                  '${snapshot.data[index].number}',
                                                              hintStyle:
                                                                  TextStyle(
                                                                color: Color(
                                                                    0xFF986667),
                                                                fontFamily:
                                                                    AqarFont.font_family,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                                borderSide:
                                                                    const BorderSide(
                                                                  color: Color(
                                                                      0xFFF6F6F6),
                                                                  width: 1.0,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(top: 5),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10,
                                                                right: 10),
                                                        child: Text(
                                                          AppLocalization.of(context).translate('expire_date'),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  AqarFont.font_family,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                        ),
                                                        child: new Row(
                                                          children: <Widget>[
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  3,
                                                              child:
                                                                  TextFormField(
                                                                readOnly: true,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                decoration:
                                                                    InputDecoration(
                                                                  contentPadding: new EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          5.0,
                                                                      horizontal:
                                                                          5.0),
                                                                  filled: true,
                                                                  fillColor: Color(
                                                                      0xFFF6F6F6),
                                                                  hintText:
                                                                      ' ${snapshot.data[index].expMonth}',
                                                                  hintStyle: TextStyle(
                                                                      color: Color(
                                                                          0xFF986667),
                                                                      fontFamily:
                                                                          AqarFont.font_family,
                                                                      fontSize:
                                                                          16,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold),
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5.0),
                                                                    borderSide:
                                                                        const BorderSide(
                                                                      color: Color(
                                                                          0xFFF6F6F6),
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            Spacer(),
                                                            Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width /
                                                                  3,
                                                              child:
                                                                  TextFormField(
                                                                readOnly: true,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .number,
                                                                decoration:
                                                                    InputDecoration(
                                                                  contentPadding: new EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          5.0,
                                                                      horizontal:
                                                                          5.0),
                                                                  filled: true,
                                                                  fillColor: Color(
                                                                      0xFFF6F6F6),
                                                                  hintText:
                                                                      ' ${snapshot.data[index].expYear}',
                                                                  hintStyle:
                                                                      TextStyle(
                                                                    color: Color(
                                                                        0xFF986667),
                                                                    fontFamily:
                                                                        AqarFont.font_family,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                  border:
                                                                      InputBorder
                                                                          .none,
                                                                  enabledBorder:
                                                                      OutlineInputBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5.0),
                                                                    borderSide:
                                                                        const BorderSide(
                                                                      color: Color(
                                                                          0xFFF6F6F6),
                                                                      width:
                                                                          1.0,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      top: 5, bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 10,
                                                                right: 10),
                                                        child: Text(
                                                          AppLocalization.of(context).translate('cust_name'),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  AqarFont.font_family,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                          left: 10,
                                                          right: 10,
                                                        ),
                                                        child: new Container(
                                                          child: TextFormField(
                                                            readOnly: true,
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            decoration:
                                                                InputDecoration(
                                                              contentPadding:
                                                                  new EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          5.0,
                                                                      horizontal:
                                                                          5.0),
                                                              filled: true,
                                                              fillColor: Color(
                                                                  0xFFF6F6F6),
                                                              hintText:
                                                                  ' ${snapshot.data[index].holderName}',
                                                              hintStyle:
                                                                  TextStyle(
                                                                color: Color(
                                                                    0xFF986667),
                                                                fontFamily:
                                                                    AqarFont.font_family,
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5.0),
                                                                borderSide:
                                                                    const BorderSide(
                                                                  color: Color(
                                                                      0xFFF6F6F6),
                                                                  width: 1.0,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      top: 10,
                                                      right: 20,
                                                      left: 20,
                                                      bottom: 10),
                                                  child: Row(
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            2.7,
                                                        child: new RaisedButton(
                                                          onPressed: () {
                                                            update_card(
                                                                snapshot
                                                                    .data[index]
                                                                    .number,
                                                                snapshot
                                                                    .data[index]
                                                                    .expMonth,
                                                                snapshot
                                                                    .data[index]
                                                                    .expYear,
                                                                snapshot
                                                                    .data[index]
                                                                    .holderName,
                                                                snapshot
                                                                    .data[index]
                                                                    .id);
                                                          },
                                                          child: new Text(
                                                          AppLocalization.of(context).translate('edit'),
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF986667),
                                                                fontFamily:
                                                                    AqarFont.font_family,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16),
                                                          ),
                                                          shape:
                                                              new RoundedRectangleBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                        .circular(
                                                                    5.0),
                                                            side: BorderSide(
                                                              color: Color(
                                                                  0xFF707070),
                                                            ),
                                                          ),
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            2.7,
                                                        child: new RaisedButton(
                                                          onPressed: () async {
                                                            await ApiProvider
                                                                .deleteCreditCard(
                                                                    sharedPrefs
                                                                        .getString(
                                                                            'user_access_token'),
                                                                    snapshot
                                                                        .data[
                                                                            index]
                                                                        .id,
                                                                    snapshot
                                                                        .data[
                                                                            index]
                                                                        .userId,
                                                                    context);
                                                          },
                                                          child: new Text(
                                                            AppLocalization.of(context).translate('delete'),
                                                            style: TextStyle(
                                                                color: Color(
                                                                    0xFF986667),
                                                                fontFamily:
                                                                    AqarFont.font_family,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 16),
                                                          ),
                                                          shape:
                                                              new RoundedRectangleBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                        .circular(
                                                                    5.0),
                                                            side: BorderSide(
                                                              color: Color(
                                                                  0xFF707070),
                                                            ),
                                                          ),
                                                          color: Colors.white,
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
                            } else {
                              return Directionality(
                                textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,                                child: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        image: AssetImage(
                                            'images/background/salonic_logo.png'),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        AppLocalization.of(context).translate('no_Cards'),
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
                              textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,                              child: Container(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Image(
                                      width:
                                          MediaQuery.of(context).size.width / 3,
                                      height:
                                          MediaQuery.of(context).size.height /
                                              4,
                                      image: AssetImage(
                                          'images/background/salonic_logo.png'),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      AppLocalization.of(context).translate('no_Cards'),
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
          ),
        ));
  }

  Future<Widget> add_card() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            var height = MediaQuery.of(context).size.height;
            var width = MediaQuery.of(context).size.width;
            return Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: AlertDialog(
                contentPadding: EdgeInsets.all(0.0),
                content: SafeArea(
                  child: SingleChildScrollView(
                    child: Directionality(
                      textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,                      child: new Container(
                          width: width,
                          height: height / 1.7,
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                          AppLocalization.of(context).translate('card_num'),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: AqarFont.font_family,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                        ),
                                        child: new Container(
                                          child: TextFormField(
                                            controller: _card_number,
                                            keyboardType: TextInputType.number,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  new EdgeInsets.symmetric(
                                                      vertical: 5.0,
                                                      horizontal: 5.0),
                                              filled: true,
                                              fillColor: Color(0xFFF6F6F6),
                                              hintText:
                                              AppLocalization.of(context).translate('card_num'),
                                              hintStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: AqarFont.font_family,
                                                  fontSize: 10,
                                                  fontWeight:
                                                      FontWeight.normal),
                                              border: InputBorder.none,
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: const BorderSide(
                                                  color: Color(0xFFF6F6F6),
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                         AppLocalization.of(context).translate('expire_date'),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: AqarFont.font_family,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                        ),
                                        child: new Row(
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              child: TextFormField(
                                                controller: _exp_month,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  contentPadding:
                                                      new EdgeInsets.symmetric(
                                                          vertical: 5.0,
                                                          horizontal: 5.0),
                                                  fillColor: Color(0xFFF6F6F6),
                                                  hintText: AppLocalization.of(context).translate('month'),
                                                  hintStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: AqarFont.font_family,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  border: InputBorder.none,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Color(0xFFF6F6F6),
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              child: TextFormField(
                                                controller: _exp_year,
                                                keyboardType:
                                                    TextInputType.number,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  contentPadding:
                                                      new EdgeInsets.symmetric(
                                                          vertical: 5.0,
                                                          horizontal: 5.0),
                                                  fillColor: Color(0xFFF6F6F6),
                                                  hintText: AppLocalization.of(context).translate('year'),
                                                  hintStyle: TextStyle(
                                                      color: Colors.black,
                                                      fontFamily: AqarFont.font_family,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.normal),
                                                  border: InputBorder.none,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    borderSide:
                                                        const BorderSide(
                                                      color: Color(0xFFF6F6F6),
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                          AppLocalization.of(context).translate('cust_name'),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: AqarFont.font_family,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                        ),
                                        child: new Container(
                                          child: TextFormField(
                                            controller: _card_name,
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              filled: true,
                                              contentPadding:
                                                  new EdgeInsets.symmetric(
                                                      vertical: 5.0,
                                                      horizontal: 5.0),
                                              fillColor: Color(0xFFF6F6F6),
                                              hintText:
                                              AppLocalization.of(context).translate('cust_name'),
                                              hintStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: AqarFont.font_family,
                                                  fontSize: 10,
                                                  fontWeight:
                                                      FontWeight.normal),
                                              border: InputBorder.none,
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                borderSide: const BorderSide(
                                                  color: Color(0xFFF6F6F6),
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 15, left: 10, right: 10),
                                  child: new SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    //  height: MediaQuery.of(context).size.width/7,
                                    child: new RaisedButton(
                                      onPressed: () async {
                                        if (_card_name.text.isEmpty ||
                                            _card_number.text.isEmpty ||
                                            _exp_month.text.isEmpty ||
                                            _exp_year.text.isEmpty) {
                                          errorDialog(
                                              context: context,
                                              text:AppLocalization.of(context).translate('card_validator'));
                                        } else {
                                          await ApiProvider.addCreditCard(
                                              sharedPrefs.getString(
                                                  'user_access_token'),
                                              _card_name.text.toString(),
                                              _card_number.text.toString(),
                                              _exp_month.text.toString(),
                                              _exp_year.text.toString(),
                                              sharedPrefs.getInt('user_id'),
                                              context);
                                        }
                                      },

                                      child: new Text(
                                        AppLocalization.of(context).translate('save'),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: AqarFont.font_family,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      //use to make circle border for button
                                      shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(5.0),
                                      ),
                                      color: AppColor.primary_color,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<Widget> update_card(String card_number, String month, String year,
      String card_name, int card_id) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            var height = MediaQuery.of(context).size.height;
            var width = MediaQuery.of(context).size.width;
            return Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: AlertDialog(
                contentPadding: EdgeInsets.all(0.0),
                content: SafeArea(
                  child: SingleChildScrollView(
                    child: Directionality(
                      textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,                      child: new Container(
                          width: width,
                          height: height / 1.7,
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                           AppLocalization.of(context).translate('card_num'),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: AqarFont.font_family,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                        ),
                                        child: new Container(
                                          child: CustomTextField(
                                            initialText: card_number,
                                            inputType: TextInputType.number,
                                            value: (String value) {
                                              setState(() {
                                                card_number = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                          AppLocalization.of(context).translate('expire_date'),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: AqarFont.font_family,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                        ),
                                        child: new Row(
                                          children: <Widget>[
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              child: CustomTextField(
                                                initialText: month,
                                                inputType: TextInputType.number,
                                                value: (String value) {
                                                  setState(() {
                                                    month = value;
                                                  });
                                                },
                                              ),
                                            ),
                                            Spacer(),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  3,
                                              child: CustomTextField(
                                                initialText: year,
                                                inputType: TextInputType.number,
                                                value: (String value) {
                                                  setState(() {
                                                    year = value;
                                                  });
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Text(
                                          AppLocalization.of(context).translate('cust_name'),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: AqarFont.font_family,
                                              fontSize: 16,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          left: 10,
                                          right: 10,
                                        ),
                                        child: new Container(
                                          child: CustomTextField(
                                            initialText: card_name,
                                            inputType: TextInputType.text,
                                            value: (String value) {
                                              setState(() {
                                                card_name = value;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: 15, left: 10, right: 10),
                                  child: new SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    //  height: MediaQuery.of(context).size.width/7,
                                    child: new RaisedButton(
                                      onPressed: () async {
                                        if (card_name.isEmpty ||
                                            card_number.isEmpty ||
                                            month.isEmpty ||
                                            year.isEmpty) {
                                          errorDialog(
                                              context: context,
                                              text:AppLocalization.of(context).translate('card_validator')
                                          );
                                        } else {
                                          await ApiProvider.updateCreditCard(
                                              sharedPrefs.getString(
                                                  'user_access_token'),
                                              card_name,
                                              card_number,
                                              month,
                                              year,
                                              sharedPrefs.getInt('user_id'),
                                              card_id,
                                              context);
                                        }
                                      },

                                      child: new Text(
                                        AppLocalization.of(context).translate('save'),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: AqarFont.font_family,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                      //use to make circle border for button
                                      shape: new RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(5.0),
                                      ),
                                      color: AppColor.primary_color,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
