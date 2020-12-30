
class BookServiceModel{
  final int id;
  final String name;
  final String icon;
  final int price;
  final int home_service;

  BookServiceModel({this.id, this.name, this.icon, this.price, this.home_service});

  factory BookServiceModel.fromJson(Map<String,dynamic> json){
    return BookServiceModel(
      id:json['id'],
      name: json['name'],
      icon: json['icon'],
      home_service: json['home_service'],
      price: json['price'],

    );
  }
}