import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:salonic/Custom_Widgets/custom_textfield.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';
import 'package:salonic/Model/Booking/book_service_model.dart';
import 'package:salonic/Presenter/static_methods.dart';

import 'mukap_artist_panel_list.dart';

class BookServiceExpansionPanel extends StatefulWidget {
  final String token;
  final int salon_id;
  BookServiceExpansionPanel({this.token, this.salon_id});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BookServiceExpansionPanel_State();
  }
}

class BookServiceExpansionPanel_State extends State<BookServiceExpansionPanel> {
  bool check = true;
  List<int> bookServiceChecked = [];
  TextEditingController numberOfUsers;
  int service_id;
  List<int> picked_services;
  int users_number;
  List<int> number_of_users;
  SharedPreferences sharedPrefs;
  int qty = 1;

  List<Item> generateItems(int numberOfItems) {
    print('generateItems---');
    return List.generate(numberOfItems, (int index) {
      print('header index : ${index}');
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
    header_item = [AppLocalization.of(context).translate('service_chosse')];
    _data = generateItems(1);
    picked_services = List<int>();
    number_of_users = List<int>();
    numberOfUsers = new TextEditingController();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        sharedPrefs = prefs;
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
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
                  title:  Text(item.headerValue),
                );
              },
              body: Container(
                height: MediaQuery.of(context).size.width / 3,
                child: (StaticMethods.bookServiceList == null)
                    ? Container(
                  child: Text(AppLocalization.of(context).translate('depart_validator')),
                )
                    : FutureBuilder<List<BookServiceModel>>(
                  future: StaticMethods.bookServiceList,
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
                              if (snapshot.data.length != 0) {
                                return Container(
                                    padding: EdgeInsets.only(
                                        right: 10, left: 10),
                                    child: Column(
                                      children: <Widget>[
                                        CheckboxListTile(
                                          title: Text(
                                            '${snapshot.data[index].name} \t \t \t ${snapshot.data[index].price} ريال ',
                                          ),
                                          value: bookServiceChecked
                                              .contains(snapshot
                                              .data[index].id),
                                          onChanged: (val) {
                                            if (val) {
                                              setState(() {
                                                numberOfUsersPop();
                                                print(
                                                    'number_of_users : ${number_of_users}');
                                                bookServiceChecked.add(
                                                    snapshot
                                                        .data[index].id);
                                                List<String> serviceList =
                                                bookServiceChecked
                                                    .map((i) =>
                                                    i.toString())
                                                    .toList();
                                                sharedPrefs.setStringList(
                                                    'book_service_id',
                                                    serviceList);

                                                print(
                                                    'ischecked : ${bookServiceChecked}');
                                                // item.isExpanded =false;
                                                StaticMethods
                                                    .mukapArtistList =
                                                    ApiProvider
                                                        .getMukapArtistByService(
                                                        widget.token,
                                                        widget
                                                            .salon_id,
                                                        snapshot
                                                            .data[
                                                        index]
                                                            .id,
                                                        context);
                                                item.isExpanded = false;
                                                print('3333333');

                                                header_item.add(snapshot
                                                    .data[index].name);
                                                print(
                                                    'header_item : ${header_item}');
                                                item.headerValue =
                                                    header_item.last;
                                                print('44444444444');
                                              });
                                            } else {
                                              setState(() {
                                                //   check = val;
                                                bookServiceChecked.remove(
                                                    snapshot
                                                        .data[index].id);
                                                List<String> serviceList =
                                                bookServiceChecked
                                                    .map((i) =>
                                                    i.toString())
                                                    .toList();
                                                sharedPrefs.setStringList(
                                                    'book_service_id',
                                                    serviceList);

                                                number_of_users
                                                    .remove(users_number);
                                                List<String>
                                                users_numberList =
                                                number_of_users
                                                    .map((i) =>
                                                    i.toString())
                                                    .toList();
                                                sharedPrefs.setStringList(
                                                    'book_users_number',
                                                    users_numberList);
                                                print(
                                                    'number_of_users : ${number_of_users}');
                                              });
                                            }
                                          },
                                        ),
                                        Divider(
                                          color: AppColor.secondary_color,
                                        )
                                      ],
                                    ));
                              } else {
                                return Container();
                              }
                            },
                          );
                        } else {
                          return Container(
                            child:
                            Text(AppLocalization.of(context).translate('no_depart')),
                          );
                        }
                      } else {
                        return Container(
                          child: Text(AppLocalization.of(context).translate('no_depart')),
                        );
                      }
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
/*
  Widget data_list(Item item) {
    switch (item.headerValue) {
      case 'اختيار الخدمه':
        print('service##  ${StaticMethods.bookServiceList}');
        return Container(
          height: MediaQuery.of(context).size.width / 3,
          child: (StaticMethods.bookServiceList == null)
              ? Container(
            child: Text(AppLocalization.of(context).translate('depart_validator')),
          )
              : FutureBuilder<List<BookServiceModel>>(
            future: StaticMethods.bookServiceList,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  if (snapshot.data.length != 0) {
                    return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (snapshot.data.length != 0) {
                          return Container(
                              padding:
                              EdgeInsets.only(right: 10, left: 10),
                              child: Column(
                                children: <Widget>[
                                  CheckboxListTile(
                                    title: Text(
                                      '${snapshot.data[index].name} \t \t \t ${snapshot.data[index].price} ريال ',
                                    ),
                                    value: bookServiceChecked.contains(
                                        snapshot.data[index].id),
                                    onChanged: (val) {
                                      if (val) {
                                        setState(() {
                                          numberOfUsersPop();
                                          print(
                                              'number_of_users : ${number_of_users}');
                                          bookServiceChecked.add(
                                              snapshot.data[index].id);
                                          List<String> serviceList =
                                          bookServiceChecked
                                              .map(
                                                  (i) => i.toString())
                                              .toList();
                                          sharedPrefs.setStringList(
                                              'book_service_id',
                                              serviceList);

                                          print(
                                              'ischecked : ${bookServiceChecked}');
                                          // item.isExpanded =false;
                                          StaticMethods.mukapArtistList =
                                              ApiProvider
                                                  .getMukapArtistByService(
                                                  widget.token,
                                                  widget.salon_id,
                                                  snapshot
                                                      .data[index].id,
                                                  context);
                                        });
                                      } else {
                                        setState(() {
                                          //   check = val;
                                          bookServiceChecked.remove(
                                              snapshot.data[index].id);
                                          List<String> serviceList =
                                          bookServiceChecked
                                              .map(
                                                  (i) => i.toString())
                                              .toList();
                                          sharedPrefs.setStringList(
                                              'book_service_id',
                                              serviceList);

                                          number_of_users
                                              .remove(users_number);
                                          List<String> users_numberList =
                                          number_of_users
                                              .map(
                                                  (i) => i.toString())
                                              .toList();
                                          sharedPrefs.setStringList(
                                              'book_users_number',
                                              users_numberList);
                                          print(
                                              'number_of_users : ${number_of_users}');
                                        });
                                      }
                                    },
                                  ),
                                  Divider(
                                    color: AppColor.secondary_color,
                                  )
                                ],
                              ));
                        } else {
                          return Container();
                        }
                      },
                    );
                  } else {
                    return Container(
                      child: Text(AppLocalization.of(context).translate('no_service')),
                    );
                  }
                } else {
                  return Container(
                    child: Text(AppLocalization.of(context).translate('no_service')),
                  );
                }
              }

              // By default, show a loading spinner.
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
        );
        break;
    }
  }


 */

  void numberOfUsersPop() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            child: AlertDialog(
              contentPadding: EdgeInsets.all(10.0),
              content: SafeArea(
                child: SingleChildScrollView(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: new Container(
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Container(
                                  alignment:    AppLocalization.of(context).locale.languageCode == 'en'
                                      ?Alignment.centerLeft:Alignment.centerRight,
                                  child: Text(
                                   AppLocalization.of(context).translate('person_num'),
                                    style: TextStyle(fontFamily: AqarFont.font_family),),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: InkWell(
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: Icon(
                                      Icons.close,
                                      size: 20,
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ],
                          ),


                          Container(
                            //    padding: EdgeInsets.only(right: 40, top: 10),
                              alignment: Alignment.center,
                              child: //------------qyantity-----------
                              StatefulBuilder(
                                builder: (context, StateSetter setState) {
                                  return Container(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        MaterialButton(
                                          height: 5,
                                          onPressed: () {
                                            setState(() {
                                              qty++;
                                            });
                                          },
                                          color: Colors.grey,
                                          textColor: Colors.white,
                                          child: Icon(
                                            Icons.add,
                                            size: 18,
                                          ),
                                          padding: EdgeInsets.all(5),
                                          shape: CircleBorder(),
                                        ),
                                        quantity(),
                                        MaterialButton(
                                          height: 5,
                                          onPressed: () {
                                            setState(() {
                                              if (qty <= 1) {
                                                Fluttertoast.showToast(
                                                    msg:
                                                    AppLocalization.of(context).translate('persons_count'),
                                                    toastLength:
                                                    Toast.LENGTH_SHORT,
                                                    gravity:
                                                    ToastGravity.BOTTOM,
                                                    timeInSecForIosWeb: 1,
                                                    backgroundColor: Colors.red,
                                                    textColor: Colors.white,
                                                    fontSize: 16.0);
                                              } else {
                                                setState(() {
                                                  qty--;
                                                });
                                              }
                                            });
                                          },
                                          color: Colors.grey,
                                          textColor: Colors.white,
                                          child: Icon(
                                            Icons.remove,
                                            size: 18,
                                          ),
                                          padding: EdgeInsets.all(5),
                                          shape: CircleBorder(),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )),
                          Padding(
                            padding: EdgeInsets.only(right: 10, top: 10),
                            child: new Container(
                              alignment: Alignment.center,
                              child: ButtonTheme(
                                minWidth: MediaQuery.of(context).size.width / 2.5,
                                child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                    side: BorderSide(
                                      color: AppColor.primary_color,
                                      width: 1.0,
                                    ),
                                  ),
                                  color: AppColor.primary_color,
                                  child: Text(
                                   AppLocalization.of(context).translate('confirm'),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: AqarFont.font_family,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  onPressed: () {
                                    //  String number = numberOfUsers.text.trim();
                                    users_number = qty;
                                    number_of_users.add(users_number);
                                    print('numberOfUsers : ${number_of_users}');
                                    List<String> users_numberList =
                                    number_of_users
                                        .map((i) => i.toString())
                                        .toList();
                                    sharedPrefs.setStringList(
                                        'book_users_number', users_numberList);
                                    Navigator.of(context).pop();
                                    qty =1; // return quantity value to default state
                                  },
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget quantity() {
    return Text(
      '${qty}',
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
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
