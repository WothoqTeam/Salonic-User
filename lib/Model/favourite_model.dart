class FavouriteModel {
  int id;
  int user_id;
  int salon_id;
  Salons salons;

  FavouriteModel({this.id,this.user_id,this.salon_id,this.salons});
  factory FavouriteModel.fromJson(Map<String,dynamic> json){
    return FavouriteModel(
      id: json['id'],
      user_id: json['user_id'],
      salon_id: json['salon_id'],
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
  List<Gallery> gallery;
  Salons({this.id,this.name,this.address,this.total_rate,this.city,this.gallery});

  factory Salons.fromJson(Map<String,dynamic> parsedJson){
    var list =parsedJson['gallery'] as List;
    List<Gallery> galleryList =list.map((i)=>Gallery.fromJson(i)).toList();
    return Salons(
      id: parsedJson['id'],
      name: parsedJson['name'],
      address: parsedJson['address'],
      total_rate: TotalRate.fromJson(parsedJson['total_rate']),
      city: City.fromJson(parsedJson['city']),
      gallery: galleryList
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

class Gallery {
  String photo;
  Gallery({this.photo});
  factory Gallery.fromJson(Map<String,dynamic> parsedJson){
    return Gallery(
      photo: parsedJson['photo'],
    );
  }
}