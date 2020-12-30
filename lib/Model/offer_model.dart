class OfferModel{
  String title;
  int salon_id;
  int service_id;
  String discount;
  String banner;
  Salons salons;
  OfferModel({this.title,this.salon_id,this.service_id,this.discount,this.banner,this.salons});

  factory OfferModel.fromJson(Map<String,dynamic> json){
    return OfferModel(
      title: json['title'],
      salon_id: json['salon_id'],
      service_id: json['service_id'],
      discount: json['discount'],
      banner: json['banner'],
      salons: Salons.fromJson(json['salons']),
    );
  }

}


class Salons{
  int id;
  String name;
  String address;
  TotalRate total_rate;
  City city;

  Salons({this.id,this.name,this.address,this.total_rate,this.city});

  factory Salons.fromJson(Map<String,dynamic> parsedJson){

    return Salons(
        id: parsedJson['id'],
        name: parsedJson['name'],
        address: parsedJson['address'],
        total_rate: TotalRate.fromJson(parsedJson['total_rate']),
        city: City.fromJson(parsedJson['city']),

    );
  }
}

class TotalRate{
  int value;
  TotalRate({this.value});

  factory TotalRate.fromJson(Map<String,dynamic> parsedJson){
    if(parsedJson==null){

    }else{
      return TotalRate(
        value: parsedJson['value'],
      );
    }
  }
}

class City{
  String name;
  City({this.name});
  factory City.fromJson(Map<String,dynamic> parsedJson){
    return City(
      name: parsedJson['name'],
    );
  }
}
