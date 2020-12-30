import 'package:flutter/material.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';

class ResetPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ResetPasswordState();
  }
}

class ResetPasswordState extends State<ResetPassword> {
  final _formResetPwKey = GlobalKey<FormState>();
  TextEditingController _emailAddress = new TextEditingController();
  TextStyle style =
      TextStyle(color: Colors.black, fontFamily: AqarFont.font_family, fontSize: 16);
  ProgressDialog _progressDialog;
  bool valid_code;
  @override
  void initState() {
    _progressDialog = ProgressDialog(context);
    valid_code=false;
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return AppLocalization.of(context).translate('reset_email_validator');
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    _progressDialog.style(
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.bounceInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    // TODO: implement build
    return Material(
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Image(
              image: AssetImage('images/background/backgroundassets.png'),
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: <Widget>[
              Directionality(
                textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,
                child: page_header(),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.2,
                child: SafeArea(
                    child: SingleChildScrollView(
                        child: Directionality(
                            textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,
                            child: Container(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.width / 3),
                              child: Form(
                                  key: _formResetPwKey,
                                  child: new Container(
                                    padding: EdgeInsets.only(
                                        right: 10, left: 5, top: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10,
                                              left: 10,
                                              right: 10,
                                              bottom: 20),
                                          child: Text(
                                           AppLocalization.of(context).translate('edit_password'),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: AqarFont.font_family,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: Text(
                                               AppLocalization.of(context).translate('email'),
                                                style: TextStyle(
                                                    fontFamily: AqarFont.font_family,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: 10,
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 10),
                                              child: new Container(
                                                child: TextFormField(
                                                  controller: _emailAddress,
                                                  keyboardType: TextInputType
                                                      .emailAddress,
                                                  decoration: InputDecoration(
                                                    filled: true,
                                                    fillColor:
                                                        Color(0xFFF6F6F6),
                                                    hintText:
                                                        'Example@example.com',
                                                    border: InputBorder.none,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      borderSide:
                                                          const BorderSide(
                                                        color:
                                                            Color(0xFFF6F6F6),
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                  ),
                                                  validator: emailValidator,
                                                ),
                                              ),
                                            ),
                                            valid_code?Padding(
                                              padding: EdgeInsets.only(
                                                  top: 5,
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 5),
                                              child: Text(
                                                AppLocalization.of(context).translate('reset_email_validator'),
                                                style: TextStyle(color: Colors.red,fontWeight: FontWeight.normal,fontFamily: AqarFont.font_family,fontSize: 14),
                                              ),
                                            ):Container(),
                                          ],
                                        ),
                                        // use Builder to solve Scaffold.of() called with a context that does not contain a Scaffold Exception

                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10,
                                              left: 10,
                                              right: 10,
                                              bottom: 5),
                                          child: Builder(
                                            builder: (ctx) => new Container(
                                                padding:
                                                    EdgeInsets.only(top: 10.0),
                                                alignment: Alignment.center,
                                                child: ButtonTheme(
                                                  minWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2,
                                                  child: RaisedButton(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      side: BorderSide(
                                                        color:AppColor.primary_color,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    color: AppColor.primary_color,
                                                    child: Text(
                                                      AppLocalization.of(context).translate('send_to_email'),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                    onPressed: () {
                                                      if (_formResetPwKey
                                                          .currentState
                                                          .validate()) {
                                                        sendOtpToEmail(
                                                            _emailAddress.text
                                                                .trim());
                                                      }
                                                    },
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )),
                            )))),
              )
            ],
          )
        ],
      ),
    );
  }


  sendOtpToEmail(String email) async {
    _progressDialog.show();
    String sendOtp_Url = ApiProvider.APP_URL + "users/sendNotification";
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'email': '${email}',
      });
      final response = await dio.post(sendOtp_Url, data: _formData);
      (response);
      if (response.data['success'] == 'success') {
        _progressDialog.hide();
        setState(() {
          valid_code=false;
        });
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ResetPassword2(
                      email: email,
                    )));
      } else {
        _progressDialog.hide();
        setState(() {
          valid_code=true;
        });
      }
    } catch (e) {
      _progressDialog.hide();
      errorDialog(context: context, text: e.toString());
    }
  }



  Widget page_header() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 20),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(),
                ),
                Expanded(
                  flex: 5,
                  child: Center(
                    child: Text(
                      AppLocalization.of(context).translate('send_password'),
                      style: TextStyle(
                          color: Colors.white, fontFamily: AqarFont.font_family, fontSize: 20),
                    ),
                  )
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    alignment: Alignment.centerLeft,
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      size: 25,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserSignIn()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
