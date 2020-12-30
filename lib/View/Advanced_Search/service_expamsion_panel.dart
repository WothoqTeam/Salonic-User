import 'package:flutter/material.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';
import 'package:salonic/Model/Booking/service_type_model.dart';
import 'package:salonic/Presenter/static_methods.dart';

class ServiceExpansionPanel extends StatefulWidget {
  final String token;

  ServiceExpansionPanel({this.token});

  @override
  _ServiceExpansionPanelState createState() => _ServiceExpansionPanelState();
}

class _ServiceExpansionPanelState extends State<ServiceExpansionPanel> {
  bool check = true;
  int _currentIndex = 1;

  int service_id;
  SharedPreferences sharedPrefs;
  Future<List<ServiceModel>> serviceList;

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
    header_item = [AppLocalization.of(context).translate('chosse_service_type')];
    _data = generateItems(1);
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        sharedPrefs = prefs;
      });
    });
    serviceList = ApiProvider.allServiceList(widget.token, context);


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    serviceList = null;
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
                  child: FutureBuilder<List<ServiceModel>>(
                    future: serviceList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Directionality(
                                  textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,                                  child: Container(
                                  padding:
                                  EdgeInsets.only(right: 10, left: 10),
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
                                            service_id =
                                                snapshot.data[index].id;
                                            sharedPrefs.setInt(
                                                'service_id', service_id);
                                            (
                                                "service_id : ${service_id}");
                                            item.isExpanded = false;
                                            header_item.add(
                                                snapshot.data[index].name);
                                            (
                                                'header_item : ${header_item}');
                                            item.headerValue =
                                                header_item.last;
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
                          ),
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
                  )),
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
