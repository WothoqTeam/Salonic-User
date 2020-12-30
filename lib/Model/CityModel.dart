class CityModel {
  final int id;
  final String name;
  final String location;
  CityModel({this.id,this.name,this.location});

  factory CityModel.fromJson(Map<String,dynamic>json){
    return CityModel(
      id: json['id'],
      name: json['name'],
      location: json['location']
    );
  }
}