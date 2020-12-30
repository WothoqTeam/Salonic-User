import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';

class TimePicker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TimePicker_State();
  }
}

class TimePicker_State extends State<TimePicker> {
  HelperWidgets _helperWidgets = new HelperWidgets();
  bool chosse_time = false;
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay _picked;
  String selected_time;
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
  }

  Future<Null> selectTime(BuildContext context) async {
    DatePicker.showTime12hPicker(context, showTitleActions: true, onChanged: (date) {
      ('change $date in time zone ' + date.timeZoneOffset.inHours.toString());
    }, onConfirm: (date) {
      setState(() {
        selected_time = DateFormat('jm').format(date);
        var time = '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}'; //this formate accepted by database
        chosse_time = true;
        sharedPrefs.setString('time', time);
      });
    }, currentTime: DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: Column(children: <Widget>[
        Container(
          alignment:AppLocalization.of(context).locale.languageCode=='en'?  Alignment.centerLeft: Alignment.centerRight,

          padding: EdgeInsets.only(right: 10, left: 10, top: 10),
          child: Text(
            AppLocalization.of(context).translate('time'),
            style: TextStyle(
                fontFamily: AqarFont.font_family,
                fontWeight: FontWeight.bold,
                color: Color(0xFF262626)),
          ),
        ),
        InkWell(
          child: _helperWidgets.spinner_show_time_and_date(chosse_time
              ? '${selected_time}  '
              : AppLocalization.of(context).translate('time_hint')),
          onTap: () {

            selectTime(context);

          },
        ),
      ]),
    );
  }
}
