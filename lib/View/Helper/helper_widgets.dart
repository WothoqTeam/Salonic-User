import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:salonic/Model/offer_model.dart';

class HelperWidgets extends State {
  SharedPreferences sharedPrefs;
  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) => (sharedPrefs = prefs));
  }

  static Widget ratingbar_fun(
      int star_number, double rating, double star_size) {
    return RatingBar.readOnly(
      initialRating: rating,
      maxRating: star_number,
      isHalfAllowed: true,
      halfFilledIcon: Icons.star_half,
      filledIcon: Icons.star,
      emptyIcon: Icons.star_border,
      size: star_size,
      filledColor: Colors.yellow.shade700,
    );
  }

  static Widget salonic_rating_fun(
      int star_number, double rating, double star_size) {
    return RatingBar(
      initialRating: rating,
      maxRating: star_number,
      isHalfAllowed: true,
      halfFilledIcon: Icons.star_half,
      filledIcon: Icons.star,
      emptyIcon: Icons.star_border,
      size: star_size,
      filledColor: Colors.yellow.shade700,
    );
  }

  Widget reserve_now_image_slider(BuildContext context) {
    return new Container(
      height: MediaQuery.of(context).size.width / 2.5,
      width: MediaQuery.of(context).size.width,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          reserve_now_slider(context),
          reserve_now_slider(context),
          reserve_now_slider(context),
        ],
        autoplay: true,
        autoplayDuration: Duration(seconds: 2),
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 3.0,
        dotColor: Colors.black,
        indicatorBgPadding: 2.0,
        showIndicator: true,
        dotPosition: DotPosition.bottomCenter,
        dotBgColor: Colors.white,
        dotIncreasedColor: AppColor.primary_color,
      ),
    );

   }

  Widget reserve_now_slider(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 20, bottom: 5),
            child: Image(
              height: MediaQuery.of(context).size.width / 3,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
              image: AssetImage('images/offer/sa.jpg'),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 30),
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  child: IconButton(
                    icon: Icon(
                      Icons.favorite_border,
                      size: 25,
                      color: AppColor.primary_color,
                    ),
                    onPressed: () {},
                  )))
        ],
      ),
    );
  }

  Widget spinner_show_time_and_date(String hint) {
    String _value;
    return Padding(
      padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 0),
      child: new Container(
        alignment: Alignment.center,
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(5.0),
          side: BorderSide(
            width: 1.0,
            color: Color(0xFFDEDEDE),
          ),
        )),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton<String>(
              value: _value,
              isExpanded: true,
              icon: Icon(Icons.keyboard_arrow_down),
              hint: Text(
                hint,
                style: TextStyle(fontFamily: AqarFont.font_family, fontSize: 14),
              ),
              onChanged: (String newValue) {
                setState(() {
                  _value = newValue;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget reserve_selection(String frist_value, String second_value) {
    String _picked = frist_value;

    return RadioButtonGroup(
      orientation: GroupedButtonsOrientation.HORIZONTAL,
      margin: const EdgeInsets.only(right: 25.0),
      onSelected: (String selected) => setState(() {
        _picked = selected;
      }),
      labelStyle: TextStyle(fontFamily: AqarFont.font_family),
      labels: <String>[
        frist_value,
        second_value,
      ],
      picked: _picked,
      activeColor: Colors.black,
      itemBuilder: (Radio rb, Text txt, int i) {
        return Row(
          children: <Widget>[
            rb,
            txt,
            SizedBox(
              width: 50,
            )
          ],
        );
      },
    );
  }

  static Future<bool> toast(String message) {
    return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: AppColor.primary_color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

  show_service(Widget x) {
    return x;
  }
}
