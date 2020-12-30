class CardModel {
  int id;
  String holderName;
  String expMonth;
  String expYear;
  String number;
  String brand;
  int userId;

  CardModel(
      {this.id,
        this.holderName,
        this.expMonth,
        this.expYear,
        this.number,
        this.brand,
        this.userId});

  CardModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    holderName = json['holder_name'];
    expMonth = json['exp_month'];
    expYear = json['exp_year'];
    number = json['number'];
    brand = json['brand'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['holder_name'] = this.holderName;
    data['exp_month'] = this.expMonth;
    data['exp_year'] = this.expYear;
    data['number'] = this.number;
    data['brand'] = this.brand;
    data['user_id'] = this.userId;
    return data;
  }
}