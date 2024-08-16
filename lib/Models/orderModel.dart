import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  int? orderId;
  String? clientName;
  String? clientPhone;
  String? productName;
  String? picesNumber;
  int? price;
  int? shipingPrice;
  String? governorate;
  String? region;
  String? streetName;
  String? bulidingNumber;
  String? levelNumber;
  String? flatNumber;
  String? oId;
  String? comments;
  bool? isPanding;
  bool? isShipped;
  DateTime? date;
  String? time;

  OrderModel({
    this.orderId = 0,
    this.clientName,
    this.clientPhone,
    this.picesNumber,
    this.productName,
    this.price,
    this.shipingPrice,
    this.governorate,
    this.region,
    this.streetName,
    this.bulidingNumber,
    this.levelNumber,
    this.flatNumber,
    this.comments,
    this.oId,
    this.date,
    this.time,
    this.isPanding = true,
    this.isShipped = true,
  });

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderId = json['orderId'];
    clientName = json['clientName'];
    clientPhone = json['clientPhone'];
    productName = json['productName'];
    picesNumber = json['picesNumber'];
    price = json['price'];
    shipingPrice = json['shipingPrice'];
    governorate = json['governorate'];
    region = json['region'];
    streetName = json['streetName'];
    bulidingNumber = json['bulidingNumber'];
    levelNumber = json['levelNumber'];
    flatNumber = json['flatNumber'];
    comments = json['comments'];
    oId = json['oId'];
    date = (json['date'] as Timestamp).toDate();
    time = json['time'];
    isPanding = json['isPanding'];
    isShipped = json['isShipped'];
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'clientName': clientName,
      'clientPhone': clientPhone,
      'productName': productName,
      'picesNumber': picesNumber,
      'price': price,
      'shipingPrice': shipingPrice,
      'governorate': governorate,
      'region': region,
      'streetName': streetName,
      'bulidingNumber': bulidingNumber,
      'levelNumber': levelNumber,
      'flatNumber': flatNumber,
      'comments': comments,
      'oId': oId,
      'date': date,
      'time': time,
      'isPanding': isPanding,
      'isShipped': isShipped,
    };
  }
}
