
import 'package:flutter/material.dart';

class FormDataDetails {
  String? client_name;
  String? order_id;
  String? date;
  String? police_number;
  String? order_status;
  String? total_price;
  String? address;
  String? city;
  String? zone;
  String? phone_number1;
  String? phone_number2;
  String? notes;
  String? sender_name;
  String? Initial_instructions;
  String? Final_instructions;
  String? identity_number;
  Color? color;

  FormDataDetails({
    this.client_name,
    this.date,
    this.police_number,
    this.order_status,
    this.total_price,
    this.address,
    this.city,
    this.phone_number1,
    this.phone_number2,
    this.notes,
    this.sender_name,
    this.Initial_instructions,
    this.Final_instructions,
    this.identity_number,
    this.zone,
    this.order_id,
    this.color
  });
}
