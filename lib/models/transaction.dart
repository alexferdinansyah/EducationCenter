import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  String? uid;
  TransactionItem? item;
  String? invoiceDate;
  DateTime? date;
  String? price;
  String? status;
  String? invoice;

  TransactionModel({
    required this.uid,
    required this.item,
    this.invoiceDate,
    required this.date,
    required this.price,
    required this.status,
    required this.invoice,
  });

  factory TransactionModel.fromFirestore(Map<String, dynamic> data) {
    return TransactionModel(
      uid: data['uid'],
      item: TransactionItem.fromFirestore(data['item']),
      invoiceDate: data['invoice_date'],
      date: data['date'].toDate(),
      price: data['price'],
      status: data['status'],
      invoice: data['invoice'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'item': item!.toFirestore(),
      'invoice_date': invoiceDate,
      'date': Timestamp.now(),
      'price': price,
      'status': status,
      'invoice': invoice
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
