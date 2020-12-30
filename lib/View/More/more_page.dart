import 'package:flutter/material.dart';
import 'package:salonic/Custom_Widgets/Localization/app_localization.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';
import 'package:salonic/Model/language_model.dart';
import 'package:salonic/View/More/invoices.dart';
import 'package:salonic/View/More/mycards.dart';
import 'package:salonic/View/More/settings.dart';
import 'package:salonic/main.dart';

import 'contact_us.dart';
import 'customer_service_complain.dart';
import 'customer_services.dart';

class MorePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MorePageState();
  }
}

class MorePageState extends State<MorePage> {
  int _currentIndex;
  static var style = TextStyle(fontFamily: AqarFont.font_family);
  SharedPreferences sharedPrefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _currentIndex = 0;
    SharedPreferences.getInstance().then((prefs) {
      sharedPrefs = prefs;
    });
  }


  @override
  Widget build(BuildContext context) {
    List data = [
      [AppLocalization.of(context).translate('advance_search'), 'images/more/search_icon.png'],
      [AppLocalization.of(context).translate('profile'), 'images/more/user.png'],
      [AppLocalization.of(context).translate('reservation'), 'images/more/calendar.png'],
      [AppLocalization.of(context).translate('favorite'), 'images/favourite/favourite.png'],
      [AppLocalization.of(context).translate('bills'), 'images/more/invoices.png'],
      [AppLocalization.of(context).translate('cards'),'images/more/credit-card.png'],
      [AppLocalization.of(context).translate('contact_us'), 'images/more/telephone.png'],
      [AppLocalization.of(context).translate('customer_care'), 'images/more/sport-team.png'],
      [AppLocalization.of(context).translate('settings'), ''],
      [AppLocalization.of(context).translate('exit'), 'images/more/logout.png'],

    ];
    // TODO: implement build
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            automaticallyImplyLeading: false,
            title: Text(
              AppLocalization.of(context).translate('more_bar'),
              style: TextStyle(fontFamily: AqarFont.font_family),
            ),
            backgroundColor: AppColor.primary_color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigation(
            index: _currentIndex,
          ),
          body: Directionality(
            textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,
            child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: EdgeInsets.only(right: 10, top: 10,left: 10),
                      child: InkWell(
                        child: Row(
                          children: <Widget>[
                            Card(
                              color: Color(0xFFF6F6F6),
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Center(
                                  child: index==8? Icon(Icons.settings,color: Colors.grey,) :Image(
                                    width:
                                    MediaQuery.of(context).size.width / 14,
                                    height:
                                    MediaQuery.of(context).size.width / 14,
                                    image: AssetImage(data[index][1]),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(right: 10,left: 10),
                              child: Text(
                                data[index][0],
                                style: TextStyle(
                                    fontFamily: AqarFont.font_family,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        onTap: () async {
                          switch (index) {
                            case 0:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AdvancedSearchPage(
                                          token: (sharedPrefs.getString(
                                                      'user_access_token') ==
                                                  null)
                                              ? StaticMethods.vistor_token
                                              : sharedPrefs.getString(
                                                  'user_access_token'))));
                              break;
                            case 1:
                              int shared_id = sharedPrefs.getInt('user_id');
                              String shared_name =
                                  sharedPrefs.getString('user_name');
                              String shared_email =
                                  sharedPrefs.getString('user_email');
                              String shared_mobile =
                                  sharedPrefs.getString('user_mobile');
                              String shared_token =
                                  sharedPrefs.getString('user_access_token');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditUser(
                                            shared_id: shared_id,
                                            shared_name: shared_name,
                                            shared_email: shared_email,
                                            shared_mobile: shared_mobile,
                                            shared_token: shared_token,
                                          )));

                              break;
                            case 2:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyReservation(
                                          token: (sharedPrefs.getString(
                                                      'user_access_token') ==
                                                  null)
                                              ? StaticMethods.vistor_token
                                              : sharedPrefs.getString(
                                                  'user_access_token'),
                                          user_id:
                                              sharedPrefs.getInt('user_id'))));
                              break;
                            case 3:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FavouriteList(
                                          token: (sharedPrefs.getString(
                                                      'user_access_token') ==
                                                  null)
                                              ? StaticMethods.vistor_token
                                              : sharedPrefs.getString(
                                                  'user_access_token'),
                                          user_id:
                                              sharedPrefs.getInt('user_id'))));
                              break;
                            case 4:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Invoices(
                                          token: (sharedPrefs.getString(
                                              'user_access_token') ==
                                              null)
                                              ? StaticMethods.vistor_token
                                              : sharedPrefs.getString(
                                              'user_access_token'),
                                          user_id: sharedPrefs.getInt('user_id'))));
                              break;
                            case 5:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyCards(
                                          token: (sharedPrefs.getString(
                                              'user_access_token') ==
                                              null)
                                              ? StaticMethods.vistor_token
                                              : sharedPrefs.getString(
                                              'user_access_token'),
                                          user_id:
                                          sharedPrefs.getInt('user_id'))));
                              break;
                            case 6:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ContactUs(
                                            token: (sharedPrefs.getString(
                                                        'user_access_token') ==
                                                    null)
                                                ? StaticMethods.vistor_token
                                                : sharedPrefs.getString(
                                                    'user_access_token'),
                                          )));
                              break;
                            case 7:
                              if (StaticMethods.customer_care_value == 0) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => CustomerServiceComplain(token: (sharedPrefs.getString(
                                                            'user_access_token') == null) ? StaticMethods.vistor_token : sharedPrefs.getString(
                                                        'user_access_token'),
                                                user_id: sharedPrefs
                                                    .getInt('user_id'))));
                              } else if (StaticMethods.customer_care_value ==
                                  1) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CustomerServices(
                                            token: (sharedPrefs.getString(
                                                        'user_access_token') ==
                                                    null)
                                                ? StaticMethods.vistor_token
                                                : sharedPrefs.getString(
                                                    'user_access_token'),
                                            user_id: sharedPrefs
                                                .getInt('user_id'))));
                              }
                              break;
                            case 8:
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Settings()));



                              break;
                            case 9:
                              if (sharedPrefs.getString('user_access_token') ==
                                  null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => UserSignIn()));
                              } else {
                                await ApiProvider.sigOut(
                                    sharedPrefs.getString('user_access_token'),
                                    context);
                              }

                              break;
                          }
                        },
                      )
                  );
                }),
          ),
        ));
  }

  void _changeLanguage(LanguageModel lang) {
    print('language : ${lang.language_code}');
    Locale _temp;
    switch(lang.language_code){
      case 'en':
        _temp = Locale(lang.language_code , 'US');
        break;
      case 'ar':
        _temp = Locale(lang.language_code , 'EG');
        break;
      default:
        _temp = Locale(lang.language_code , 'EG');
        break;
    }
    MyApp.setLocale(context, _temp);
  }
}
