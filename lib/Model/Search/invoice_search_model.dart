

class InvoiceSearchModel {
  var id;
  var userId;
  var salonId;
  var amount;
  var paymentId;
  var ordersIds;
  var bankTransactionId;
  var status;
  var createdAt;
  User user;
  Salon salon;

  InvoiceSearchModel(
      {this.id,
        this.userId,
        this.salonId,
        this.amount,
        this.paymentId,
        this.ordersIds,
        this.bankTransactionId,
        this.status,
        this.createdAt,
        this.user,
        this.salon});

  InvoiceSearchModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    salonId = json['salon_id'];
    amount = json['amount'];
    paymentId = json['payment_id'];
    ordersIds = json['orders_ids'];
    bankTransactionId = json['bank_transaction_id'];
    status = json['status'];
    createdAt = json['created_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    salon = json['salon'] != null ? new Salon.fromJson(json['salon']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['salon_id'] = this.salonId;
    data['amount'] = this.amount;
    data['payment_id'] = this.paymentId;
    data['orders_ids'] = this.ordersIds;
    data['bank_transaction_id'] = this.bankTransactionId;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.salon != null) {
      data['salon'] = this.salon.toJson();
    }
    return data;
  }
}

class User {
  var id;
  var name;
  var email;
  var emailVerifiedAt;
  var mobile;
  var createdAt;
  var updatedAt;

  User(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.mobile,
        this.createdAt,
        this.updatedAt});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    mobile = json['mobile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['mobile'] = this.mobile;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Salon {
  var id;
  var name;
  var username;
  var email;
  var homeService;
  var payment;
  var latitude;
  var longitude;
  var booking;
  var logo;
  var tax;
  var appCommission;
  var address;
  var cityId;
  var createdAt;
  var updatedAt;
  City city;

  Salon(
      {this.id,
        this.name,
        this.username,
        this.email,
        this.homeService,
        this.payment,
        this.latitude,
        this.longitude,
        this.booking,
        this.logo,
        this.tax,
        this.appCommission,
        this.address,
        this.cityId,
        this.createdAt,
        this.updatedAt,
        this.city});

  Salon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    homeService = json['home_service'];
    payment = json['payment'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    booking = json['booking'];
    logo = json['logo'];
    tax = json['tax'];
    appCommission = json['app_commission'];
    address = json['address'];
    cityId = json['city_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['home_service'] = this.homeService;
    data['payment'] = this.payment;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['booking'] = this.booking;
    data['logo'] = this.logo;
    data['tax'] = this.tax;
    data['app_commission'] = this.appCommission;
    data['address'] = this.address;
    data['city_id'] = this.cityId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.city != null) {
      data['city'] = this.city.toJson();
    }
    return data;
  }
}

class City {
  var id;
  var name;
  var location;
  var createdAt;
  var updatedAt;

  City({this.id, this.name, this.location, this.createdAt, this.updatedAt});

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['location'] = this.location;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}