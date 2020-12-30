import 'package:flutter/material.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';
import 'package:salonic/Model/Booking/mukap_artist_model.dart';
import 'package:salonic/Presenter/static_methods.dart';

class MukapArtistPanelList extends StatefulWidget {
  final String token;
  final int salon_id;
  MukapArtistPanelList({this.token, this.salon_id});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MukapArtistPanelListState();
  }
}

class MukapArtistPanelListState extends State<MukapArtistPanelList> {
  bool check = true;
  int _currentIndex = 1;

  int mukap_artist_id;
  SharedPreferences sharedPrefs;

  List<Item> generateItems(int numberOfItems) {
    ('generateItems---');
    return List.generate(numberOfItems, (int index) {
      ('header index : ${index}');
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
    header_item = [AppLocalization.of(context).translate('specialist_chosse')];
    _data = generateItems(1);
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
                  child: (StaticMethods.mukapArtistList == null)
                      ? Container(
                          child: Text(AppLocalization.of(context).translate('service_vaildator')),
                        )
                      : FutureBuilder<List<MukapArtistModel>>(
                          future: StaticMethods.mukapArtistList,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              if (snapshot.hasData) {
                                if (snapshot.data.length != 0) {
                                  return ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: snapshot.data.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Directionality(
                                        textDirection: AppLocalization.of(context).locale.languageCode=='en'? TextDirection.ltr : TextDirection.rtl,                                        child: Container(
                                            padding: EdgeInsets.only(
                                                right: 10, left: 10),
                                            child: Column(
                                              children: <Widget>[
                                                RadioListTile(
                                                  groupValue: _currentIndex,
                                                  title: Text(
                                                    "${snapshot.data[index].name}",
                                                    textDirection:
                                                        TextDirection.rtl,
                                                  ),
                                                  value:
                                                      snapshot.data[index].id,
                                                  onChanged: (val) {
                                                    setState(() {
                                                      _currentIndex = val;
                                                      mukap_artist_id = snapshot
                                                          .data[index].id;
                                                      sharedPrefs.setInt(
                                                          'mukap_artist_id',
                                                          mukap_artist_id);
                                                      (
                                                          "mukap_artist_id : ${mukap_artist_id}");
                                                      item.isExpanded = false;
                                                      ('3333333');

                                                      header_item.add(snapshot
                                                          .data[index].name);
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
                                            )),
                                      );
                                    },
                                  );
                                } else {
                                  return Container(
                                    child: Text(
                                        AppLocalization.of(context).translate('no_specialist')),
                                  );
                                }
                              } else {
                                return Container(
                                  child: Text(
                                      AppLocalization.of(context).translate('no_specialist')),
                                );
                              }
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
