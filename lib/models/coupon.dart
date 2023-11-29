import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_tc/models/coupons.dart';

class Coupon {
  String? code;
  String? description;
  Coupons? type;
  int? amount;
  DateTime? expires;
  int? timesUsed;
  UsageRestriction? usageRestriction;
  UsageLimit? usageLimit;

  Coupon({
    required this.code,
    this.description,
    required this.type,
    required this.amount,
    required this.expires,
    this.timesUsed,
    this.usageRestriction,
    this.usageLimit,
  });

  factory Coupon.fromFirestore(Map<String, dynamic> data) {
    return Coupon(
      code: data['code'],
      description: data['description'],
      type: Coupons.values[data['type']],
      amount: data['amount'],
      expires: data['expires'].toDate(),
      timesUsed: data['times_used'],
      usageRestriction:
          UsageRestriction.fromFirestore(data['usage_restriction']),
      usageLimit: UsageLimit.fromFirestore(data['usage_limit']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'code': code,
      'description': description,
      'type': type, //type?.index,
      'amount': amount,
      'expires': Timestamp.fromDate(expires!),
      'times_used': timesUsed,
      'usage_restriction': usageRestriction?.toFirestore(),
      'usage_limit': usageLimit?.toFirestore(),
    };
  }
}

class UsageRestriction {
  List<String>? products;
  List<String>? excludeProducts;
  List<String>? productCategories;
  List<String>? excludeCategories;

  UsageRestriction({
    this.products,
    this.excludeProducts,
    this.productCategories,
    this.excludeCategories,
  });

  factory UsageRestriction.fromFirestore(Map<String, dynamic> data) {
    return UsageRestriction(
      products: List<String>.from(data['products']),
      excludeProducts: List<String>.from(data['exclude_products']),
      productCategories: List<String>.from(data['product_Categories']),
      excludeCategories: List<String>.from(data['exclude_categories']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'products': products,
      'exclude_croducts': excludeProducts,
      'product_categories': productCategories,
      'exclude_categories': excludeCategories,
    };
  }
}

class UsageLimit {
  int? perCoupon;
  int? perUser;

  UsageLimit({
    this.perCoupon,
    this.perUser,
  });

  factory UsageLimit.fromFirestore(Map<String, dynamic> data) {
    return UsageLimit(
      perCoupon: data['per_coupon'],
      perUser: data['per_user'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'perCoupon': perCoupon,
      'perUser': perUser,
    };
  }
}
