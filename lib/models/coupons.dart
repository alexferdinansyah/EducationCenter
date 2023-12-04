enum Coupons {
  percentageCoupon,
  fixedCartCoupon,
  productCoupon,
}

String getCouponDisplayName(Coupons coupon) {
  switch (coupon) {
    case Coupons.percentageCoupon:
      return 'Percentage Coupon';
    case Coupons.fixedCartCoupon:
      return 'Fixed Cart Coupon';
    case Coupons.productCoupon:
      return 'Product Coupon';
    // handle other enum values if needed
    default:
      return coupon.toString().split('.').last;
  }
}

// nanti tambahin buat redeem membership parameter
String getCouponFormatName(Coupons coupon, int amount) {
  switch (coupon) {
    case Coupons.percentageCoupon:
      return '$amount%';
    case Coupons.fixedCartCoupon:
      return 'Rp $amount';
    case Coupons.productCoupon:
      return 'Product Coupon';
    // handle other enum values if needed
    default:
      return coupon.toString().split('.').last;
  }
}

enum Status {
  Draft,
  Publish,
}

enum StatusCoupon {
  Expired,
  Activated,
  Redeemed,
}

enum VisibilityType {
  Public,
  Private,
}
