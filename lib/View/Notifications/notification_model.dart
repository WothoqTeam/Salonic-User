import 'package:salonic/Custom_Widgets/export_file.dart';

class NotificationModel{
  int id;
  int sender_salon_id;
  String title;
  String time;
  String message;
  Salons salon;
NotificationModel({this.id,this.sender_salon_id,this.title, this.time,this.message,this.salon});

factory NotificationModel.fromJson(Map<String, dynamic> json){
  return NotificationModel(
    id: json['id'],
    sender_salon_id: json['sender_salon_id'],
    title: json['title'],
    time: json['time'],
    message: json['message'],
    salon : Salons.fromJson(json['salon']),
  );
}


}

class Salons{
  int id;
  String name;

  Salons({this.id,this.name});

  factory Salons.fromJson(Map<String,dynamic> parsedJson){
    if (parsedJson == null) {} else {
      return Salons(
        id: parsedJson['id'],
        name: parsedJson['name'],

      );
    }
  }
}
