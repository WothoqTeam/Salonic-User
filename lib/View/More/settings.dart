import 'package:flutter/material.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';
import 'package:salonic/Model/language_model.dart';
import 'package:salonic/main.dart';

class Settings extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return Settings_State();
  }
}

class Settings_State extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          AppLocalization.of(context).translate('settings'),
          style: TextStyle(fontFamily: AqarFont.font_family),
        ),
        backgroundColor: AppColor.primary_color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(10),
          ),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 15),
          child: Directionality(
              textDirection:
                  AppLocalization.of(context).locale.languageCode == 'en'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
              child: Container(
                child: DropdownButton(
                  underline: SizedBox(),
                  icon: Row(
                    children: [
                      Text(
                        AppLocalization.of(context).translate('language'),
                        style: TextStyle(
                            fontFamily: AqarFont.font_family,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Card(
                          color: Color(0xFFF6F6F6),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.language,
                              color: AppColor.secondary_color,
                            ),
                          )),
                    ],
                  ),
                  isExpanded: false,
                  items: LanguageModel.language_list()
                      .map<DropdownMenuItem<LanguageModel>>((lang) =>
                          DropdownMenuItem(
                            value: lang,
                            child: Container(
                              width: AppLocalization.of(context)
                                          .locale
                                          .languageCode ==
                                      'en'
                                  ? MediaQuery.of(context).size.width / 3
                                  : MediaQuery.of(context).size.width / 1.9,
                              child: Row(
                                children: [Text(lang.flag), Text(lang.name)],
                              ),
                            ),
                          ))
                      .toList(),
                  onChanged: (LanguageModel lang) {
                    _changeLanguage(lang);
                  },
                ),
              ))),
    );
  }

  void _changeLanguage(LanguageModel lang) {
    print('language : ${lang.language_code}');
    Locale _temp;
    switch (lang.language_code) {
      case 'en':
        _temp = Locale(lang.language_code, 'US');
        break;
      case 'ar':
        _temp = Locale(lang.language_code, 'EG');
        break;
      default:
        _temp = Locale(lang.language_code, 'EG');
        break;
    }
    MyApp.setLocale(context, _temp);
  }
}
