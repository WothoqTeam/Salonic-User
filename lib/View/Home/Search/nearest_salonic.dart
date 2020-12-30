
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';
import 'package:salonic/Model/Search/search_by_location_model.dart';

class NearestSalonic extends StatefulWidget {
  final String token;
  final int map_details_route;
  NearestSalonic({this.token,this.map_details_route});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NearestSalonic_State();
  }
}

class NearestSalonic_State extends State<NearestSalonic> {
  SharedPreferences sharedPrefs;
  GoogleMapController mapController;
  final LatLng _center = const LatLng(24.774265, 46.738586);
  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  List<Marker> _markers;
  Future<List<SearchByLocationModel>> nearest_listOfSalons;

  final Location location = Location();

  LocationData _location;
  String _error;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ('--1--');
    getApiData();
    ('--2--');
    _markers = <Marker>[];
    ('--3--');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nearest_listOfSalons = null;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      child: WillPopScope(
        onWillPop: (){
          Navigator
              .pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>HomePage(
                    token: (widget.token == StaticMethods.vistor_token)
                        ? StaticMethods.vistor_token
                        : widget.token,
                  )));
        },
        child: Scaffold(
          appBar:  AppBar(
            automaticallyImplyLeading: false,
            title: Padding(
                padding: EdgeInsets.only(right: 5, left: 5, top: 10),
                child: SearchClass(
                  token: (widget.token == StaticMethods.vistor_token)
                      ? StaticMethods.vistor_token
                      : widget.token,
                  map: true,
                )),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
            backgroundColor:  AppColor.primary_color,
            elevation: 5.0,
            bottom: PreferredSize(
                child: Container(), preferredSize: Size.fromHeight(15.0)),
          ),
          body: FutureBuilder<List<SearchByLocationModel>>(
            future: nearest_listOfSalons,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  ('nearest : ${snapshot.data}');
                  salons_data(snapshot.data);
                  return Padding(
                    padding: EdgeInsets.all(0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: GoogleMap(
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        onMapCreated: _onMapCreated,
                        markers: Set<Marker>.of(_markers),
                        initialCameraPosition: CameraPosition(
                          target: _center,
                          zoom: 11.0,
                        ),
                      ),
                    ),
                  );
                } else {}
              }
              return Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(AppColor.primary_color),
                ),
              );
            },
          ),
        ),
      ),
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
    );
  }

  void salons_data(List<SearchByLocationModel> nearest_salons_list) {
    nearest_salons_list.forEach((f) {
      double lat =
          double.parse((f.Latitude.isEmpty) ? '25.9616242' : f.Latitude);
      double lng =
          double.parse((f.Longitude.isEmpty) ? '44.7585477' : f.Longitude);
      _markers.add(Marker(

          markerId: MarkerId(f.name),
          position: LatLng(lat, lng),
          onTap: () {
            bottomSheetWidget(f);
          }));
    });
  }

  Future<void> _getLocation() async {
    setState(() {
      _error = null;
    });
    try {
      await location.requestService();
      final LocationData _locationResult = await location.getLocation();
      setState(() {
        _location = _locationResult;
      });
    } catch (err) {
      setState(() {
        _error = err.code;
      });
    }
  }

  Future<void> getApiData() async {
    await _getLocation();
    nearest_listOfSalons = ApiProvider.getNearestSalons(
        (widget.token == StaticMethods.vistor_token)
            ? StaticMethods.vistor_token
            : widget.token,
        _location.longitude,
        _location.latitude,
        context);
    ('nearest_listOfSalons : ${nearest_listOfSalons}');
  }

  void bottomSheetWidget(SearchByLocationModel f) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return  Container(
              height: MediaQuery.of(context).size.width / 1.5,
              color: Color(0xFFF6F6F6),
              child: Padding(
                padding: EdgeInsets.only(top: 20),
                child:Directionality(
                  textDirection: AppLocalization.of(context).locale.languageCode == 'en'
                      ? TextDirection.ltr
                      : TextDirection.rtl,
                  child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Image.network(
                                '${f.logo}',
                                height: MediaQuery.of(context).size.width / 4,
                                fit: BoxFit.fill,
                              )),
                        ),
                        Expanded(
                          flex: 3,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, bottom: 5),
                                  child: Text(
                                    f.name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, bottom: 5),
                                  child: Text(
                                    '${f.address}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 10, right: 10, bottom: 5),
                                  child:Directionality(
                                    textDirection: AppLocalization.of(context).locale.languageCode == 'en'
                                        ? TextDirection.ltr
                                        : TextDirection.rtl,
                                    child: Row(
                                    children: [
                                      Text(
                                        '${AppLocalization.of(context).translate('dist')} : ',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${f.distance.toStringAsFixed(2)}  ${AppLocalization.of(context).translate('km')}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),)
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: new Container(
                          padding: EdgeInsets.only(top: 15.0),
                          alignment: Alignment.center,
                          child: ButtonTheme(
                            minWidth: MediaQuery.of(context).size.width / 2,
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
                                AppLocalization.of(context).translate('go_salon'),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontFamily: AqarFont.font_family,
                                    fontWeight: FontWeight.normal),
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SalonicList(
                                          token: widget.token,
                                          salon_id: f.id,
                                          route: 1,
                                        )));
                              },
                            ),
                          )),
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
}
