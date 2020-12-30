class SocialModel{
  final int id;
  final String name;
  final String logo;
  final String link;
  SocialModel({this.id,this.name,this.logo,this.link});

  factory SocialModel.fromJson(Map<String , dynamic> json){
    return SocialModel(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      link: json['link'],
    );
  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data =new Map<String,dynamic>();
    data['id']=this.id;
    data['name']=this.name;
    data['logo']=this.logo;
    data['link']=this.link;
    return data;
  }
}