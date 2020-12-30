class SalonModel{
  final int id;
  final String name;

  SalonModel({this.id,this.name});

  factory SalonModel.fromJson(Map<String,dynamic>json){
    return SalonModel(
        id: json['id'],
        name: json['name'],
    );
  }
}

