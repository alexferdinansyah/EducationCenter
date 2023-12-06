import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_tc/models/coupons.dart';

class Coupon {
  String? code;
  String? description;
  Coupons? type;
  int? amount;
  String? product;
  DateTime? expires;
  int? timesUsed;
  Status? status;
  VisibilityType? visibility;
  UsageRestriction? usageRestriction;
  UsageLimit? usageLimit;

  Coupon({
    required this.code,
    this.description,
    required this.type,
    this.amount,
    this.product,
    this.expires,
    this.timesUsed,
    required this.status,
    required this.visibility,
    this.usageRestriction,
    this.usageLimit,
  });

  factory Coupon.fromFirestore(Map<String, dynamic> data) {
    final usageLimit = data['usage_limit'] as Map<String, dynamic>?;

    return Coupon(
      code: data['code'],
      description: data['description'],
      type: Coupons.values.firstWhere((e) => e.name == data['type']),
      amount: data['amount'],
      product: data['product'],
      expires: data['expires']?.toDate(),
      timesUsed: data['times_used'],
      status: Status.values.firstWhere((e) => e.name == data['status']),
      visibility:
          VisibilityType.values.firstWhere((e) => e.name == data['visibility']),
      usageRestriction:
          UsageRestriction.fromFirestore(data['usage_restriction']),
      usageLimit: UsageLimit.fromFirestore(usageLimit!),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'code': code,
      'description': description,
      'type': type?.name,
      'amount': amount,
      'product': product,
      'expires': expires != null ? Timestamp.fromDate(expires!) : null,
      'times_used': timesUsed,
      'status': status?.name,
      'visibility': visibility?.name,
      'usage_restriction': usageRestriction?.toFirestore(),
      'usage_limit': usageLimit?.toFirestore(),
    };
  }

  StatusCoupon? getStatus() => getStatusAt(DateTime.now());

  StatusCoupon? getStatusAt(DateTime? dateTime) {
    if (dateTime == null) {
      return null;
    }
    if (expires != null && dateTime.isAfter(expires!)) {
      return StatusCoupon.Expired;
    } else {
      return null;
    }
  }
}

class UsageRestriction {
  List<String>? products;
  List<String>? excludeProducts;

  UsageRestriction({
    this.products,
    this.excludeProducts,
  });

  factory UsageRestriction.fromFirestore(Map<String, dynamic> data) {
    return UsageRestriction(
      products: List<String>.from(data['products'] ?? []),
      excludeProducts: List<String>.from(data['exclude_products'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'products': products,
      'exclude_products': excludeProducts,
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
      'per_coupon': perCoupon,
      'per_user': perUser,
    };
  }
}
