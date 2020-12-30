import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';
import 'package:intl/intl.dart' as intl;

class Date_Picker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DatePicker_State();
  }
}

class DatePicker_State extends State<Date_Picker> {
  HelperWidgets _helperWidgets = new HelperWidgets();
  var date = '25/7/2020';
  DateTime selectedDate = DateTime.now();
  var date_hint ;

  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: AppColor.primary_color,
              accentColor:  Color(0xFFC5ABAB),
              colorScheme: ColorScheme.light(primary:  AppColor.primary_color),
              buttonTheme: ButtonThemeData(
                  textTheme: ButtonTextTheme.primary
              ),
            ),
            child: child,
          );
        },
        initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),);
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        date = "${selectedDate.toLocal()}".split(' ')[0];
        sharedPrefs.setString('date', date);
        date_hint = intl.DateFormat('EEEE').format(selectedDate);
        ('date_hint : $date');
        ('date_day : $date_hint');
      });
  }

  SharedPreferences sharedPrefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

@override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    date_hint = AppLocalization.of(context).translate('date_hint');
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    //final String formatted = formatter.format(now);
    final String formatted = AppLocalization.of(context).translate('date_hint');
    date = formatted;
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        sharedPrefs = prefs;
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            alignment:AppLocalization.of(context).locale.languageCode=='en'?  Alignment.centerLeft: Alignment.centerRight,

            padding: EdgeInsets.only(right: 10, left: 10, top: 10),
            child: Text(
            AppLocalization.of(context).translate('date'),
              style: TextStyle(
                  fontFamily: AqarFont.font_family,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF262626)),
            ),
          ),
          InkWell(
            child: _helperWidgets.spinner_show_time_and_date(date),
            onTap: () {
              setState(() {
                selectDate(context);
                date = date;
              });
            },
          )
        ],
      ),
    );
  }
}
