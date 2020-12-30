import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';
import 'package:salonic/Presenter/api_provider.dart';

import '../Profile/edit_user_profile.dart';

class UserSignUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UserSignUp_State();
  }
}

class UserSignUp_State extends State<UserSignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailAddress = new TextEditingController();
  TextEditingController _PhoneNumber = new TextEditingController();
  TextEditingController _username = new TextEditingController();
  TextEditingController _password = new TextEditingController();
  bool _passwordVisible;
  bool checkedValue;
  String name, email, mobile, password, reCAPTCHA;

  ProgressDialog _progressDialog;
  String deviceToken;
  SharedPreferences sharedPrefs;
  @override
  void initState() {
    _passwordVisible = false;
    checkedValue = false;
    _progressDialog = new ProgressDialog(context);
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        sharedPrefs = prefs;
      });
    });
  }

  TextStyle style = TextStyle(
      color: Color(0xFF262626),
      fontFamily: AqarFont.font_family,
      fontSize: 16,
      fontWeight: FontWeight.bold);

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return AppLocalization.of(context).translate('email_validator');
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      return AppLocalization.of(context).translate('password_validator');
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    _progressDialog.style(
        message: AppLocalization.of(context).translate('loading'),
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));

    // TODO: implement build
    return Material(
        child: Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 3,
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
                  textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,                  child: page_header(),
                ),
              ],
            )
          ],
        ),
        Container(
          height: MediaQuery.of(context).size.height * 2 / 3,
          child: SafeArea(
              child: SingleChildScrollView(
                  child: Directionality(
                      textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,                      child: Column(
                        children: <Widget>[
                          Container(
                            //    padding: EdgeInsets.only(top: MediaQuery.of(context).size.width/4),
                            child: Form(
                                key: _formKey,
                                child: new Container(
                                  padding: EdgeInsets.only(
                                      right: 10, left: 5, top: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Text(
                                              AppLocalization.of(context).translate('usename'),
                                              style: style,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10, top: 5),
                                            child: new Container(
                                              child: TextFormField(
                                                controller: _username,
                                                keyboardType:
                                                    TextInputType.text,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Color(0xFFF6F6F6),
                                                  border: InputBorder.none,
                                                  hintText:
                                                  AppLocalization.of(context).translate('usename'),
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
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return AppLocalization.of(context).translate('username_validaor');
                                                  } else if (value.length < 3) {
                                                    return   AppLocalization.of(context).translate('username_validaor');
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Text(
                                              AppLocalization.of(context).translate('phone'),
                                              style: style,
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: 10,
                                                left: 10,
                                                right: 10,
                                                bottom: 10),
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                border: Border.all(
                                                  color: Color(0xFFF6F6F6),
                                                  width: 1.0,
                                                ),
                                                color: Color(0xFFF6F6F6),
                                              ),
                                              child: new Row(
                                                children: <Widget>[
                                                  Expanded(
                                                      flex: 1,
                                                      child: Row(
                                                        children: <Widget>[
                                                          Image(
                                                            image: AssetImage(
                                                                'images/user_sign/flag.png'),
                                                          ),
                                                          Text(
                                                            '   +966',
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  AqarFont.font_family,
                                                            ),
                                                          )
                                                        ],
                                                      )),
                                                  Expanded(
                                                    flex: 2,
                                                    child: TextFormField(
                                                      controller: _PhoneNumber,
                                                      keyboardType:
                                                          TextInputType.phone,
                                                      decoration:
                                                          InputDecoration(
                                                        filled: true,
                                                        fillColor:
                                                            Color(0xFFF6F6F6),
                                                        hintText: 'xxxxxxxxx',
                                                        border:
                                                            InputBorder.none,
                                                      ),
                                                      validator: (value) {
                                                        if (value.isEmpty) {
                                                          return AppLocalization.of(context).translate('phone_validaor');
                                                        } else if (value
                                                                .length <
                                                            10) {
                                                          return  AppLocalization.of(context).translate('phone_validaor');
                                                        }
                                                        return null;
                                                      },
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
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
                                              style: style,
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
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                decoration: InputDecoration(
                                                  filled: true,
                                                  fillColor: Color(0xFFF6F6F6),
                                                  border: InputBorder.none,
                                                  hintText: 'Example@gmail.com',
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
                                                validator: emailValidator,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10, right: 10),
                                            child: Text(
                                              AppLocalization.of(context).translate('password'),
                                              style: style,
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
                                                keyboardType:
                                                    TextInputType.text,
                                                controller: _password,
                                                obscureText: !_passwordVisible,
                                                validator:
                                                    pwdValidator, //This will obscure text dynamically
                                                decoration: InputDecoration(
                                                  border: InputBorder.none,
                                                  filled: true,
                                                  fillColor: Color(0xFFF6F6F6),
                                                  hintText: '********',
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
                                                  // Here is key idea
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 10,
                                            left: 10,
                                            right: 10,
                                            bottom: 10),
                                        child: new Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xFFF6F6F6),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Row(
                                              children: <Widget>[
                                                SizedBox(
                                                  child: CheckboxListTile(
                                                    title:
                                                        Text( AppLocalization.of(context).translate('robot'),),
                                                    value: checkedValue,
                                                    onChanged: (newValue) {
                                                      setState(() {
                                                        checkedValue = newValue;
                                                        if (checkedValue) {
                                                          reCAPTCHA = 'on';
                                                        } else {
                                                          reCAPTCHA = 'off';
                                                        }
                                                      });
                                                    },
                                                    checkColor: Colors.white,
                                                    controlAffinity:
                                                        ListTileControlAffinity
                                                            .leading, //  <-- leading Checkbox
                                                  ),
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      1.5,
                                                ),
                                                Spacer(),
                                                Image(
                                                  image: AssetImage(
                                                      'images/user_sign/reeeeee.png'),
                                                )
                                              ],
                                            )),
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
                                              padding: EdgeInsets.only(
                                                  top: 15.0, bottom: 10),
                                              alignment: Alignment.center,
                                              child: ButtonTheme(
                                                minWidth: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2,
                                                child: RaisedButton(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                    side: BorderSide(
                                                      color: AppColor.primary_color,
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  color: AppColor.primary_color,
                                                  child: Text(
    AppLocalization.of(context).translate('register'),
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  onPressed: () {
                                                    deviceToken = sharedPrefs
                                                        .getString('msgToken');
                                                    (
                                                        'devicetoken : ${deviceToken}');
                                                    if (_formKey.currentState
                                                        .validate()) {
                                                      signUp(
                                                          _username.text.trim(),
                                                          _emailAddress.text
                                                              .trim(),
                                                          _PhoneNumber.text
                                                              .trim(),
                                                          _password.text.trim(),
                                                          reCAPTCHA,
                                                          deviceToken,
                                                          context);
                                                    }
                                                  },
                                                ),
                                              )),
                                        ),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.width / 3,
                          ),
                        ],
                      )))),
        )
      ],
    ));
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
                  child:Center(
                    child:  Text(
                      AppLocalization.of(context).translate('login_header_1'),
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
          Container(
            alignment: Alignment.center,
            child: Text(
              AppLocalization.of(context).translate('start_register'),
              style: TextStyle(
                  color: Colors.white, fontFamily: AqarFont.font_family, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  signUp(String name, String email, String mobile, String password,
      String reCAPTCHA, String deviceToken, BuildContext context) async {
    ('1');
    await _progressDialog.show();
    String signUp_Url = ApiProvider.APP_URL + 'users/store';
    Dio dio = new Dio();
    ('2');
    try {
      ('1');
      FormData _formData = FormData.fromMap({
        'name': '${name}',
        'email': '${email}',
        'mobile': '${mobile}',
        'password': '${password}',
        'reCAPTCHA': '${reCAPTCHA}',
        'deviceToken': '${deviceToken}',
      });
      ('3');
      final response = await dio.post(signUp_Url, data: _formData);
      ('response : ${response.data['status']}');
      ('response : ${response}');
      _progressDialog.hide();
      if (response.data['status'] == true) {
        errorDialog(
            context: context,
            text: AppLocalization.of(context).translate('sucess_register'),
            function: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => UserSignIn()));
            });
        ('4');
      } else {
        _progressDialog.hide();
        errorDialog(context: context, text: response.data['msg']);
        ('5');
      }
    } catch (e) {
      _progressDialog.hide();
      ('SignUp Exception : ${e}');
      ('6');
    }
  }
}
