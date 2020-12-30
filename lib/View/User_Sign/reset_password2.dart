import 'package:flutter/material.dart';

import 'package:salonic/Custom_Widgets/export_file.dart';
class ResetPassword2 extends StatefulWidget {
  final String email;
  ResetPassword2({this.email});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ResetPassword2State();
  }
}

class ResetPassword2State extends State<ResetPassword2> {
  final _formResetPwKey = GlobalKey<FormState>();
  TextEditingController otp_controller;
  ProgressDialog _progressDialog;
  TextStyle style =
  TextStyle(color: Colors.black, fontFamily: AqarFont.font_family, fontSize: 16);
  bool valid_code =false;
  String otp;
  int pinLength = 4;
  bool hasError = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _progressDialog =new ProgressDialog(context);
    otp_controller=new TextEditingController();

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
              fit: BoxFit.none,
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
                            textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,                            child: Container(
                              padding: EdgeInsets.only(top: MediaQuery.of(context).size.width/3),
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
                                              right: 20,
                                              bottom: 5),
                                          child: Text(
                                            AppLocalization.of(context).translate('code_hint'),
                                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.normal,fontFamily: AqarFont.font_family,fontSize: 18),
                                          ),
                                        ),

                                        Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.all(10),
                                          child:PinCodeTextField(
                                          autofocus: true,
                                          controller: otp_controller,
                                          hideCharacter: false,
                                          highlight: true,
                                          highlightColor: Colors.blue,
                                          defaultBorderColor: Color(0xFFC4BEBE ),
                                          hasTextBorderColor: AppColor.primary_color,
                                          maxLength: pinLength,
                                          hasError: hasError,
                                        //  maskCharacter: "😎",
                                          onTextChanged: (text) {
                                            setState(() {
                                              hasError = false;
                                            });
                                          },
                                          onDone: (text) {
                                            otp=text;
                                            ("DONE $text");
                                            ("DONE CONTROLLER ${otp_controller.text}");
                                          },
                                          pinBoxWidth: 50,
                                          pinBoxHeight: 50,
                                          hasUnderline: false,
                                          wrapAlignment: WrapAlignment.spaceAround,
                                          pinBoxDecoration:
                                          ProvidedPinBoxDecoration.defaultPinBoxDecoration,
                                          pinTextStyle: TextStyle(fontSize: 22.0),
                                          pinTextAnimatedSwitcherTransition:
                                          ProvidedPinBoxTextAnimation.scalingTransition,
                                            //                    pinBoxColor: Colors.green[100],
                                          pinTextAnimatedSwitcherDuration:
                                          Duration(milliseconds: 300),
                                            //                    highlightAnimation: true,
                                          highlightAnimationBeginColor: Colors.black,
                                          highlightAnimationEndColor: Colors.white12,
                                          keyboardType: TextInputType.number,
                                        ),
    ),
                                        valid_code?Padding(
                                          padding: EdgeInsets.only(
                                              top: 5,
                                              left: 10,
                                              right: 10,
                                              bottom: 5),
                                          child: Text(
                                            AppLocalization.of(context).translate('fault_code'),
                                            style: TextStyle(color: Colors.red,fontWeight: FontWeight.normal,fontFamily: AqarFont.font_family,fontSize: 14),
                                          ),
                                        ):Container(),

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
                                                        color:AppColor.primary_color,
                                                        width: 1.0,
                                                      ),
                                                    ),
                                                    color: AppColor.primary_color,
                                                    child: Text(
                                                      AppLocalization.of(context).translate('next_btn'),
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18.0,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    ),
                                                    onPressed: () {
                                                      String otp_text = otp;
                                                      String email= widget.email;
                                                        setState(() {
                                                          checkOtp(email, otp);

                                                        });
                                                    },
                                                  ),
                                                )),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 10,
                                              left: 20,
                                              right: 20,
                                              bottom: 5),
                                          child: Center(
                                            child: InkWell(
                                              child: Text(
                                                AppLocalization.of(context).translate('resend_code'),
                                                style: style,
                                              ),
                                              onTap: () {
                                                reSendOtpToEmail(widget.email);
                                              },
                                            ),
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
                              builder: (context) => ResetPassword()));
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

  checkOtp(String email,String otp) async{
    _progressDialog.show();
    String CheckOtp_Url = ApiProvider.APP_URL + 'users/checkOtp';
    Dio dio =new Dio();
    try{
      FormData _formData =FormData.fromMap({
        'email':'${email}',
        'otp':'${otp}',
      });
      final response = await dio.post(CheckOtp_Url,data: _formData);
      if(response.data['status']){
        setState(() {
          valid_code=false;
          _progressDialog.hide();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ResetPassword3(email: email,)));
        });

      }else{
        setState(() {
          _progressDialog.hide();
          valid_code=true;

        });
      }

    }catch(e){
      errorDialog(context: context,text: e.toString());
    }

  }

  reSendOtpToEmail(String email)async{
    _progressDialog.show();
    String sendOtp_Url =ApiProvider.APP_URL + "users/resend";
    Dio dio=new Dio();
    try{
      FormData _formData=FormData.fromMap({
        'email':'${email}',
      });
      final response = await dio.post(sendOtp_Url,data: _formData);
      (response);
      if(response.data['success']=='success'){
        _progressDialog.hide();
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ResetPassword2(email: email,)));

      }else{
        errorDialog(context: context, text:  response.data['success']);
      }
    }
    catch(e){
      _progressDialog.hide();
      errorDialog(context: context, text: e.toString() );
    }


  }
}
