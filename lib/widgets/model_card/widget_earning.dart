import 'package:sender/conponantes/constantes/colores.dart';
import 'package:flutter/material.dart';

Widget earningsCard(String label, String amount, String date, Color color,) {
  return Container(
    width: 200, // Fixed width for each card
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12,fontFamily: 'cairo'),
        ),
        const SizedBox(height: 30),
        Text(
          amount,
          style: const TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          date,
          style: const TextStyle(color: Colors.white60, fontSize: 10),
        ),
      ],
    ),
  );
}

Widget earningsDetail(String orderCode, String date, double price,Color Price) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: const Color(0xff858D90), width: 0.25),
    ),
    child: Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            orderCode,
            style: const TextStyle(
                color: Color(0xff858D90),
                fontSize: 10,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                date,
                style: const TextStyle(color: Color(0xff273238), fontSize: 15),
              ),
              Text(
                "\$${price.toString()}",
                style: TextStyle(color: Price, fontSize: 15, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    ),
  );
}


Widget collectedDetail(String orderCode, String date, double price) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: const Color(0xff858D90), width: 0.25),
    ),
    child: Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            orderCode,
            style: const TextStyle(
                color: Color(0xff858D90),
                fontSize: 10,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                date,
                style: const TextStyle(color: Color(0xff273238), fontSize: 15),
              ),
              Text(
                "\$${price.toString()}",
                style: const TextStyle(color: AppColors.text_gray, fontSize: 15, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
