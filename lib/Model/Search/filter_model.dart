
  class FilterModel {

  int id;
  String name;
  String Latitude;
  String Longitude;
  String logo;
  String address;
  int payment;
  int home_service;
  String tax;
  int check_value;
  TotalRate total_rate;
  List<Service> services;
  List<Galleries> gallery;

  FilterModel({this.id, this.name, this.Latitude, this.Longitude, this.logo, this.address, this.home_service,
  this.payment, this.tax, this.check_value,this.total_rate,this.gallery});


  factory FilterModel.fromJson(Map<String,dynamic> json){
    var gallerylist = json['gallery'] as List;
    List<Galleries> galleries_list = gallerylist.map((i)=>Galleries.fromJson(i)).toList();
  return FilterModel(
  id : json['id'],
  name : json['name'],
  check_value: json['check_value'],
  Latitude : json['Latitude'],
  Longitude : json['Longitude'],
  logo : json['logo'],
  address : json['address'],
  home_service :  json['home_service'],
  payment : json['payment'],
  tax : json['tax'],
  total_rate : TotalRate.fromJson(json['total_rate']),
  gallery: galleries_list
  );
  }

  Map<String,dynamic> toJson(){
  final Map<String,dynamic> data = new Map<String,dynamic>();
  data['id'] = this.id;
  data['name'] = this.name;
  data['check_value']=this.check_value;
  data['Latitude'] = this.Latitude;
  data['Longitude'] = this.Longitude;
  data['logo'] = this.logo;
  data['address'] = this.address;
  data['home_service'] = this.home_service;
  data['payment'] = this.payment;
  data['tax'] = this.tax;
  data['total_rate'] = this.total_rate;
  return data;

  }

  }

  class TotalRate{
  int value;
  TotalRate({this.value});

  factory TotalRate.fromJson(Map<String,dynamic> parsedJson){
  return TotalRate(
  value: parsedJson['value'],
  );
  }
  }

  class Service {
  int id;
  String name;
  String details;
  String icon;
  String bonus;
  String estimated_time;
  int booking_before;
  int home_service;
  int price;
  int payment;
  int category_id;

  Service({this.id,this.name,this.details,this.icon,this.bonus,this.estimated_time,
  this.booking_before,this.home_service,this.price,this.payment,this.category_id});

  factory Service.fromJson(Map<String,dynamic> parsedJson){
  return Service(
  id: parsedJson['id'],
  name: parsedJson['name'],
  details: parsedJson['details'],
  icon: parsedJson['icon'],
  bonus: parsedJson['bonus'],
  estimated_time: parsedJson['estimated_time'],
  booking_before: parsedJson['booking_before'],
  home_service: parsedJson['home_service'],
  price: parsedJson['price'],
  payment: parsedJson['payment'],
  category_id: parsedJson['category_id']
  );
  }

  }

  class Galleries{
  final int id;
  final int salon_id;
  final String photo;
  Galleries({this.id,this.salon_id,this.photo});
  factory Galleries.fromJson(Map<String,dynamic> parsedJson){
  return Galleries(
  id: parsedJson['id'],
  salon_id: parsedJson['salon_id'],
  photo: parsedJson['photo'],

  );
  }
  }
