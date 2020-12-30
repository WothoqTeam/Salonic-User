import 'package:flutter/material.dart';
import 'package:salonic/Custom_Widgets/custom_textfield.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';

class EditUser extends StatefulWidget {
  final String shared_name, shared_email, shared_mobile, shared_token;
  final int shared_id;
  EditUser(
      {this.shared_id,
      this.shared_name,
      this.shared_email,
      this.shared_mobile,
      this.shared_token});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditUserState();
  }
}

class EditUserState extends State<EditUser> {
  final _formEditUserKey = GlobalKey<FormState>();
  final _formPasswordKey = GlobalKey<FormState>();
  TextStyle style =
      TextStyle(color: Colors.black, fontFamily: AqarFont.font_family, fontSize: 16);
  bool _current_passwordVisible, _new_passwordVisible, _confirm_passwordVisible;
  String password_current, password_new, password_confirm;
  String name, mobile, email, password_confirmation;
  ProgressDialog _progressDialog;
  @override
  void initState() {
    _progressDialog = new ProgressDialog(context);
    _current_passwordVisible = false;
    _new_passwordVisible = false;
    _confirm_passwordVisible = false;
  }

  String emailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'قم بكتابه البريد الالكترونى!';
    } else {
      return null;
    }
  }

  String pwdValidator(String value) {
    if (value.length < 8) {
      errorDialog(
          context: context,
          text: ' الرقم السرى يتكون على الاقل من 8 حروف و ارقام');
      return ' الرقم السرى غير صحيح';
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
        message: AppLocalization.of(context).translate('loading'),
        insetAnimCurve: Curves.easeInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
              AppLocalization.of(context).translate('profile'),
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
        backgroundColor:  AppColor.primary_color,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xFFFFFFFF),
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MorePage()));
          },
        ),
      ),
      body: (widget.shared_token == null)
          ? VistorMessage()
          : SafeArea(
              child: SingleChildScrollView(
                  child: Directionality(
                      textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,                      child: Container(
                        padding: EdgeInsets.only(top: 10),
                        child: Form(
                            key: _formEditUserKey,
                            child: new Container(
                              padding:
                                  EdgeInsets.only(right: 10, left: 5, top: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                        child: CustomTextField(
                                          initialText: widget.shared_name,
                                          inputType: TextInputType.emailAddress,
                                          value: (String value) {
                                            setState(() {
                                              name = value;
                                            });
                                          },

                                          // ignore: missing_return
                                          validate: (String value) {
                                            if (value.length < 3) {
                                              return AppLocalization.of(context).translate('username_validaor');
                                              ;
                                            }
                                          },
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
                                                        '   966+',
                                                        style: style,
                                                      )
                                                    ],
                                                  )),
                                              Expanded(
                                                flex: 2,
                                                child: CustomTextField(
                                                  initialText:
                                                      widget.shared_mobile,
                                                  inputType:
                                                      TextInputType.phone,
                                                  validate: (String value) {
                                                    if (value.length < 10) {
                                                      return  AppLocalization.of(context).translate('phone_validaor');
                                                    }
                                                  },
                                                  value: (String value) {
                                                    setState(() {
                                                      mobile = value;
                                                    });
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
                                          child: CustomTextField(
                                            initialText: widget.shared_email,
                                            inputType:
                                                TextInputType.emailAddress,
                                            validate: emailValidator,
                                            value: (String value) {
                                              setState(() {
                                                email = value;
                                              });
                                            },
                                          )),
                                    ],
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    child: FlatButton(
                                      color: Color(0xFFF6F6F6),
                                      shape: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                        borderSide: BorderSide.none,
                                      ),
                                      child: Text(
                                      AppLocalization.of(context).translate('edit_pass'),
                                        style: style,
                                      ),
                                      onPressed: () {
                                        edit_password();
                                      },
                                    ),
                                  ),

                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: 10,
                                        left: 10,
                                        right: 10,
                                        bottom: 5),
                                    child: Builder(
                                      builder: (ctx) => new Container(
                                          padding: EdgeInsets.only(top: 15.0),
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
                                                    BorderRadius.circular(5.0),
                                                side: BorderSide(
                                                  color: AppColor.primary_color,
                                                  width: 1.0,
                                                ),
                                              ),
                                              color: AppColor.primary_color,
                                              child: Text(
                                                AppLocalization.of(context).translate('save'),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              onPressed: () async {
                                                if (_formEditUserKey
                                                    .currentState
                                                    .validate()) {
                                                  (
                                                      'shared_id : ${widget.shared_id}');
                                                  (
                                                      'shared_token : ${widget.shared_token}');
                                                  ('name : ${name}');
                                                  ('mobile : ${mobile}');
                                                  ('email : ${email}');
                                                  (
                                                      'password_new : ${password_new}');
                                                  (
                                                      'password_confirmation : ${password_confirmation}');

                                                  updateProfile(
                                                      widget.shared_id,
                                                      name,
                                                      mobile,
                                                      email,
                                                      password_new,
                                                      password_confirmation,
                                                      widget.shared_token);
                                                }
                                              },
                                            ),
                                          )),
                                    ),
                                  )
                                ],
                              ),
                            )),
                      )))),
    );
  }

  Future<Widget> edit_password() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        // Get available height and width of the build area of this widget. Make a choice depending on the size.
        var height = MediaQuery.of(context).size.height;
        var width = MediaQuery.of(context).size.width;
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: AlertDialog(
                contentPadding: EdgeInsets.all(0.0),
                content: Directionality(
                  textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,                  child: new Container(
                    padding: EdgeInsets.all(10),
                    width: width,
                    child: SafeArea(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            InkWell(
                              child: Container(
                                alignment: Alignment.topLeft,
                                child: Icon(
                                  Icons.close,
                                  size: 25,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            Form(
                                key: _formPasswordKey,
                                child: Column(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 10, right: 10),
                                          child: Text(
                                            AppLocalization.of(context).translate('new_password'),
                                            style: style,
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                              top: 5,
                                              left: 10,
                                              right: 10,
                                            ),
                                            child: CustomTextField(
                                              hint: '********',
                                              secureText: !_new_passwordVisible,
                                              inputType:
                                                  TextInputType.visiblePassword,
                                              validate: pwdValidator,
                                              value: (String value) {
                                                setState(() {
                                                  password_new = value;
                                                });
                                              },
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                    // Based on passwordVisible state choose the icon
                                                    _new_passwordVisible
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                    color: Colors.black),
                                                onPressed: () {
                                                  // Update the state i.e. toogle the state of passwordVisible variable
                                                  setState(() {
                                                    _new_passwordVisible =
                                                        !_new_passwordVisible;
                                                  });
                                                },
                                              ),
                                            )),
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
                                            AppLocalization.of(context).translate('confirm_password'),
                                            style: style,
                                          ),
                                        ),
                                        Padding(
                                            padding: EdgeInsets.only(
                                              top: 5,
                                              left: 10,
                                              right: 10,
                                            ),
                                            child: CustomTextField(
                                              hint: '********',
                                              secureText:
                                                  !_confirm_passwordVisible,
                                              inputType:
                                                  TextInputType.visiblePassword,
                                              validate: pwdValidator,
                                              value: (String value) {
                                                setState(() {
                                                  password_confirm = value;
                                                });
                                              },
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                    // Based on passwordVisible state choose the icon
                                                    _confirm_passwordVisible
                                                        ? Icons.visibility
                                                        : Icons.visibility_off,
                                                    color: Colors.black),
                                                onPressed: () {
                                                  // Update the state i.e. toogle the state of passwordVisible variable
                                                  setState(() {
                                                    _confirm_passwordVisible =
                                                        !_confirm_passwordVisible;
                                                  });
                                                },
                                              ),
                                            )),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 10,
                                          left: 10,
                                          right: 10,
                                          bottom: 5),
                                      child: Builder(
                                        builder: (ctx) => new Container(
                                            padding: EdgeInsets.only(top: 15.0),
                                            alignment: Alignment.center,
                                            child: ButtonTheme(
                                              minWidth: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              child: RaisedButton(
                                                padding:
                                                    const EdgeInsets.all(3.0),
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
                                                  AppLocalization.of(context).translate('save'),
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                onPressed: () {
                                                  if (_formPasswordKey
                                                      .currentState
                                                      .validate()) {
                                                    (
                                                        'newPassword  :${password_new}');
                                                    (
                                                        'confirm_password  :${password_confirm}');
                                                    if (password_new ==
                                                        password_confirm) {
                                                      password_confirmation =
                                                          password_confirm;
                                                      Navigator.pop(context);
                                                    } else {
                                                      (
                                                          'error passwords not identical');
                                                    }
                                                  }
                                                },
                                              ),
                                            )),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
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

  updateProfile(
      int id,
      String name,
      String mobile,
      String email,
      String update_password,
      String update_password_confirmation,
      String token) async {
    ('profile function');
    ('shared_id : ${id}');
    ('shared_token : ${token}');
    ('name : ${name}');
    ('mobile : ${mobile}');
    ('email : ${email}');
    ('password_new : ${update_password}');
    ('password_confirmation : ${update_password_confirmation}');
    ('profile 1');
    await _progressDialog.show();
    String updateProfile_Url = 'https://salonic.wothoq.co/api/users/update';
    Dio dio = new Dio();
    ('profile 2');
    try {
      FormData _formData = FormData.fromMap({
        'id': '${id}',
        'update_name': '${name}',
        'update_email': '${email}',
        'update_mobile': '${mobile}',
        'update_password': '${update_password}',
        'token': '${token}',
        'update_password_confirmation': '${update_password_confirmation}'
      });
      ('profile 3');
      final response = await dio.post(updateProfile_Url, data: _formData);
      ('profile 4');
      ('response : ${response.data['status']}');
      ('response : ${response}');
      _progressDialog.hide();
      if (response.data['status'] == true) {
        ('profile 5');
        errorDialog(context: context, text: response.data['msg']);

      } else {
        ('profile 6');
        _progressDialog.hide();
       }
    } catch (e) {
      ('profile 7');
      _progressDialog.hide();
      ('SignUp Exception : ${e}');
    }
  }
}
