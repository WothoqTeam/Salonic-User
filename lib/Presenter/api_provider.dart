import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salonic/Custom_Widgets/export_file.dart';
import 'package:salonic/Model/Booking/book_service_model.dart';
import 'package:salonic/Model/Booking/mukap_artist_model.dart';
import 'package:salonic/Model/Booking/service_type_model.dart';
import 'package:salonic/Model/Search/SearchSalonModel.dart';
import 'package:salonic/Model/Search/advanced_search_salon_model.dart';
import 'package:salonic/Model/Search/filter_model.dart';
import 'package:salonic/Model/Search/invoice_search_model.dart';
import 'package:salonic/Model/Search/search_by_location_model.dart';
import 'package:salonic/Model/card_model.dart';
import 'package:salonic/Model/invoices_model.dart';
import 'package:salonic/Model/customer_services_model.dart';

import 'package:salonic/Model/order_model.dart';

import 'package:salonic/Model/favourite_model.dart';
import 'package:salonic/Model/offer_model.dart';
import 'package:salonic/Presenter/static_methods.dart';
import 'package:salonic/View/More/mycards.dart';
import 'package:salonic/View/Notifications/notification_model.dart';
import 'package:salonic/View/Orders/payment_response.dart';
import 'package:salonic/View/Orders/payment_web_view.dart';

class ApiProvider {
  static final String APP_URL = 'https://salonic.wothoq.co/api/';

//.............................. as a user I want to sign out ..................................
  static sigOut(String token, BuildContext context) async {
    String signOut_Url = APP_URL + 'users/logout';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Dio dio = new Dio();
    try {
      FormData formData = FormData.fromMap({
        'token': '${token}',
      });
      final response = await dio.post(signOut_Url, data: formData);
      if (response.data['status'] == true) {
        Navigator.pop(context);
        sharedPreferences.remove('user_access_token');
        sharedPreferences.remove('user_id');
        sharedPreferences.remove('user_email');
        sharedPreferences.remove('user_mobile');
        sharedPreferences.remove('user_name');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => UserSignIn()));
      } else {
        errorDialog(context: context, text: response.data['msg']);
      }
    } catch (e) {
      errorDialog(context: context, text: e.toString());
    }
  }

//............................. as a user I want to see list of services icon .............................

  //--------------- Categories -------------------------

  static Future<List<CategoryModel>> getsSalonCategoriesList(
      String token, BuildContext context) async {
    String serviceList_Url = APP_URL + "admin/salons/get-InSalon-Category";
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
      });
      final response = await dio.post(serviceList_Url, data: _formData);
      if (response.data['status']) {
        final jsonResponse = response.data['categories'];
        List<CategoryModel> temp = (jsonResponse as List)
            .map((itemWord) => CategoryModel.fromJson(itemWord))
            .toList();
        List<CategoryModel> templist = new List<CategoryModel>();
            temp.forEach((element) {
          if (element == null) {
          } else {
            templist.add(element);
          }
        });
        return templist;
      } else {
        errorDialog(context: context, text: response.data['msg']);
      }
    } catch (e) {
      errorDialog(context: context, text: e.toString());
    }
  }

  static Future<List<CategoryModel>> getHomeCategoriesList(
      String token, BuildContext context) async {
    String serviceList_Url = APP_URL + "admin/salons/get-InHome-Category";
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
      });
      final response = await dio.post(serviceList_Url, data: _formData);
      if (response.data['status']) {
        final jsonResponse = response.data['categories'];
        List<CategoryModel> temp = (jsonResponse as List)
            .map((itemWord) => CategoryModel.fromJson(itemWord))
            .toList();
        List<CategoryModel> templist = new List<CategoryModel>();
        temp.forEach((element) {
          if (element == null) {
          } else {
            templist.add(element);
          }
        });
        return templist;
      } else {
        errorDialog(context: context, text: response.data['msg']);
      }
    } catch (e) {
      errorDialog(context: context, text: e.toString());
    }
  }

  static Future<List<CategoryModel>> getAllCategoriesList(
      String token, BuildContext context) async {
    String serviceList_Url = APP_URL + "admin/salons/get-all-category";
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
      });
      final response = await dio.post(serviceList_Url, data: _formData);
      if (response.data['status']) {
        final jsonResponse = response.data['categories'];
        List<CategoryModel> temp = (jsonResponse as List)
            .map((itemWord) => CategoryModel.fromJson(itemWord))
            .toList();
        List<CategoryModel> templist = new List<CategoryModel>();
        temp.forEach((element) {
          if (element == null) {
          } else {
            templist.add(element);
          }
        });
        return templist;
      } else {
        errorDialog(context: context, text: response.data['msg']);
      }
    } catch (e) {
      errorDialog(context: context, text: e.toString());
    }
  }

  static Future<List<ServiceModel>> allServiceList(
      String token, BuildContext context) async {
    String serviceList_Url = APP_URL + "admin/services/get-all-services";
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
      });
      final response = await dio.post(serviceList_Url, data: _formData);
      if (response.data['status']) {
        final jsonResponse = response.data['services'];
        List<ServiceModel> temp = (jsonResponse as List)
            .map((itemWord) => ServiceModel.fromJson(itemWord))
            .toList();
        return temp;
      } else {
        errorDialog(context: context, text: response.data['msg']);
      }
    } catch (e) {
      errorDialog(context: context, text: e.toString());
    }
  }

//--------------------------------------
  static Future<List<ServiceModel>> getAppointmentServiceList(String token, int home_service, BuildContext context) async {
    String serviceList_Url = APP_URL + "services/servicesIconList";
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'home_service': '${home_service}',
      });
      final response = await dio.post(serviceList_Url, data: _formData);
      if (response.data['status']) {
        final jsonResponse = response.data['services'];
        if (jsonResponse == null) {
          return null;
        } else {
          List<ServiceModel> temp = (jsonResponse as List)
              .map((itemWord) => ServiceModel.fromJson(itemWord))
              .toList();
          List<ServiceModel> appointment_service = new List<ServiceModel>();
          temp.forEach((f) {
            if (f.home_service == 0) {
              appointment_service.add(f);
            }
          });
          return appointment_service;
        }
      } else {
        errorDialog(context: context, text: response.data['msg']);
      }
    } catch (e) {
      errorDialog(context: context, text: e.toString());
    }
  }

  static Future<List<ServiceModel>> getHomeServiceList(String token, int home_service, BuildContext context) async {
    String serviceList_Url = APP_URL + "services/servicesIconList";
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'home_service': '${home_service}',
      });
      final response = await dio.post(serviceList_Url, data: _formData);
      if (response.data['status']) {
        final jsonResponse = response.data['services'];
        if (jsonResponse == null) {
          return null;
        } else {
          List<ServiceModel> temp = (jsonResponse as List)
              .map((itemWord) => ServiceModel.fromJson(itemWord))
              .toList();
          List<ServiceModel> appointment_service = new List<ServiceModel>();
          temp.forEach((f) {
            if (f.home_service == 1) {
              appointment_service.add(f);
            }
          });
          return appointment_service;
        }
      } else {
        errorDialog(context: context, text: response.data['msg']);
      }
    } catch (e) {
      errorDialog(context: context, text: e.toString());
    }
  }

  static Future<List<ServiceModel>> getAllServiceList(String token, int home_service, BuildContext context) async {
    String serviceList_Url = APP_URL + "services/servicesIconList";
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'home_service': '${home_service}',
      });
      final response = await dio.post(serviceList_Url, data: _formData);
      if (response.data['status']) {
        final jsonResponse = response.data['services'];
        if (jsonResponse == null) {
          return null;
        } else {
          List<ServiceModel> temp = (jsonResponse as List)
              .map((itemWord) => ServiceModel.fromJson(itemWord))
              .toList();
          List<ServiceModel> appointment_service = new List<ServiceModel>();
          temp.forEach((f) {
            if (f.home_service == 2) {
              appointment_service.add(f);
            }
          });
          return appointment_service;
        }
      } else {
        errorDialog(context: context, text: response.data['msg']);
      }
    } catch (e) {
      errorDialog(context: context, text: e.toString());
    }
  }

  // ------------------------ as a user I want to see list of salonic .......................

  static Future<List<SalonDetailsModel>> getAllSalons(
      String token, BuildContext context) async {
    ('getAllSalons 1');
    String SalonList_Url = APP_URL + 'admin/salons/get-salon-rate-list';
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
      });
      ('getAllSalons 2');
      final response = await dio.post(SalonList_Url, data: _formData);
      ('getAllSalons 3');
      ('getAllSalons response : ${response}');

      if (response.data['status']) {
        ('getAllSalons 4');

        final jsonResponse = response.data['salons'];
        ('getAllSalons 5');
        List<SalonDetailsModel> temp = (jsonResponse as List)
            .map((itemWord) => SalonDetailsModel.fromJson(itemWord))
            .toList();
        ('getAllSalons 6');

        return temp;
      } else {
        ('getAllSalons 7');
        errorDialog(context: context, text: response.data['msg']);
      }
    } catch (e) {
      ('getAllSalons 8');
      errorDialog(context: context, text: e.toString());
    }
  }

  static Future<List<SalonDetailsModel>> getAllSalonsByService_id(
      String token, int service_id, BuildContext context) async {
    (111111);
    String SalonList_Url = APP_URL + 'admin/salons/get-salon-rate-list';
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
      });
      (111112);
      final response = await dio.post(SalonList_Url, data: _formData);
      ('response : ${response}');
      if (response.data['status']) {
        (111113);
        final jsonResponse = response.data['salons'];
        (111114);
        List<SalonDetailsModel> temp = (jsonResponse as List)
            .map((itemWord) => SalonDetailsModel.fromJson(itemWord))
            .toList();
        (111115);
        List<SalonDetailsModel> salonsListByService =
            new List<SalonDetailsModel>();
        (111116);
        temp.forEach((obj) {
          List<int> salon_services_id = new List<int>();
          for (int i = 0; i < obj.services.length; i++) {
            salon_services_id.add(obj.services[i].id);
          }
          if (salon_services_id.contains(service_id)) {
            salonsListByService.add(obj);
          }
        });
        (111117);
        return salonsListByService;
      } else {
        (111118);
        errorDialog(context: context, text: response.data['msg']);
      }
    } catch (e) {
      (111119);
      errorDialog(context: context, text: e.toString());
    }
  }

  // ------------------------ as a user I want to have a list of Favorite Salonic .......................

  static Future<List<FavouriteModel>> getAllFavourits(
      String token, int user_id, BuildContext context) async {
    ('getAllFavourits 1');
    String Favourite_Url = APP_URL + 'admin/favorite/get-all-favorite';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Dio dio = new Dio();
    ('getAllFavourits 2');
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'user_id': '${user_id}',
      });
      ('getAllFavourits 3');
      final response = await dio.post(Favourite_Url, data: _formData);
      ('getAllFavourits response : ${response}');
      if (response.data['status']) {
        ('getAllFavourits 4');
        final jsonresponse = response.data['favorite_salons'];
        if (jsonresponse == null) {
          ('getAllFavourits 5');
          return null;
        } else {
          ('getAllFavourits 6');
          List<FavouriteModel> temp = (jsonresponse as List)
              .map((i) => FavouriteModel.fromJson(i))
              .toList();
          ('getAllFavourits 7');
          List<int> salon_ids_list = new List<int>();
          temp.forEach((i) {
            salon_ids_list.add(i.salons.id);
          });
          ('getAllFavourits 8');
          List<String> strList =
              salon_ids_list.map((i) => i.toString()).toList();
          ('strList : ${strList}');
          ('getAllFavourits 9');
          sharedPreferences.setStringList('salon_list', strList);
          ('getAllFavourits 10');
          return temp;
        }
      } else {
        ('getAllFavourits 11');
        errorDialog(context: context, text: response.data['msg']);
      }
    } catch (e) {
      ('getAllFavourits 12');
      errorDialog(context: context, text: e.toString());
    }
  }

  static Future<void> removeSalonFromFavourite(
      String token, int salon_id, int user_id, BuildContext context) async {
    String RemoveFromFavourite_Url = APP_URL + 'admin/favorite/destroy';
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'salon_id': '${salon_id}',
        'user_id': '${user_id}',
      });
      final response = await dio.post(RemoveFromFavourite_Url, data: _formData);
      if (response.data['status']) {
        StaticMethods.removeFavourite_status = true;
        errorDialog(context: context, text: response.data['errNum']);
      } else {
        errorDialog(context: context, text: response.data['errNum'].toString());
      }
    } catch (e) {
      errorDialog(context: context, text: e.toString());
    }
  }

  static Future<void> addSalonToFavourite(
      String token, int salon_id, int user_id, BuildContext context) async {
    String AddToFavourite_Url =
        'https://salonic.wothoq.co/api/admin/favorite/store';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'salon_id': '${salon_id}',
        'user_id': '${user_id}',
      });
      final response = await dio.post(AddToFavourite_Url, data: _formData);
      if (response.data['status']) {
        sharedPreferences.setBool('favourite_status', response.data['status']);
        errorDialog(context: context, text: 'تم اضافة الصالون الى المفضلة');
      } else {
        sharedPreferences.setBool('favourite_status', response.data['status']);
        errorDialog(context: context, text: response.data['msg'].toString());
      }
    } catch (e) {
      errorDialog(context: context, text: e.toString());
    }
  }

//------------------------- as a user I want to see list of offer ------------------------------------
  static Future<List<OfferModel>> getOfferList(
      String token, BuildContext context) async {
    String OfferList_Url = APP_URL + 'admin/offers/getOfferList';
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
      });
      final response = await dio.post(OfferList_Url, data: _formData);
      ('offer response : ${response}');

      if (response.data['status'] == true) {
        final jsonresponse = response.data['offers'];
        if (jsonresponse == null) {
          ('offer - 7');
          return null;
        } else {
          ('offer - 8');
          List<OfferModel> temp = (jsonresponse as List)
              .map((i) => OfferModel.fromJson(i))
              .toList();
          ('offer temp : ${temp}');
          ('offer - 9');
          return temp;
        }
      } else {
        ('offer - 10');
        errorDialog(context: context, text: response.data['msg']);
      }
    } catch (e) {
      ('offer - 11');
      errorDialog(context: context, text: e.toString());
    }
  }

// ------------------------ as a user I want to see list of Social Media contact .......................
  static Future<List<SocialModel>> getSocialLinks(
      String token, BuildContext context) async {
    String OfferList_Url = APP_URL + 'admin/salons/get-app-social';
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
      });
      final response = await dio.post(OfferList_Url, data: _formData);
      if (response.data['status']) {
        final jsonresponse = response.data['social_media'];
        List<SocialModel> temp =
            (jsonresponse as List).map((i) => SocialModel.fromJson(i)).toList();

        return temp;
      } else {
        errorDialog(context: context, text: response.data['msg']);
      }
    } catch (e) {
      errorDialog(context: context, text: e.toString());
    }
  }

// ------------------------ as a user I want to send new ticket to support ...............................
  static Future<void> sendNewTicketToSupport(
      String token,
      String username,
      String email,
      String mobile,
      String details,
      int user_id,
      BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String SendTicket_Url = 'https://salonic.wothoq.co/api/admin/tickets/store';
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'username': '${username}',
        'email': '${email}',
        'mobile': '${mobile}',
        'details': '${details}',
        'user_id': '${user_id}',
      });
      final response = await dio.post(SendTicket_Url, data: _formData);
      if (response.data['status']) {
        StaticMethods.customer_care_value = 1;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CustomerServices(
                      token: sharedPreferences.getString('user_access_token'),
                      user_id: sharedPreferences.getInt(
                        'user_id',
                      ),
                      ticket_number: response.data['ticket']['ticket_num'],
                      ticket_details: response.data['ticket']['details'],
                    )));
      } else {
        errorDialog(context: context, text: response.data['msg'].toString());
      }
    } catch (e) {
      errorDialog(context: context, text: e.toString());
    }
  }

  static Future<CustomerServicesModel> getSupportTicket(
      String token, int user_id, BuildContext context) async {
    String Catogery_Url = APP_URL + 'admin/tickets/get-support-tickets';
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'user_id': '${user_id}',
      });
      final response = await dio.post(Catogery_Url, data: _formData);
      if (response.data['status']) {
        final jsonresponse = response.data['tickets'];
        if (jsonresponse == null) {
          return null;
        } else {
          CustomerServicesModel temp =
              CustomerServicesModel.fromJson(jsonresponse);
          return temp;
        }
      } else {
        errorDialog(context: context, text: response.data['msg']);
      }
    } catch (e) {
      errorDialog(context: context, text: e.toString());
    }
  }

  //........................... as a user I want to booking a salonic ....................................

  static Future<List<ServiceTypeModel>> getAllCategories(
      String token, int salon_id, BuildContext context) async {
    String Catogery_Url = APP_URL + 'admin/salons/get-salon-categories';
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'salon_id': '${salon_id}',
      });
      final response = await dio.post(Catogery_Url, data: _formData);
      if (response.data['status']) {
        final jsonresponse = response.data['salon-categories'];
        List<ServiceTypeModel> temp = (jsonresponse as List)
            .map((f) => ServiceTypeModel.fromJson(f))
            .toList();
        return temp;
      } else {
        errorDialog(context: context, text: response.data['msg']);
      }
    } catch (e) {

      errorDialog(context: context, text: e.toString());
    }
  }

  static Future<List<BookServiceModel>> getBookService(
      String token,
      int salon_id,
      int category_id,
      int home_service,
      BuildContext context) async {
    ('service-salon-id : ${salon_id}');
    ('service-category_id : ${category_id}');
    ('service-home_service: ${home_service}');
    String BookService_Url = APP_URL + 'admin/services/All-service-by-type';
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'salon_id': '${salon_id}',
        'category_id': '${category_id}',
        'home_service': '${home_service}'
      });
      final response = await dio.post(BookService_Url, data: _formData);
      ('service response : ${response}');
      if (response.data['status']) {
        final jsonresponse = response.data['services'];
        List<BookServiceModel> temp = (jsonresponse as List)
            .map((f) => BookServiceModel.fromJson(f))
            .toList();
        return temp;
      } else {
        return null;
      }
    } catch (e) {
      errorDialog(context: context, text: e.toString());
    }
  }

  static Future<List<MukapArtistModel>> getMukapArtistByService(
      String token, int salon_id, int service_id, BuildContext context) async {
    String Catogery_Url = APP_URL + 'admin/services/get-service-employee';
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'salon_id': '${salon_id}',
        'service_id': '${service_id}',
      });
      final response = await dio.post(Catogery_Url, data: _formData);
      if (response.data['status']) {
        final jsonresponse = response.data['employee'];
        List<MukapArtistModel> temp = (jsonresponse as List)
            .map((f) => MukapArtistModel.fromJson(f))
            .toList();
        return temp;
      } else {
        errorDialog(context: context, text: response.data['msg']);
      }
    } catch (e) {
      errorDialog(context: context, text: e.toString());
    }
  }

  static Future<void> bookSalonFunc(
      String token,
      int salon_id,
      int employee_id,
      int type,
      int payment,
      String date,
      String time,
      int user_id,
      List<int> services,
      List<int> people,
      int category_id,
      String lat,
      String long,
      String address,
      BuildContext context) async {
    ProgressDialog progressDialog =ProgressDialog(context);
    progressDialog.show();
    ('address122 : ${address}');
    ('------ time ------ : ${time}');
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    final String BookSalon_Url = APP_URL + 'admin/orders/store';
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'salon_id': '${salon_id}',
        'employee_id': '${employee_id}',
        'type': '${type}',
        'payment': '${payment}',
        'date': '${date}',
        'time': '${time}',
        'user_id': '${user_id}',
        'services': '${json.encode(services)}', //[services]
        'person_num': '${json.encode(people)}',
        'category_id': '${category_id}',
        'Longitude':'${lat}',
        'Latitude':'${long}',
        'address':'${address}',
      });
      ('booking 1');
      final response = await dio.post(BookSalon_Url, data: _formData);
      ('booking response : ${response}');
      if (response.data['status']) {
        StaticMethods.booking_status = response.data['status'];
        StaticMethods.booking_message = response.data['msg'];
        progressDialog.hide();
        Navigator.pop(context);
        errorDialog(
            context: context,
            text: ' يرجاء الانتقال إلى قائمة طلباتي',
            function: () {
              StaticMethods.bookServiceList = null;
              StaticMethods.mukapArtistList = null;
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => OrdersPage(
                        token: token,
                        user_id: sharedPrefs.getInt('user_id'),
                      )));

            });
      } else {
        Navigator.pop(context);
        progressDialog.hide();
        StaticMethods.booking_status = response.data['status'];
        StaticMethods.booking_message = response.data['msg'];
      }
    } catch (e) {
      Navigator.pop(context);
      progressDialog.hide();
      errorDialog(context: context, text: e.toString());
    }
  }

//........................... as a user I want to see list of my booking history (rating) ....................................

  static Future<List<OrderModel>> getReservationList(
      String token, int user_id, BuildContext context) async {
    String ReservationList_Url = APP_URL + 'admin/orders/bookingHistory';
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'user_id': '${user_id}',
      });
      final response = await dio.post(ReservationList_Url, data: _formData);
      if (response.data['status']) {
        final jsonresponse = response.data['orders'];
        if (jsonresponse == null) {
          return null;
        } else {
          List<OrderModel> temp = (jsonresponse as List)
              .map((f) => OrderModel.fromJson(f))
              .toList();
          return temp;
        }
      } else {
        errorDialog(context: context, text: response.data['msg']);
      }
    } catch (e) {

      errorDialog(context: context, text: e.toString());
    }
  }

  static Future<void> senRateForSalon(String token, int salon_id, int user_id,
      int value, String comment, BuildContext context) async {
    String SalonRate_Url = APP_URL + 'admin/rate/store';
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'salon_id': '${salon_id}',
        'user_id': '${user_id}',
        'value': '${value}',
        'comment': '${comment}',
      });
      final response = await dio.post(SalonRate_Url, data: _formData);
      if (response.data['status']) {
        errorDialog(context: context, text: 'تم التقييم بنجاح');
      } else {
        errorDialog(context: context, text: response.data['msg']);
      }
    } catch (e) {

      errorDialog(context: context, text: e.toString());
    }
  }

  static Future<void> senRateForEmployee(String token, int employee_id,
      int user_id, int value, String comment, BuildContext context) async {
    String SalonRate_Url = APP_URL + 'admin/employeeRate/store';
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'employee_id': '${employee_id}',
        'user_id': '${user_id}',
        'value': '${value}',
        'comment': '${comment}',
      });
      final response = await dio.post(SalonRate_Url, data: _formData);
      if (response.data['status']) {
        errorDialog(context: context, text: 'تم التقييم بنجاح');
      } else {
        errorDialog(context: context, text: response.data['msg']);
      }
    } catch (e) {

      errorDialog(context: context, text: e.toString());
    }
  }

  //------------------------- advanced search --------------------------

  static Future<List<CityModel>> getAllCities(
      String token, BuildContext context) async {
    String City_Url = APP_URL + 'admin/cities/getAllCities';
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({'token': '${token}'});
      final response = await dio.post(City_Url, data: _formData);
      if (response.data['status']) {
        final jsonresponse = response.data['cities'];
        List<CityModel> temp =
            (jsonresponse as List).map((f) => CityModel.fromJson(f)).toList();
        return temp;
      } else {
        errorDialog(context: context, text: response.data['msg']);
      }
    } catch (e) {

      errorDialog(context: context, text: e.toString());
    }
  }

  static Future<List<FilterModel>> getSalonsByAdvanceSearch(String token,
      int city_id, int service_id, int rate_value, BuildContext context) async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    String AdvanceSearch_Url =
        'https://salonic.wothoq.co/api/admin/search/salon-advanced-search';
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'city_id': '${city_id}',
        'service_id': '${service_id}',
        'rate_value': '${rate_value}',
      });
      final response = await dio.post(AdvanceSearch_Url, data: _formData);
      if (response.data['status']) {
        final jsonresponse = response.data['salons'];
        List<FilterModel> temp =
            (jsonresponse as List).map((f) => FilterModel.fromJson(f)).toList();
        return temp;
      } else {
        errorDialog(
            context: context,
            text: response.data['msg'],
            function: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AdvancedSearchPage(
                          token: (sharedPrefs.getString('user_access_token') ==
                                  null)
                              ? StaticMethods.vistor_token
                              : sharedPrefs.getString('user_access_token'))));
            });
      }
    } catch (e) {
      errorDialog(context: context, text: e.toString());
    }
  }

  static Future<List<SearchByLocationModel>> getNearestSalons(String token,
      double Longitude, double Latitude, BuildContext context) async {
    String NearestSalons_Url = APP_URL + 'admin/search/salon-place';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'Longitude': '${Longitude}',
        'Latitude': '${Latitude}',
      });
      final response = await dio.post(NearestSalons_Url, data: _formData);
      if (response.data['status']) {
        final jsonresponse = response.data['salons'];
        List<SearchByLocationModel> temp = (jsonresponse as List)
            .map((f) => SearchByLocationModel.fromJson(f))
            .toList();

        return temp;
      } else {
        errorDialog(context: context, text: response.data['msg']);
      }
    } catch (e) {
      errorDialog(context: context, text: e.toString());
    }
  }

  //i don't use it because i use getAllSalons methods
  static Future<List<SalonModel>> getSalonsByName(
      String token, String name, BuildContext context) async {
    String SalonsByName_Url = APP_URL + 'admin/search/salon-name';
    Dio dio = new Dio();
    try {
      FormData _formData =
          FormData.fromMap({'token': '${token}', 'name': '${name}'});
      final response = await dio.post(SalonsByName_Url, data: _formData);
      if (response.data['status']) {
        final jsonresponse = response.data['salons'];
        List<SalonModel> temp =
            (jsonresponse as List).map((f) => SalonModel.fromJson(f)).toList();

        return temp;
      } else {
        errorDialog(context: context, text: response.data['msg']);
      }
    } catch (e) {

      errorDialog(context: context, text: e.toString());
    }
  }

  //--------------------- as a user I want to have cart ----------------------

  static Future<List<OrderModel>> getOrdersList(
      String token, int user_id, BuildContext context) async {
    String Order_Url = APP_URL + 'admin/orders/user-cart';
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'user_id': '${user_id}',
      });
      final response = await dio.post(Order_Url, data: _formData);
      if (response.data['status']) {
        final jsonresponse = response.data['orders'];
        if (jsonresponse == null) {
          return null;
        } else {
          List<OrderModel> temp = (jsonresponse as List)
              .map((f) => OrderModel.fromJson(f))
              .toList();
          return temp;
        }
      } else {
        errorDialog(context: context, text: response.data['msg']);
      }
    } catch (e) {
      errorDialog(context: context, text: e.toString());
    }
  }

  static Future<void> cancelOrder(String token, int user_id, int order_id,
      status, BuildContext context) async {
    String CancelOrder_Url = APP_URL + 'admin/orders/change-order-status';
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'user_id': '${user_id}',
        'id': '${order_id}',
        'status': '${status}'
      });
      final response = await dio.post(CancelOrder_Url, data: _formData);
      if (response.data['status']) {
        //errorDialog(context: context,text: response.data['errNum']);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => OrdersPage(
                      token: token,
                      user_id: user_id,
                    )));
      } else {
        errorDialog(context: context, text: response.data['msg'].toString());
      }
    } catch (e) {

      errorDialog(context: context, text: e.toString());
    }
  }

//--------------------- as a user I want to see list of notification -----------------
  static Future<List<NotificationModel>> getUserNotifications(
      String token, int user_id, BuildContext context) async {
    String Notifications_Url = APP_URL + 'users/get-user-notifications';
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'user_id': '${user_id}',
      });
      final response = await dio.post(Notifications_Url, data: _formData);
      ('notification-response : ${response}');
      if (response.data['status']) {
        final jsonresponse = response.data['notifications'];
        ('-jsonresponse : ${jsonresponse}');

        if (jsonresponse == null) {
          return null;
        } else {
          ('not----------------');
          List<NotificationModel> temp = (jsonresponse as List)
              .map((f) => NotificationModel.fromJson(f))
              .toList();
          ('-temp : ${temp}');
          return temp;
        }
      } else {

        errorDialog(context: context, text: response.data['msg']);
      }
    } catch (e) {
      ('notification ------------ error');
      errorDialog(context: context, text: e.toString());
    }
  }

  static Future<void> deleteNotification(
      String token, int notification_id, BuildContext context) async {
    String deleteNotification_Url = APP_URL + 'users/delete-user-notifications';
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'id': '${notification_id}',
      });
      final response = await dio.post(deleteNotification_Url, data: _formData);
      if (response.data['status']) {
        errorDialog(context: context, text: response.data['msg']);
      } else {
        errorDialog(context: context, text: response.data['msg'].toString());
      }
    } catch (e) {

      errorDialog(context: context, text: e.toString());
    }
  }

//------------------------ online-payment -----------------------------

  static Future<void> makeOnlinePayment(
      String token, double amount, int order_id, BuildContext context) async {
    String OnlinePayment_Url = APP_URL + 'admin/payments/get-payment-id';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'amount': '${amount}',
      });
      final response = await dio.post(OnlinePayment_Url, data: _formData);
      if (response.data['status']) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PaymentWebView(
                      url: response.data['url'],
                      token: token,
                      user_id: sharedPreferences.getInt('user_id'),
                      order_id: order_id,
                    )));
      } else {
        errorDialog(context: context, text: response.data['msg'].toString());
      }
    } catch (e) {
      ('makeOnlinePayment error');
      errorDialog(context: context, text: e.toString());
    }
  }

  static Future<void> getPaymentResponse(String token, String url, int user_id,
      int order_id, BuildContext context) async {
    ('1');
    String OnlinePayment_Url = APP_URL + 'admin/payments/response';
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'url': '${url}',
        'user_id': '${user_id}',
        'order_id': '${order_id}',
      });
      ('2');
      final response = await dio.post(OnlinePayment_Url, data: _formData);
      ('response : ${response}');
      ('3');
      if (response.data['status']) {
        ('4');
        if (response.data['url_params']['Result'] == 'Successful' ||
            response.data['url_params']['Result'] == 'Success') {
          ('5');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PaymentResponse(
                        token: token,
                        status: 1,
                        user_id: user_id,
                    bill_cost: response.data['url_params']['amount'],
                    bill_number: response.data['url_params']['PaymentId'],
                    opertion_date: response.data['url_params']['invoice_date'],
                    salon_name: response.data['url_params']['salon_name'],
                    city: response.data['url_params']['salon_city'],
                      )));
          ('6');
        } else {
          ('7');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PaymentResponse(
                      token: token, status: 0, user_id: user_id)));
          ('8');
        }
      } else {
        ('9');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PaymentResponse(
                    token: token, status: 0, user_id: user_id)));
        ('10');
      }
    } catch (e) {
      ('11');
      ('getPaymentResponse errorr');
      errorDialog(context: context, text: e.toString());
    }
  }



  //get-user  invoices

  static Future<List<InvoicesModel>> getUserInvoices(
      String token, int user_id, BuildContext context) async {

    String Invoices_Url = APP_URL + 'admin/payments/get-user-invoices';
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'user_id': '${user_id}',
      });
      final response = await dio.post(Invoices_Url, data: _formData);

      if (response.data['status']) {
        final jsonresponse = response.data['invoices'];
        if (jsonresponse == null) {
          return null;
        } else {
          List<InvoicesModel> temp = (jsonresponse as List)
              .map((f) => InvoicesModel.fromJson(f))
              .toList();
          return temp;
        }
      } else {
        if(response.data['msg']=='عفوا لا توجد فواتير'){

        }else{
          errorDialog(context: context, text: response.data['msg']);
        }
      }
    } catch (e) {
      errorDialog(context: context, text: e.toString());
    }
  }


  //add credit card

  static addCreditCard(String token, String holder_name, String number, String exp_month,
      String exp_year, int user_id, BuildContext context) async {
    ('1');
    String card_Url = ApiProvider.APP_URL + 'admin/cards/store';
    Dio dio = new Dio();
    ('2');
    try {
      ('1');
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'holder_name': '${holder_name}',
        'number': '${number}',
        'exp_month': '${exp_month}',
        'exp_year': '${exp_year}',
        'user_id': '${user_id}',
      });
      ('3');
      final response = await dio.post(card_Url, data: _formData);
      ('response : ${response}');
      if (response.data['status'] == true) {
        errorDialog(
            context: context,
            text: '${response.data['msg'] }',
            function: (){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext
                      context) =>
                          MyCards(
                            token: token,
                            user_id: user_id,
                          )));
            }
        );
        ('4');
      } else {
        errorDialog(context: context, text: response.data['msg'],);
        ('5');
      }
    } catch (e) {
      ('SignUp Exception : ${e}');
      ('6');
    }
  }

// get all credit cards
  static Future<List<CardModel>> getUserCards(
      String token, int user_id, BuildContext context) async {
    String allCards_Url = APP_URL + 'admin/cards/get-all-cards';
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'user_id': '${user_id}',
      });
      final response = await dio.post(allCards_Url, data: _formData);
      ('getUserCards respnse : ${response}');
      if (response.data['status']) {
        final jsonresponse = response.data['cards'];
        if (jsonresponse == null) {
          return null;
        } else {
          List<CardModel> temp = (jsonresponse as List)
              .map((f) => CardModel.fromJson(f))
              .toList();
          return temp;
        }
      } else {
        if(response.data['msg']=='عفوا لا توجد بطاقات'){

        }else{
          errorDialog(context: context, text: response.data['msg']);
        }
      }
    } catch (e) {
      errorDialog(context: context, text: e.toString());
    }
  }

//delete Credit Card
  static Future<void> deleteCreditCard(
      String token, int card_id,int user_id, BuildContext context) async {
    String deleteCard_Url = APP_URL + 'admin/cards/destroy';
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'card_id': '${card_id}',
      });
      final response = await dio.post(deleteCard_Url, data: _formData);
      if (response.data['status']) {
       errorDialog(context: context, text: response.data['msg'],
           function: (){
             Navigator.pushReplacement(
                 context,
                 MaterialPageRoute(
                     builder: (BuildContext
                     context) =>
                         MyCards(
                           token: token,
                           user_id: user_id,
                         )));
           });
      } else {
        errorDialog(context: context, text: response.data['msg'].toString(),
            function: (){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext
                      context) =>
                          MyCards(
                            token: token,
                            user_id: user_id,
                          )));
            }
        );
      }
    } catch (e) {

      errorDialog(context: context, text: e.toString());
    }
  }


//update Credit Card

  static updateCreditCard(
      String token, String holder_name, String number, String exp_month,
      String exp_year, int user_id,int card_id, BuildContext context) async {

    String updateCard_Url = 'https://salonic.wothoq.co/api/admin/cards/update';
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'card_id': '${card_id}',
        'holder_name': '${holder_name}',
        'number': '${number}',
        'exp_month': '${exp_month}',
        'exp_year': '${exp_year}',
        'user_id': '${user_id}'
      });
      ('profile 3');
      final response = await dio.post(updateCard_Url, data: _formData);
      ('response : ${response}');
      if (response.data['status'] == true) {
        ('profile 5');
        errorDialog(context: context, text: response.data['msg'],
            function: (){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext
                      context) =>
                          MyCards(
                            token: token,
                            user_id: user_id,
                          )));
            });

      } else {
        errorDialog(context: context, text: response.data['msg'],);

        ('profile 6');
      }
    } catch (e) {
      ('profile 7');
      errorDialog(context: context, text: e.toString());    }
  }


  static Future<List<InvoiceSearchModel>> invoice_search_fun( var token ,
      var user_id, var key, BuildContext context)async{

    print("key : ${key}");
    String invoice_search_Url = APP_URL + 'admin/payments/search-payment';
    Dio dio = new Dio();
    try {
      FormData _formData = FormData.fromMap({
        'token': '${token}',
        'user_id': '${user_id}',
        'key' :'${key}'
      });
      final response = await dio.post(invoice_search_Url, data: _formData);
      print("---------------- response ------- : ${response}");
      if (response.data['status']) {
        final jsonresponse = response.data['payments'];
        if (jsonresponse == null) {
          return null;
        } else {
          List<InvoiceSearchModel> temp = (jsonresponse as List)
              .map((f) => InvoiceSearchModel.fromJson(f))
              .toList();
          print("response : ${temp}");
          return temp;
        }
      } else {
        if(response.data['msg']=='عفوا لا توجد يبانات'){

        }else{
          errorDialog(context: context, text: response.data['msg']);
        }
      }
    }catch(e){
      errorDialog(context: context, text: e.toString());
    }
  }
}
