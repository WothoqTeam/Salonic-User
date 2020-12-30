class AdvancedSearchSalonModel{
  final int id;
  final String name;
  final String username;
  final String email;
  final int home_service;
  final int payment;
  final String Latitude;
  final String Longitude;
  final int booking;
  final String logo;
  final String tax;
  final String address;
  final int services_count;
  final int total_rate_count;
  List<Service> services;
  TotalRate total_rate;
  AdvancedSearchSalonModel({this.id,this.name,this.username,this.email,this.home_service,this.payment,
  this.Latitude,this.Longitude,this.booking,this.logo,this.tax,this.address,this.services_count,
    this.total_rate_count,this.services,this.total_rate});

  factory AdvancedSearchSalonModel.fromJson(Map<String,dynamic>json){
    var list =json['services']as List;
    List<Service>serviceList = list.map((f)=>Service.fromJson(f)).toList();
    return AdvancedSearchSalonModel(
        id : json['id'],
        name : json['name'],
        Latitude : json['Latitude'],
        Longitude : json['Longitude'],
        logo : json['logo'],
        address : json['address'],
        home_service :  json['home_service'],
        payment : json['payment'],
        tax : json['tax'],
        total_rate : TotalRate.fromJson(json['total_rate']),
        services: serviceList,

    );
  }

}


class Service{
  final int id;
  final String name;
  Service({this.id,this.name});
  factory Service.fromJson(Map<String,dynamic> json){
    return Service(
      id: json['id'],
      name: json['name'],
    );
  }
}

class TotalRate{
  int id;
  int salon_id;
  int value;
  TotalRate({this.id,this.salon_id,this.value});

  factory TotalRate.fromJson(Map<String,dynamic> parsedJson){
    return TotalRate(
      id: parsedJson['id'],
      salon_id: parsedJson['salon_id'],
      value: parsedJson['value'],
    );
  }
}
