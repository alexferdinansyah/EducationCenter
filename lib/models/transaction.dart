import 'package:cloud_firestore/cloud_firestore.dart';

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
      this.reason});

  factory TransactionModel.fromFirestore(Map<String, dynamic> data) {
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
    );
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
      'unique_code': uniqueCode
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
