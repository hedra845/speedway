// ignore: file_names
class Apis {
  static const String BASE_URL = "https://speedway.a2zenon.com/api";
  static const String LOGIN_URL = "$BASE_URL/login";
  static const String REGISTER_URL = "$BASE_URL/register";
  static const String orders_url = "$BASE_URL/orders/all";
  static const String orders_waiting = "$BASE_URL/orders/waiting";
  static const String orders_notDelivered = "$BASE_URL/orders/not_delivered";
  static const String orders_delivered = "$BASE_URL/orders/delivered";
  static const String orders_pending = "$BASE_URL/orders/pending";
  static const String orders_redeliver = "$BASE_URL/orders/redeliver";
  static const String orders_on_delegate = "$BASE_URL/orders/on_delegate";
  static const String orders_orders_onCompany = "$BASE_URL/orders/on_company";
  static const String orders_returned_to_sender = "$BASE_URL/orders/returned_to_sender";
  static const String orders_on_archieve = "$BASE_URL/orders/on_archieve";
  static const String orders_returned = "$BASE_URL/orders/returned";
  static const String orders_store = "$BASE_URL/orders/store";
  static const String governates = "$BASE_URL/governates/all";
  static const String centers = "$BASE_URL/centers/all?governate_id=";
  static const String pickup_orders = "$BASE_URL/pickup/all";
  static const String request_pickup_orders = "$BASE_URL/pickup/store";
  static const String orders_shipping_price = "$BASE_URL/orders/shipping_price";
  static const String statics = "$BASE_URL/statics";
}

class data {
  static const String company_number = "+201129033543";
}