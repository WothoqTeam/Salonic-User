class MukapArtistModel {
  final int id;
  final String name;
  MukapArtistModel({this.id,this.name});
  factory MukapArtistModel.fromJson(Map<String,dynamic> json){
    return MukapArtistModel(
      id: json['id'],
      name: json['name']
    );
  }
}