import 'package:flutter/material.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';


class BottomNavigation extends StatefulWidget {
  int index;

  BottomNavigation({this.index});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BottomNavigation_State();
  }
}

class BottomNavigation_State extends State<BottomNavigation> {
  var style = TextStyle(fontFamily: AqarFont.font_family);
  SharedPreferences sharedPrefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() => sharedPrefs = prefs);
    });
  }

  void onTabTapped(int index) {
    setState(() {
      switch (index) {
        case 0:
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MorePage()));
          break;
        case 1:
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OrdersPage(
                      token:
                          (sharedPrefs.getString('user_access_token') == null)
                              ? StaticMethods.vistor_token
                              : sharedPrefs.getString('user_access_token'),
                      user_id: sharedPrefs.getInt('user_id'))));
          break;
        case 2:
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Notifications(
                      token:
                          (sharedPrefs.getString('user_access_token') == null)
                              ? StaticMethods.vistor_token
                              : sharedPrefs.getString('user_access_token'),
                      user_id: sharedPrefs.getInt('user_id'))));
          break;
        case 3:
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OfferPage(
                        token:
                            (sharedPrefs.getString('user_access_token') == null)
                                ? StaticMethods.vistor_token
                                : sharedPrefs.getString('user_access_token'),
                      )));
          break;
        case 4:
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
                        token:
                            (sharedPrefs.getString('user_access_token') == null)
                                ? StaticMethods.vistor_token
                                : sharedPrefs.getString('user_access_token'),
                      )));
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Directionality(
      textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.rtl : TextDirection.ltr,
      child: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(248, 248, 248, 0.92),
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.index,
        selectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        onTap: onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.more_horiz,
              color: widget.index==0? AppColor.primary_color : Colors.black,
              size: 25,
            ),
            title: Text(
                AppLocalization.of(context).translate('more_bar'), style: style,textAlign: TextAlign.center,),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage('images/home/shopping-cart.png'),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.07,
              color: widget.index==1? AppColor.primary_color : Colors.black,

            ),
            title: Text(
              AppLocalization.of(context).translate('order'),
              style: style,
            ),
          ),

          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage('images/home/bell.png'),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.07,
              color: widget.index==2? AppColor.primary_color : Colors.black,

            ),
            title: Text(
              AppLocalization.of(context).translate('notification'),
              style: style,textAlign: TextAlign.center,
            ),


          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage('images/home/notification.png'),
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.07,
              color: widget.index==3? AppColor.primary_color : Colors.black,

            ),
            title: Text(
              AppLocalization.of(context).translate('offer'),
              style: style,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image(
              image: AssetImage('images/home/home.png'),
              color: widget.index==4? AppColor.primary_color : Colors.black,
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.width * 0.07,
            ),
            title: Text(
              AppLocalization.of(context).translate('home'),
              style: style,
            ),
          ),
        ],

      ),
    );
  }
}
