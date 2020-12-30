import 'package:flutter/material.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';

class SearchByLocationModel{
  final String name;
  final String Longitude;
  final String Latitude;
  final double distance;
  final int id;
  final String logo;
  final String address;
  SearchByLocationModel({this.name,this.Longitude,this.Latitude,this.distance, this.id, this.address, this.logo});

  factory SearchByLocationModel.fromJson(Map<String,dynamic>json){
    return SearchByLocationModel(
      name: json['name'],
      Longitude: json['Longitude'],
      Latitude: json['Latitude'],
      distance: json['distance'],
      id: json['id'],
      logo: json['logo'],
      address: json['address'],
    );
  }

  static Map<String, dynamic> toMap(SearchByLocationModel salon) => {
    'name': salon.name,
    'Longitude': salon.Longitude,
    'Latitude': salon.Latitude,
    'distance': salon.distance,
    'id': salon.id,
    'logo': salon.logo,
    'address': salon.address,
  };

  static String encodeSalons(List<SearchByLocationModel> salons) => json.encode(
    salons.map<Map<String, dynamic>>((obj) => SearchByLocationModel.toMap(obj))
        .toList(),
  );

  static List<SearchByLocationModel> decodeSalons(String salons) =>
      (json.decode(salons) as List<dynamic>)
          .map<SearchByLocationModel>((item) => SearchByLocationModel.fromJson(item))
          .toList();


}