enum Coupons {
  percentageCoupon,
  fixedCartCoupon,
  fixedProductCoupon,
}

String getCouponDisplayName(Coupons coupon) {
  switch (coupon) {
    case Coupons.percentageCoupon:
      return 'Percentage Coupon';
    case Coupons.fixedCartCoupon:
      return 'Fixed Cart Coupon';
    case Coupons.fixedProductCoupon:
      return 'Fixed Product Coupon';
    // handle other enum values if needed
    default:
      return coupon.toString().split('.').last;
  }
}

enum Status {
  Draft,
  Publish,
}

enum VisibilityType {
  Public,
  Private,
}
