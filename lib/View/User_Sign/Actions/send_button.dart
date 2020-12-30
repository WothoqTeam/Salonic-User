import 'package:flutter/material.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';

class SendButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String email;
  SendButton({this.formKey, this.email});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return SendButtonState();
  }
}

class SendButtonState extends State<SendButton> {
  ProgressDialog _progressDialog;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _progressDialog = new ProgressDialog(context);
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
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
      child: Builder(
        builder: (ctx) => new Container(
            padding: EdgeInsets.only(top: 10.0),
            alignment: Alignment.center,
            child: ButtonTheme(
              minWidth: MediaQuery.of(context).size.width / 2,
              child: RaisedButton(
                padding: const EdgeInsets.all(3.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(
                    color: AppColor.primary_color,
                    width: 1.0,
                  ),
                ),
                color: AppColor.primary_color,
                child: Text(
                  'ارسال',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  if (widget.formKey.currentState.validate()) {
                    sendOtpToEmail(widget.email);
                  }
                },
              ),
            )),
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
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => ResetPassword2(
                      email: email,
                    )));
      } else {
        errorDialog(context: context, text: response.data['success']);
      }
    } catch (e) {
      _progressDialog.hide();
      errorDialog(context: context, text: e.toString());
    }
  }
}
