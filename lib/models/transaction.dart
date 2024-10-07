import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:project_tc/models/coupons.dart';

class TransactionModel {
  String? uid;
  TransactionItem? item;
  DateTime? invoiceDate;
  DateTime? date;
  String? bankName;
  String? price;
  String? status;
  String? invoice;
  String? uniqueCode;
  String? reason;
  List<TransactionDiscount>? discount;

  TransactionModel(
      {required this.uid,
      required this.item,
      this.invoiceDate,
      required this.date,
      required this.bankName,
      required this.price,
      required this.status,
      required this.invoice,
      required this.uniqueCode,
      this.discount,
      this.reason});

  factory TransactionModel.fromFirestore(Map<String, dynamic> data) {
    final List<dynamic>? transactionDiscount = data['discount'];

    final List<TransactionDiscount>? transactionDiscounts =
        transactionDiscount?.map((content) {
      return TransactionDiscount.fromFirestore(content as Map<String, dynamic>);
    }).toList();

    return TransactionModel(
        uid: data['uid'],
        item: TransactionItem.fromFirestore(data['item']),
        invoiceDate: data['invoice_date'].toDate(),
        date: data['date'].toDate(),
        bankName: data['bank_name'],
        price: data['price'],
        status: data['status'],
        invoice: data['invoice'],
        reason: data['reason'],
        uniqueCode: data['unique_code'],
        discount: transactionDiscounts);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'item': item!.toFirestore(),
      'invoice_date': Timestamp.fromDate(invoiceDate!),
      'date': Timestamp.fromDate(date!),
      'bank_name': bankName,
      'price': price,
      'status': status,
      'invoice': invoice,
      'reason': reason,
      'unique_code': uniqueCode,
      'discount': discount?.map((discount) => discount.toFirestore()).toList()
    };
  }
}

class TransactionItem {
  String? id;
  String? title;
  String? subTitle;

  TransactionItem({this.id, required this.title, required this.subTitle});

  factory TransactionItem.fromFirestore(Map<String, dynamic> data) {
    return TransactionItem(
        id: data['id'], title: data['title'], subTitle: data['sub_title']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'title': title,
      'sub_title': subTitle,
    };
  }
}

class TransactionDiscount {
  String? code;
  Coupons? couponType;
  int? amount;
  String? discountedPrice;

  TransactionDiscount(
      {required this.code,
      this.couponType,
      required this.amount,
      this.discountedPrice});

  factory TransactionDiscount.fromFirestore(Map<String, dynamic> data) {
    return TransactionDiscount(
        code: data['code'],
        couponType: Coupons.values
            .firstWhereOrNull((e) => e.name == data['coupon_type']),
        amount: data['amount'],
        discountedPrice: data['discounted_price']);
  }

  Map<String, dynamic> toFirestore() {
    return {
      'code': code,
      'coupon_type': couponType?.name,
      'amount': amount,
      'discounted_price': discountedPrice,
    };
  }
}
