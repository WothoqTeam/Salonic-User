import 'package:flutter/material.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';
import 'package:salonic/Model/Booking/service_type_model.dart';
import 'package:salonic/Presenter/static_methods.dart';

class CityExpansionPanel extends StatefulWidget {
  final String token;

  CityExpansionPanel({this.token});

  @override
  _CityExpansionPanelState createState() => _CityExpansionPanelState();
}

class _CityExpansionPanelState extends State<CityExpansionPanel> {
  int _currentIndex = 1;
  bool check = true;
  int city_id;
  SharedPreferences sharedPrefs;
  Future<List<CityModel>> cityList;

  List<Item> generateItems(int numberOfItems) {
    return List.generate(numberOfItems, (int index) {
      return Item(
        headerValue: header_item[index],
      );
    });
  }

  List header_item ;
  List<Item> _data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    header_item = [AppLocalization.of(context).translate('chosse_city')];
    _data = generateItems(1);
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        sharedPrefs = prefs;
      });
    });
    cityList = ApiProvider.getAllCities(widget.token, context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cityList = null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10),
        child: ExpansionPanelList(
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              _data[index].isExpanded = !isExpanded;
            });
          },
          children: _data.map<ExpansionPanel>((Item item) {
            return ExpansionPanel(
              headerBuilder: (BuildContext context, bool isExpanded) {
                return ListTile(
                  title: Text(item.headerValue),
                );
              },
              body: Container(
                height: MediaQuery.of(context).size.width / 3,
                child: FutureBuilder<List<CityModel>>(
                  future: cityList,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Directionality(
                              textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,                              child: Container(
                              padding: EdgeInsets.only(right: 10, left: 10),
                              child: Column(
                                children: <Widget>[
                                  RadioListTile(
                                    groupValue: _currentIndex,
                                    title: Text(
                                      "${snapshot.data[index].name}",
                                      textDirection: TextDirection.rtl,
                                    ),
                                    value: snapshot.data[index].id,
                                    onChanged: (val) {
                                      setState(() {
                                        _currentIndex = val;
                                        check = false;
                                        city_id = snapshot.data[index].id;
                                        sharedPrefs.setInt(
                                            'city_id', city_id);
                                        ("city_id : ${city_id}");
                                        item.isExpanded = false;
                                        header_item
                                            .add(snapshot.data[index].name);
                                        (
                                            'header_item : ${header_item}');
                                        item.headerValue = header_item.last;
                                        ('44444444444');
                                      });
                                    },
                                  ),
                                  Divider(
                                    color: AppColor.secondary_color,
                                  )
                                ],
                              )));
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Text(
                        "${snapshot.error}",
                        style: TextStyle(color: AppColor.secondary_color),
                      );
                    }

                    // By default, show a loading spinner.
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              isExpanded: item.isExpanded,
            );
          }).toList(),
        ));
  }
}

class Item {
  Item({
    this.expandedValue,
    this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}
