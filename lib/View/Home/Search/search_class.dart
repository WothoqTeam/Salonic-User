import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';
import 'package:salonic/View/Home/Search/search_result.dart';
import 'package:search_widget/search_widget.dart';

class SearchClass extends StatefulWidget {
  final String token;
  final bool map;
  SearchClass({this.token,this.map=false});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<SearchClass> {
  List<SalonDetailsModel> list;
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
    list = List<SalonDetailsModel>();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: FutureBuilder(
        future: StaticMethods.search_salons_list,
        // future: ApiProvider.getAllSalons(sharedPrefs.getString('user_access_token'),context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return SearchWidget<SalonDetailsModel>(
                dataList: snapshot.data,
                hideSearchBoxWhenItemSelected: true,
              //  listContainerHeight: MediaQuery.of(context).size.height / 4,
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
                selectedItemBuilder: (selectedItem, deleteSelectedItem) {
                  // return SelectedItemWidget(selectedItem, deleteSelectedItem);
                },
                // widget customization
                noItemsFoundWidget: NoItemsFound(),
                textFieldBuilder: (controller, focusNode) {
                  if (widget.token == StaticMethods.vistor_token) {
                    return MyTextField(
                         controller, focusNode, StaticMethods.vistor_token,map: widget.map,);
                  } else {
                    return MyTextField(controller, focusNode, widget.token,map: widget.map,);
                  }
                },
                onItemSelected: (item) {
                  setState(() {
                    _selectedItem = item;
                  });
                },
              );
            } else {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.black)),
                  child: Directionality(
                    textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,                    child: widget.map?TextField(
                      decoration: InputDecoration(
                        hintText: AppLocalization.of(context).translate('search_text'),
                        hintStyle: TextStyle(
                          color: Color(0xFFBBBBBB),
                        ),
                        prefixIcon: IconButton(
                          onPressed: () {
                          },
                          icon: Icon(
                            Icons.search,
                            color: Color(0xFFBBBBBB),
                          ),
                        ),
                      ),
                    ):Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: TextField(
                            decoration: InputDecoration(
                              hintText:AppLocalization.of(context).translate('search_text'),
                              hintStyle: TextStyle(
                                color: Color(0xFFBBBBBB),
                              ),
                              border: InputBorder.none,
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
                          flex: 2,
                          child: Row(
                            children: <Widget>[
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NearestSalonic(
                                            token: (widget.token ==
                                                StaticMethods
                                                    .vistor_token)
                                                ? StaticMethods.vistor_token
                                                : widget.token,
                                          )));
                                },
                                icon: Icon(
                                  Icons.navigation,
                                  color: AppColor.primary_color,
                                ),
                                alignment: Alignment.centerLeft,
                              ),
                              Text(
                                AppLocalization.of(context).translate('near'),
                                style: TextStyle(
                                    color: AppColor.primary_color, fontSize: 14),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ));
            }
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
  final bool map;
  final TextEditingController controller;
  final FocusNode focusNode;
  const MyTextField(this.controller, this.focusNode, this.token,{this.map=false});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.black)),
        child: Directionality(
          textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,          child:map?TextField(
            controller: controller,
            focusNode: focusNode,
            decoration: InputDecoration(
              hintText: AppLocalization.of(context).translate('search_text'),
              hintStyle: TextStyle(
                color: Color(0xFFBBBBBB),
              ),
              border: InputBorder.none,
              prefixIcon: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  color: Color(0xFFBBBBBB),
                ),
              ),
            ),
          ): Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  decoration: InputDecoration(
                    hintText: AppLocalization.of(context).translate('search_text'),
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
                flex: 2,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NearestSalonic(
                                  token: token,
                                )));
                      },
                      icon: Icon(
                        Icons.navigation,
                        color: AppColor.primary_color,
                      ),
                      alignment: Alignment.centerLeft,
                    ),
                    Text(
                      AppLocalization.of(context).translate('near'),
                      style: TextStyle(color: AppColor.primary_color, fontSize: 14),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
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
                    builder: (context) => SearchResult(
                      token: token,
                      item: item,
                    )));
          },
        ));
  }
}
