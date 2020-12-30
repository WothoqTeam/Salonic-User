import 'package:salonic/Custom_Widgets/export_file.dart';
import 'package:salonic/Model/Booking/book_service_model.dart';
import 'package:salonic/Model/Search/SearchSalonModel.dart';
import 'package:salonic/Model/Search/search_by_location_model.dart';
import 'package:salonic/Model/Booking/service_type_model.dart';
import '../Model/Booking/mukap_artist_model.dart';

class StaticMethods{
 static Future<List<BookServiceModel>> bookServiceList;
 static Future<List<MukapArtistModel>> mukapArtistList;
 static Future<List<SalonDetailsModel>> search_salons_list;
 static Future<List<ServiceModel>> serviceList;
 static bool removeFavourite_status =false;


 static String vistor_token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wvc2Fsb25pYy53b3Rob3EuY29cL2FwaVwvdXNlcnNcL2xvZ2luIiwiaWF0IjoxNTk5NjUwNzcwLCJuYmYiOjE1OTk2NTA3NzAsImp0aSI6IjJ5TGxwSVJDbmdWdTdMNzUiLCJzdWIiOjIsInBydiI6Ijg3ZTBhZjFlZjlmZDE1ODEyZmRlYzk3MTUzYTE0ZTBiMDQ3NTQ2YWEifQ.PCldtFTsJ2J85JhUBQfrHEFzPspQtUEq7c1P2tJFZgA';

  static int customer_care_value =0;

  //booking service process
  static bool booking_status=false;
  static String booking_message ='';


}