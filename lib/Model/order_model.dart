import 'package:flutter/foundation.dart';

class OrderModel{
   var id;
   var salon_id;
   var employee_id;
   var address;
   var type;
   var payment;
   var date;
   var time;
   var status;
   var user_id;
   var total_cost;
   var cost;
   var cartTotal;
   var total_bonus;
  Salon salon;
  List<Service> services;
  Employee employee;

  OrderModel({this.id,this.salon_id,this.employee_id,this.address,this.type,this.payment,
    this.date,this.time,this.status,this.user_id,this.total_cost,this.cost,
      this.total_bonus,this.salon,this.services,this.employee,this.cartTotal});

  factory OrderModel.fromJson(Map<String,dynamic> json){
    var list = json['services'] as List;
    List<Service> servicelist = list.map((i)=>Service.fromJson(i)).toList();
    return OrderModel(
      id: json['id'],
      salon_id: json['salon_id'],
      employee_id: json['employee_id'],
      address: json['address'],
      type: json['type'],
      payment: json['payment'],
      date: json['date'],
      time: json['time'],
      status: json['status'],
      user_id: json['user_id'],
      total_cost: json['total_cost'],
      cost: json['cost'],
      cartTotal: (json['cartTotal']==null)?0:json['cartTotal'],
      total_bonus: json['total_bonus'],
      salon: Salon.fromJson(json['salon']),
      employee: Employee.fromJson(json['employee']),
      services: servicelist,
    );
  }


}

class Salon{
  final int id;
  final String name;
  final String logo;
  final String address;
  final String Latitude;
  final String Longitude;
  final int city_id;
  City city;

  Salon({this.id,this.name,this.logo,this.address,this.Longitude,this.Latitude,
    this.city_id,this.city});

  factory Salon.fromJson(Map<String,dynamic>json){
    return Salon(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
      address: json['address'],
      Latitude: json['Latitude'],
      Longitude: json['Longitude'],
      city_id: json['city_id'],
      city: City.fromJson(json['city'])
    );
  }
}

class City{
  final int id;
  final String name;
  City({this.id,this.name});
  factory City.fromJson(Map<String,dynamic> json){
    return City(
      id: json['id'],
      name: json['name'],
    );
  }
}

class Service{
  final int service_id;
  final int person_num;
  final String name;
   var price;
  Service({this.service_id, this.person_num, this.name,this.price});
  factory Service.fromJson(Map<String,dynamic> json){
    return Service(
      service_id: json['service_id'],
      person_num: json['person_num'],
      name: json['name'],
      price: json['price'],
    );
  }
}

class Employee{
  final int id;
  final String name;
  Employee({this.id,this.name});
  factory Employee.fromJson(Map<String,dynamic> json){
    if(json==null){
      return null;
    }else{
      return Employee(
        id: json['id'],
        name: json['name'],
      );
    }

  }
}