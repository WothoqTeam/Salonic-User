import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';
import 'package:salonic/Model/Search/filter_model.dart';
import 'package:salonic/View/Advanced_Search/city_expansion_panel.dart';
import 'package:salonic/View/Advanced_Search/service_expamsion_panel.dart';
import 'package:salonic/View/Home/Search/search_result.dart';
import 'package:search_widget/search_widget.dart';

class AdvancedSearchClass extends StatefulWidget {
  final String token;
  AdvancedSearchClass({this.token});

  @override
  State<StatefulWidget> createState() {
    ('AdvancedSearchClass token : ${token}');
    // TODO: implement createState
    return _HomePageState();
  }
}

class _HomePageState extends State<AdvancedSearchClass> {
  SalonDetailsModel _selectedItem;

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

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: FutureBuilder(
        future: StaticMethods.search_salons_list,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return SearchWidget<SalonDetailsModel>(
                dataList: snapshot.data,
                hideSearchBoxWhenItemSelected: true,
                listContainerHeight: MediaQuery.of(context).size.height / 4,
                queryBuilder: (query, list) {
                  return list
                      .where((item) =>
                      item.name.toLowerCase().contains(query.toLowerCase()))
                      .toList();
                },
                popupListItemBuilder: (item) {
                  if (widget.token == StaticMethods.vistor_token) {
                    return PopupListItemWidget(
                        item, StaticMethods.vistor_token);
                  } else {
                    return PopupListItemWidget(item, widget.token);
                  }
                },
                selectedItemBuilder: (selectedItem, deleteSelectedItem) {},
                // widget customization
                noItemsFoundWidget: NoItemsFound(),
                textFieldBuilder: (controller, focusNode) {
                  if (widget.token == StaticMethods.vistor_token) {
                    return MyTextField(controller ,StaticMethods.vistor_token,focusNode);
                  } else {
                    return MyTextField(controller , widget.token , focusNode);
                  }
                },
                onItemSelected: (item) {
                  setState(() {
                    _selectedItem = item;
                  });
                },
              );
            } else {}
          }
          return CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(AppColor.primary_color),
          );
        },
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final String token;
  final TextEditingController controller;
  final FocusNode focusNode;
  const MyTextField(this.controller, this.token,this.focusNode);



  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.black)),
        child: Directionality(
          textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,          child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                decoration: InputDecoration(
                  hintText: "بحث بـ اسم الصالون",
                  hintStyle: TextStyle(
                    color: Color(0xFFBBBBBB),
                  ),
                  prefixIcon: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.search,
                      color: Color(0xFFBBBBBB),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerLeft,
                child: Row(
                  children: <Widget>[
                    Text(
                      AppLocalization.of(context).translate('filter'),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      onPressed: () {
                        filter_widget(context);
                      },
                      icon: Image(
                        image: AssetImage('images/filter.png'),
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
        ));
  }

  Future<Widget> filter_widget(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    int valueHolder = 1;
    Future<List<FilterModel>> advanced_search_salon_list;
    var service_rate = 0.0;
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
                  textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,
                  child: Container(
                      width: width / 2,
                      height: height / 1.5,
                      child: SafeArea(
                          child: SingleChildScrollView(
                            child: Container(
                              child: new Column(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(top: 10, left: 10),
                                    child: InkWell(
                                      child: Container(
                                        alignment: Alignment.topLeft,
                                        child: Icon(
                                          Icons.close,
                                          size: 25,
                                        ),
                                      ),
                                      onTap: () {
                                        valueHolder = 1;
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 10, left: 10),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          alignment:AppLocalization.of(context).locale.languageCode=='en'? Alignment.centerLeft : Alignment.centerRight ,
                                          padding: EdgeInsets.only(
                                              right: 10, left: 10, top: 10),
                                          child: Text(
                                            AppLocalization.of(context).translate('city_name'),
                                            style: TextStyle(
                                                fontFamily: AqarFont.font_family,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF262626)),
                                          ),
                                        ),
                                        CityExpansionPanel(
                                          token: '${token}',
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 10, left: 10),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          alignment:AppLocalization.of(context).locale.languageCode=='en'? Alignment.centerLeft : Alignment.centerRight ,
                                          padding: EdgeInsets.only(
                                              right: 10, left: 10, top: 10),
                                          child: Text(
                                            AppLocalization.of(context).translate('service_type'),
                                            style: TextStyle(
                                                fontFamily: AqarFont.font_family,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF262626)),
                                          ),
                                        ),
                                        ServiceExpansionPanel(
                                          token: token,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 10, left: 10),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          alignment:AppLocalization.of(context).locale.languageCode=='en'? Alignment.centerLeft : Alignment.centerRight ,
                                          padding: EdgeInsets.only(
                                              right: 10, left: 10, top: 10),
                                          child: Text(
                                            AppLocalization.of(context).translate('at_rate'),
                                            style: TextStyle(
                                                fontFamily: AqarFont.font_family,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xFF262626)),
                                          ),
                                        ),
                                        Container(
                                          padding:
                                          EdgeInsets.only(top: 10, bottom: 15),
                                          alignment:AppLocalization.of(context).locale.languageCode=='en'? Alignment.centerLeft : Alignment.centerRight ,
                                          child: RatingBar(
                                            onRatingChanged: (rate) {
                                              setState(() {
                                                service_rate = rate;
                                              });
                                              (
                                                  'service_rate : ${service_rate}');
                                            },
                                            initialRating: service_rate,
                                            maxRating: 5,
                                            isHalfAllowed: true,
                                            halfFilledIcon: Icons.star_half,
                                            filledIcon: Icons.star,
                                            emptyIcon: Icons.star_border,
                                            size: 30,
                                            filledColor: (service_rate >= 1)
                                                ? Colors.yellow.shade700
                                                : Colors.yellow.shade700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 5,
                                    ),
                                    child: RaisedButton(
                                      onPressed: () async {
                                        int rate = service_rate.toInt();
                                        setState(() {
                                          setState(() {
                                            ('filter 1');
                                            advanced_search_salon_list = ApiProvider
                                                .getSalonsByAdvanceSearch(
                                                token,
                                                sharedPreferences
                                                    .getInt('city_id'),
                                                sharedPreferences
                                                    .getInt('service_id'),
                                                rate,
                                                context);
                                            ('filter 2');
                                          });
                                          (
                                              'filter salon : ${advanced_search_salon_list}');
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AdvancedSearchPage(
                                                        token: token,
                                                        filter_salon:
                                                        advanced_search_salon_list,
                                                      )));
                                        });
                                        ('filter 3');
                                      },
                                      color: AppColor.primary_color,
                                      shape: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(5),
                                          borderSide: BorderSide(
                                            color: AppColor.primary_color,
                                          )),
                                      child: Container(
                                        width:
                                        MediaQuery.of(context).size.width / 3,
                                        alignment: Alignment.center,
                                        child: Text(
                                          AppLocalization.of(context).translate('search'),
                                          style: TextStyle(
                                            fontFamily: AqarFont.font_family,
                                            fontSize: 16,
                                            color: AppColor.secondary_color,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ))),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class NoItemsFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(
          Icons.shop,
          size: 24,
          color: AppColor.primary_color,
        ),
        const SizedBox(width: 10),
        Text(
          AppLocalization.of(context).translate('no_salon'),
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[900].withOpacity(0.7),
          ),
        ),
      ],
    );
  }
}

class PopupListItemWidget extends StatelessWidget {
  final SalonDetailsModel item;
  final String token;
  const PopupListItemWidget(this.item, this.token);

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,        child: InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(12),
        child: Text(
          item.name,
          style: const TextStyle(fontSize: 16),
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AdvancedSearchPage(
                  token: token,
                  item: item,
                )));
      },
    ));
  }
}
