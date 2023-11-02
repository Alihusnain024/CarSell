Rails.configuration.stripe = {
  publishable_key: 'pk_test_51O5ioyD2Gim06fmGQ0U5vypU0XueYrRMEOdnmriiYhK6m9TttNIZdhzBHn0mumIcNKhZjFbmhQk5T6F14OgK1rMK00dadnqkgl',
  secret_key: 'sk_test_51O5ioyD2Gim06fmGyt13uMs5BIOAVmyeegC8zj0acfhBVPOG5iPPYCKsb7pKaK1UMulicI0V3d34jHKnSV89fn6E00blBUtdpT'
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
