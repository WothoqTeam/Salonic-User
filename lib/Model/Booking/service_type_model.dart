class ServiceTypeModel {
  final int id;
  List<Category> categories;
  ServiceTypeModel({this.id,this.categories});

  factory ServiceTypeModel.fromJson(Map<String,dynamic> json){
    var list = json['categories'] as List;
    List<Category> categorieslist = list.map((i)=>Category.fromJson(i)).toList();
    return ServiceTypeModel(
      id: json['id'],
      categories: categorieslist,
    );
  }

}
class Category{
  final int id;
  final String name;
  final String icon;
  Category({this.id,this.name,this.icon});

  factory Category.fromJson(Map<String,dynamic>parsedJson){
    return Category(
      id: parsedJson['id'],
      name: parsedJson['name'],
      icon: parsedJson['icon'],
    );
  }
}