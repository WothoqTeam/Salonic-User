import 'package:flutter/material.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';
class ResetPassword3 extends StatefulWidget {
  final String email;
  ResetPassword3({this.email});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ResetPassword3State();
  }
}

class ResetPassword3State extends State<ResetPassword3> {
  final _formSiginKey = GlobalKey<FormState>();
  TextEditingController _confirm_password;
  TextEditingController _password;
  bool _passwordVisible;
  bool _confirmpasswordVisible;
  ProgressDialog _progressDialog;
  TextStyle style =
  TextStyle(color: Colors.black, fontFamily: AqarFont.font_family, fontSize: 16);
  bool valid_code =false;
  String error_message='';


  @override
  void initState() {
    _passwordVisible = false;
    _confirmpasswordVisible = false;
    _confirm_password =new TextEditingController();
    _password = new TextEditingController();
    _progressDialog = new ProgressDialog(context);
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
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600)
    );
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
              width: MediaQuery.of(context).size.width ,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: <Widget>[
              Directionality(
                textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,                child: page_header(),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.2,
                child: SafeArea(
                    child: SingleChildScrollView(
                        child: Directionality(
                            textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,
                            child: Container(
                              padding: EdgeInsets.only(top:  MediaQuery.of(context).size.width/4),
                              child: Form(
                                  key: _formSiginKey,
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
                                                  top: 30,
                                                  left: 10,
                                                  right: 10,
                                                  bottom: 10),
                                              child: Text(
                                              AppLocalization.of(context).translate('password_hint'),
                                                style: TextStyle(fontFamily: AqarFont.font_family,fontWeight: FontWeight.normal,fontSize: 18,color: Color(0xFF535353)),)
                                            ),
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
                                                    obscureText:
                                                    !_passwordVisible, //This will obscure text dynamically
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Color(0xFFF6F6F6 ),
                                                      hintText:
                                                      '*********',
                                                      border: InputBorder.none,
                                                      enabledBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                        borderSide:
                                                        const BorderSide(
                                                          color:Color(0xFFF6F6F6 ),
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      // Here is key idea
                                                      suffixIcon: IconButton(
                                                        icon: Icon(
                                                          // Based on passwordVisible state choose the icon
                                                          _passwordVisible
                                                              ? Icons.visibility
                                                              : Icons
                                                              .visibility_off,
                                                          color: Colors.black
                                                        ),
                                                        onPressed: () {
                                                          // Update the state i.e. toogle the state of passwordVisible variable
                                                          setState(() {
                                                            _passwordVisible =
                                                            !_passwordVisible;
                                                          });
                                                        },
                                                      ),
                                                    ),
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
                                                AppLocalization.of(context).translate('reset_password'),
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
                                                    controller: _confirm_password,
                                                    obscureText:
                                                    !_confirmpasswordVisible, //This will obscure text dynamically
                                                    decoration: InputDecoration(
                                                      filled: true,
                                                      fillColor: Color(0xFFF6F6F6 ),
                                                      hintText:
                                                      '*********',
                                                      border: InputBorder.none,
                                                      enabledBorder:
                                                      OutlineInputBorder(
                                                        borderRadius:
                                                        BorderRadius.circular(
                                                            5.0),
                                                        borderSide:
                                                        const BorderSide(
                                                          color: Color(0xFFF6F6F6 ),
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      // Here is key idea
                                                      suffixIcon: IconButton(
                                                        icon: Icon(
                                                          // Based on passwordVisible state choose the icon
                                                            _confirmpasswordVisible
                                                              ? Icons.visibility
                                                              : Icons
                                                              .visibility_off,
                                                          color: Colors.black
                                                        ),
                                                        onPressed: () {
                                                          // Update the state i.e. toogle the state of passwordVisible variable
                                                          setState(() {
                                                            _confirmpasswordVisible =
                                                            !_confirmpasswordVisible;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        valid_code?Padding(
                                          padding: EdgeInsets.only(
                                              top: 5,
                                              left: 10,
                                              right: 10,
                                              bottom: 10),
                                          child: Text(
                                            '${error_message}',
                                            style: TextStyle(color: Colors.red,fontWeight: FontWeight.normal,fontFamily: AqarFont.font_family,fontSize: 14),
                                          ),
                                        ):Container(),
                                        // use Builder to solve Scaffold.of() called with a context that does not contain a Scaffold Exception
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 5,
                                              left: 10,
                                              right: 10,
                                              bottom: 5),
                                          child: Builder(
                                            builder: (ctx) => new Container(
                                                padding:
                                                EdgeInsets.only(top: 15.0),
                                                alignment: Alignment.center,
                                                child: ButtonTheme(
                                                  minWidth:
                                                  MediaQuery.of(context)
                                                      .size
                                                      .width/2,
                                                  child: RaisedButton(
                                                    padding:
                                                    const EdgeInsets.all(
                                                        5.0),
                                                    shape:
                                                    RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                      side: BorderSide(
                                                        color:  AppColor.primary_color,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    color: AppColor.primary_color,
                                                    child: Text(
                                                      AppLocalization.of(context).translate('change_password'),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    ),
                                                    onPressed: () {
                                                      if (_formSiginKey.currentState.validate()) {
                                                        setState(() {
                                                          valid_code=false;
                                                        });
                                                          resetPassword(widget.email,_password.text.trim(),
                                                              _confirm_password.text.trim() );

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


  resetPassword(String email, String password, String password_confirmation)async{

    _progressDialog.show();
    String ResetPassword_Url=ApiProvider.APP_URL + 'users/resetPassword';
    Dio dio =new Dio();
    try{
      FormData _formData =FormData.fromMap({
        'email':'${email}',
        'password':'${password}',
        'password_confirmation':'${password_confirmation}',
      });
      final response = await dio.post(ResetPassword_Url, data: _formData);
      ('response : ${response}');
      if(response.data['status']){
        _progressDialog.hide();
        setState(() {
          valid_code=false;

        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => UserSignIn()));
      }else{
        _progressDialog.hide();
        setState(() {
          valid_code=true;
          error_message = response.data['msg'];
        });

      }
    }catch(e){
      _progressDialog.hide();
      errorDialog(context: context,text: e);
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
                      AppLocalization.of(context).translate('reset_password'),
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
                              builder: (context) => ResetPassword2()));
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
