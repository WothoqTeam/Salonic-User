class CategoryModel {
  int id;
  String name;
  String icon;
  CategoryModel({this.id, this.name, this.icon,});

  factory CategoryModel.fromJson(Map<String, dynamic> json){
    if(json==null){
    }else{
      return CategoryModel(
        id: json['id'],
        name: json['name'],
        icon: json['icon'],
      );
    }

  }

  Map<String,dynamic> toJson(){
    final Map<String,dynamic> data=new Map<String,dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['icon'] = this.icon;
    return data;

  }
}