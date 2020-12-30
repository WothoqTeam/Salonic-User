import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:intl/intl.dart' as intl;
import 'package:salonic/Custom_Widgets/export_file.dart';
import 'package:salonic/Model/Search/filter_model.dart';
import 'package:salonic/Presenter/static_methods.dart';
import 'package:salonic/View/Home/Search/search_result.dart';

import 'Booking Departments/bookService_panel_list.dart';
import 'Booking Departments/mukap_artist_panel_list.dart';
import 'Booking Departments/serviceType_panel_list.dart';

class RerservationNow extends StatefulWidget {
  final String token;
  final int salon_id;
  final String logo;
  final String name;
  final double rate;
  final int payment;
  final int home_services;
  final int category_id;
  final int service_id;
  List<Galleries> galleries;
  List<Gallery> salonPictures;
  SalonDetailsModel item;
  Future<List<FilterModel>> filter_salon;
  final int
      salon_list_type; // salon_list_type = 1 for SalonicList and salon_list_type = 2 for SalonicListByServiceId
  RerservationNow(
      {this.token,
      this.salon_id,
      this.logo,
      this.name,
      this.rate,
      this.payment,
      this.home_services,
      this.salonPictures,
      this.salon_list_type,
      this.category_id,
      this.service_id,
      this.galleries,
      this.item,
      this.filter_salon});
  @override
  State<StatefulWidget> createState() {
    ('salon_id : ${salon_id}');
    // TODO: implement createState
    return RerservationNow_State();
  }
}

class RerservationNow_State extends State<RerservationNow> {
  String _picked_location;
  String _picked_payment;

  DateTime selectedDate = DateTime.now();
  DateTime _dateTime = DateTime.now();
  var date = '25/7/2020';
  var date_hint;
  bool show_time = false;
  bool dropdown_open = false;
  List<String> payment_type;
  List<String> service_location;
  SharedPreferences sharedPrefs;
  TextEditingController numberOfUsers;
  ProgressDialog progressDialog;
  // SalonDetailsModel item;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    date_hint = AppLocalization.of(context).translate('date_hint');
    _picked_payment = AppLocalization.of(context).translate('pay_cash');
    _picked_location = AppLocalization.of(context).translate('in_center');
    progressDialog = new ProgressDialog(context);
    ('item : ${widget.item}');
    numberOfUsers = new TextEditingController();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        sharedPrefs = prefs;
      });
    });
    payment_type = new List<String>();
    switch (widget.payment) {
      case 0:
        payment_type.add(AppLocalization.of(context).translate('pay_cash'));
        break;
      case 1:
        payment_type.add(AppLocalization.of(context).translate('pay_online'));
        break;
      case 2:
        payment_type.add(AppLocalization.of(context).translate('pay_cash'));
        payment_type.add(AppLocalization.of(context).translate('pay_online'));
        break;
    }
    service_location = new List<String>();
    switch (widget.home_services) {
      case 0:
        service_location
            .add(AppLocalization.of(context).translate('in_center'));
        break;
      case 1:
        service_location.add(AppLocalization.of(context).translate('in_home'));
        break;
      case 2:
        service_location
            .add(AppLocalization.of(context).translate('in_center'));
        service_location.add(AppLocalization.of(context).translate('in_home'));
        break;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    removeReservaationData();
  }

  @override
  Widget build(BuildContext context) {
    progressDialog.style(
        message: AppLocalization.of(context).translate('loading'),
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        progressWidget: CircularProgressIndicator(),
        elevation: 10.0,
        insetAnimCurve: Curves.bounceInOut,
        progress: 0.0,
        maxProgress: 100.0,
        progressTextStyle: TextStyle(
            color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
        messageTextStyle: TextStyle(
            color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600));
    // TODO: implement build
    return WillPopScope(
        onWillPop: () async {
          StaticMethods.bookServiceList = null;
          StaticMethods.bookServiceList = null;
          switch (widget.salon_list_type) {
            case 1:
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SalonicList(
                            token: (widget.token == StaticMethods.vistor_token)
                                ? StaticMethods.vistor_token
                                : widget.token,
                            salon_id: widget.salon_id,
                          )));
              break;
            case 2:
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SalonicListByServiceId(
                            token: (widget.token == StaticMethods.vistor_token)
                                ? StaticMethods.vistor_token
                                : widget.token,
                            service_type: widget.home_services,
                            service_id: widget.service_id,
                          )));
              break;
            case 3:
              //home search
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchResult(
                            token: (sharedPrefs
                                        .getString('user_access_token') ==
                                    null)
                                ? StaticMethods.vistor_token
                                : sharedPrefs.getString('user_access_token'),
                            item: widget.item,
                          )));
              break;
            case 4:
              //AdvancedSearchPage --- widget.item == null
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdvancedSearchPage(
                            token: (sharedPrefs
                                        .getString('user_access_token') ==
                                    null)
                                ? StaticMethods.vistor_token
                                : sharedPrefs.getString('user_access_token'),
                            item: widget.item,
                          )));
              break;
            case 5:
              //AdvancedSearchPage --- widget.item != null
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdvancedSearchPage(
                            token: (sharedPrefs
                                        .getString('user_access_token') ==
                                    null)
                                ? StaticMethods.vistor_token
                                : sharedPrefs.getString('user_access_token'),
                            item: widget.item,
                          )));
              break;
            case 6:
              //AdvancedSearchPage --- filter salon
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdvancedSearchPage(
                            token: (sharedPrefs
                                        .getString('user_access_token') ==
                                    null)
                                ? StaticMethods.vistor_token
                                : sharedPrefs.getString('user_access_token'),
                            filter_salon: widget.filter_salon,
                          )));
              break;
            default:
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => MorePage()));
              break;
          }
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              AppLocalization.of(context).translate('reserve_now'),
              style: TextStyle(fontFamily: AqarFont.font_family),
            ),
            backgroundColor: AppColor.primary_color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFFFFFFFF),
                ),
                onPressed: () {
                  StaticMethods.bookServiceList = null;
                  StaticMethods.bookServiceList = null;
                  switch (widget.salon_list_type) {
                    case 1:
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SalonicList(
                                    token: (widget.token ==
                                            StaticMethods.vistor_token)
                                        ? StaticMethods.vistor_token
                                        : widget.token,
                                    salon_id: widget.salon_id,
                                  )));
                      break;
                    case 2:
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SalonicListByServiceId(
                                    token: (widget.token ==
                                            StaticMethods.vistor_token)
                                        ? StaticMethods.vistor_token
                                        : widget.token,
                                    service_type: widget.home_services,
                                    service_id: widget.service_id,
                                  )));
                      break;
                    case 3:
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchResult(
                                  token: (sharedPrefs
                                              .getString('user_access_token') ==
                                          null)
                                      ? StaticMethods.vistor_token
                                      : sharedPrefs
                                          .getString('user_access_token'),
                                  item: widget.item)));
                      break;
                    case 4:
                      //AdvancedSearchPage --- widget.item == null
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdvancedSearchPage(
                                    token: (sharedPrefs.getString(
                                                'user_access_token') ==
                                            null)
                                        ? StaticMethods.vistor_token
                                        : sharedPrefs
                                            .getString('user_access_token'),
                                    item: widget.item,
                                  )));
                      break;
                    case 6:
                      //AdvancedSearchPage --- filter salon
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AdvancedSearchPage(
                                    token: (sharedPrefs.getString(
                                                'user_access_token') ==
                                            null)
                                        ? StaticMethods.vistor_token
                                        : sharedPrefs
                                            .getString('user_access_token'),
                                    filter_salon: widget.filter_salon,
                                  )));
                      break;
                    default:
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => MorePage()));
                      break;
                  }
                }),
          ),
          body: (widget.token == StaticMethods.vistor_token)
              ? VistorMessage()
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.only(top: 0, right: 10, left: 10),
                      child: Directionality(
                        textDirection:
                            AppLocalization.of(context).locale.languageCode ==
                                    'en'
                                ? TextDirection.ltr
                                : TextDirection.rtl,
                        child: new Container(
                          child: Column(
                            children: <Widget>[
                              (widget.galleries == null)
                                  ? SalonSlider(
                                      salonPictures: widget.salonPictures,
                                    )
                                  : CarouselSlider.builder(
                                      itemCount: widget.galleries.length,
                                      options: CarouselOptions(
                                        autoPlay: true,
                                        enlargeCenterPage: true,
                                        viewportFraction: 0.9,
                                        aspectRatio: 2.5,
                                        initialPage: 0,
                                      ),
                                      itemBuilder:
                                          (BuildContext context, index) {
                                        if (widget.galleries.length != 0) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  top: 10, bottom: 5),
                                              child: Image.network(
                                                '${widget.galleries[index].photo}',
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        } else {
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  top: 10, bottom: 5),
                                              child: Image(
                                                image: AssetImage(
                                                    'images/offer/sa.jpg'),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    5,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                6,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                6,
                                        child: Image.network(
                                          '${widget.logo}',
                                          fit: BoxFit.cover,
                                        ),
                                      )),
                                  Expanded(
                                      flex: 4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(right: 5),
                                            child: Text(
                                              '${widget.name}',
                                              style: TextStyle(
                                                  fontFamily: AqarFont.font_family,
                                                  color: Color(0xFF707070),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18),
                                            ),
                                          ),
                                          Container(
                                              padding:
                                                  EdgeInsets.only(right: 10),
                                              child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: <Widget>[
                                                    HelperWidgets.ratingbar_fun(
                                                        5, widget.rate, 20),
                                                  ])),
                                        ],
                                      )),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    alignment: AppLocalization.of(context)
                                                .locale
                                                .languageCode ==
                                            'en'
                                        ? Alignment.centerLeft
                                        : Alignment.centerRight,
                                    padding: EdgeInsets.only(
                                        right: 10, left: 10, top: 10),
                                    child: Text(
                                      AppLocalization.of(context)
                                          .translate('depart'),
                                      style: TextStyle(
                                          fontFamily: AqarFont.font_family,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF262626)),
                                    ),
                                  ),
                                  ServiceTypeExpansionPanel(
                                    token: widget.token,
                                    salon_id: widget.salon_id,
                                    home_service: widget.home_services,
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    alignment: AppLocalization.of(context)
                                                .locale
                                                .languageCode ==
                                            'en'
                                        ? Alignment.centerLeft
                                        : Alignment.centerRight,
                                    padding:
                                        EdgeInsets.only(right: 10, left: 10),
                                    child: Text(
                                      AppLocalization.of(context)
                                          .translate('service_chosse'),
                                      style: TextStyle(
                                          fontFamily: AqarFont.font_family,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF262626)),
                                    ),
                                  ),
                                  BookServiceExpansionPanel(
                                      token: widget.token,
                                      salon_id: widget.salon_id),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    alignment: AppLocalization.of(context)
                                                .locale
                                                .languageCode ==
                                            'en'
                                        ? Alignment.centerLeft
                                        : Alignment.centerRight,
                                    padding: EdgeInsets.only(
                                        right: 10, left: 10, top: 10),
                                    child: Text(
                                      AppLocalization.of(context)
                                          .translate('specialist_chosse'),
                                      style: TextStyle(
                                          fontFamily: AqarFont.font_family,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF262626)),
                                    ),
                                  ),
                                  MukapArtistPanelList(
                                      token: widget.token,
                                      salon_id: widget.salon_id),
                                ],
                              ),
                              TimePicker(),
                              Date_Picker(),
                              Column(
                                children: <Widget>[
                                  Container(
                                    alignment: AppLocalization.of(context)
                                                .locale
                                                .languageCode ==
                                            'en'
                                        ? Alignment.centerLeft
                                        : Alignment.centerRight,
                                    padding: EdgeInsets.only(
                                        right: 10, left: 10, top: 10),
                                    child: Text(
                                      AppLocalization.of(context)
                                          .translate('service_location'),
                                      style: TextStyle(
                                          fontFamily: AqarFont.font_family,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF262626)),
                                    ),
                                  ),
                                  RadioButtonGroup(
                                    orientation:
                                        GroupedButtonsOrientation.HORIZONTAL,
                                    margin: const EdgeInsets.only(right: 10.0),
                                    onSelected: (String selected) =>
                                        setState(() {
                                      _picked_location = selected;
                                      ('_picked_location: ${_picked_location}');
                                    }),
                                    labelStyle: TextStyle(fontFamily: AqarFont.font_family),
                                    labels: service_location,
                                    picked: _picked_location,
                                    activeColor: Colors.black,
                                    itemBuilder: (Radio rb, Text txt, int i) {
                                      return Row(
                                        children: <Widget>[
                                          rb,
                                          txt,
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                7,
                                          )
                                        ],
                                      );
                                    },
                                  )
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Container(
                                    alignment: AppLocalization.of(context)
                                                .locale
                                                .languageCode ==
                                            'en'
                                        ? Alignment.centerLeft
                                        : Alignment.centerRight,
                                    padding: EdgeInsets.only(
                                        right: 10, left: 10, top: 10),
                                    child: Text(
                                      AppLocalization.of(context)
                                          .translate('payment_method'),
                                      style: TextStyle(
                                          fontFamily: AqarFont.font_family,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xFF262626)),
                                    ),
                                  ),
                                  RadioButtonGroup(
                                    orientation:
                                        GroupedButtonsOrientation.HORIZONTAL,
                                    margin: const EdgeInsets.only(right: 10.0),
                                    onSelected: (String selected) =>
                                        setState(() {
                                      _picked_payment = selected;
                                      ('_picked_payment: ${_picked_payment}');
                                    }),
                                    labelStyle: TextStyle(fontFamily: AqarFont.font_family),
                                    labels: payment_type,
                                    picked: _picked_payment,
                                    activeColor: Colors.black,
                                    itemBuilder: (Radio rb, Text txt, int i) {
                                      return Row(
                                        children: <Widget>[
                                          rb,
                                          txt,
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                10,
                                          )
                                        ],
                                      );
                                    },
                                  )
                                ],
                              ),
                              _picked_location ==
                                      AppLocalization.of(context)
                                          .translate('in_home')
                                  ? Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              right: 10, left: 10, bottom: 10),
                                          alignment: AppLocalization.of(context)
                                                      .locale
                                                      .languageCode ==
                                                  'en'
                                              ? Alignment.centerLeft
                                              : Alignment.centerRight,
                                          child: Text(
                                            AppLocalization.of(context)
                                                .translate('on_map'),
                                            style: TextStyle(
                                                color: Color(0xFF292929),
                                                fontFamily: AqarFont.font_family,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: GoogleMap(
                                                myLocationButtonEnabled: true,
                                                myLocationEnabled: true,
                                                mapType: MapType.hybrid,
                                                initialCameraPosition:
                                                    CameraPosition(
                                                  target: LatLng(
                                                      24.774265, 46.738586),
                                                  zoom: 4,
                                                ),
                                                markers: Set<Marker>.of(
                                                    markers.values),
                                                onTap: (latLng) async {
                                                  sharedPrefs.setString(
                                                      'home_lat',
                                                      latLng.latitude
                                                          .toString());
                                                  sharedPrefs.setString(
                                                      'home_lang',
                                                      latLng.longitude
                                                          .toString());
                                                  ('${latLng.latitude}, ${latLng.longitude}');
                                                  final coordinates =
                                                      new Coordinates(
                                                          latLng.latitude,
                                                          latLng.longitude);
                                                  var addresses = await Geocoder
                                                      .local
                                                      .findAddressesFromCoordinates(
                                                          coordinates);
                                                  var first = addresses.first;
                                                  sharedPrefs.setString(
                                                      'home-address',
                                                      first.addressLine);
                                                  _add(latLng,
                                                      first.addressLine);
                                                }))
                                      ],
                                    )
                                  : Container(),
                              new Container(
                                  padding:
                                      EdgeInsets.only(top: 20.0, bottom: 10),
                                  alignment: Alignment.center,
                                  child: ButtonTheme(
                                    minWidth:
                                        MediaQuery.of(context).size.width / 1.5,
                                    padding: EdgeInsets.all(5),
                                    child: RaisedButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        side: BorderSide(
                                          color: AppColor.primary_color,
                                          width: 1.0,
                                        ),
                                      ),
                                      color: AppColor.primary_color,
                                      child: Text(
                                        AppLocalization.of(context)
                                            .translate('reserve_now'),
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontFamily: AqarFont.font_family,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      onPressed: () async {
                                        progressDialog.show();
                                        switch (widget.payment) {
                                          case 0:
                                            sharedPrefs.setInt(
                                                'pick_payment', 0);
                                            break;
                                          case 1:
                                            sharedPrefs.setInt(
                                                'pick_payment', 1);
                                            break;
                                          case 2:
                                            if (_picked_payment ==
                                                AppLocalization.of(context)
                                                    .translate('pay_cash')) {
                                              sharedPrefs.setInt(
                                                  'pick_payment', 0);
                                            } else {
                                              sharedPrefs.setInt(
                                                  'pick_payment', 1);
                                            }
                                            break;
                                        }
                                        switch (widget.home_services) {
                                          case 0:
                                            sharedPrefs.setInt(
                                                '_picked_location', 0);
                                            break;
                                          case 1:
                                            sharedPrefs.setInt(
                                                '_picked_location', 1);
                                            break;
                                          case 2:
                                            if (_picked_location ==
                                                AppLocalization.of(context)
                                                    .translate('in_center')) {
                                              sharedPrefs.setInt(
                                                  '_picked_location', 0);
                                            } else {
                                              sharedPrefs.setInt(
                                                  '_picked_location', 1);
                                            }
                                            break;
                                        }
                                        //contain list of services chossed by users
                                        List<String> mList =
                                            (sharedPrefs.getStringList(
                                                    'book_service_id') ??
                                                List<String>());
                                        //convert your string list to your original int list
                                        List<int> services_ids = mList
                                            .map((i) => int.parse(i))
                                            .toList();

                                        //contain list of number of users for every service
                                        List<String> usersList =
                                            (sharedPrefs.getStringList(
                                                    'book_users_number') ??
                                                List<String>());
                                        //convert your string list to your original int list
                                        List<int> users_number = usersList
                                            .map((i) => int.parse(i))
                                            .toList();
                                        await ApiProvider.bookSalonFunc(
                                            widget.token,
                                            widget.salon_id,
                                            (sharedPrefs.getInt(
                                                        'mukap_artist_id') ==
                                                    null)
                                                ? 0
                                                : sharedPrefs
                                                    .getInt('mukap_artist_id'),
                                            sharedPrefs
                                                .getInt('_picked_location'),
                                            sharedPrefs.getInt('pick_payment'),
                                            sharedPrefs.getString('date'),
                                            sharedPrefs.getString('time'),
                                            sharedPrefs.getInt('user_id'),
                                            (services_ids == null)
                                                ? null
                                                : services_ids,
                                            users_number,
                                            sharedPrefs.getInt('catogery_id'),
                                            sharedPrefs.getString('home_lat'),
                                            sharedPrefs.getString('home_lang'),
                                            sharedPrefs
                                                .getString('home-address'),
                                            context);

                                        progressDialog.hide();
                                        if (StaticMethods.booking_status) {
                                          removeReservaationData();
                                        } else {
                                          errorDialog(
                                              context: context,
                                              text:
                                                  '${StaticMethods.booking_message}',
                                              function: () {
                                                Navigator.pop(context);
                                              });
                                        }
                                      },
                                    ),
                                  )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
        ));
  }

  Map<MarkerId, Marker> markers =
      <MarkerId, Marker>{}; // CLASS MEMBER, MAP OF MARKS

  void _add(LatLng latLng, String address) {
    final MarkerId markerId = MarkerId('ssdd');
    // creating a new MARKER
    final Marker marker = Marker(
      markerId: MarkerId(address),
      infoWindow: InfoWindow(
        title: address,
      ),
      position: LatLng(
        latLng.latitude,
        latLng.longitude,
      ),
      onTap: () {},
    );

    setState(() {
      // adding a new marker to map
      markers[markerId] = marker;
    });
  }

  void removeReservaationData() {
    sharedPrefs.remove('mukap_artist_id');
    sharedPrefs.remove('_picked_location');
    sharedPrefs.remove('pick_payment');
    sharedPrefs.remove('date');
    sharedPrefs.remove('time');
    sharedPrefs.remove('catogery_id');
    sharedPrefs.remove('book_service_id');
    sharedPrefs.remove('book_users_number');
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2020, 1),
        lastDate: DateTime(2050));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        date = "${selectedDate.toLocal()}".split(' ')[0];
        date_hint = intl.DateFormat('EEEE').format(selectedDate);
        ('date_hint : $date');
        ('date_day : $date_hint');
      });
  }
}
