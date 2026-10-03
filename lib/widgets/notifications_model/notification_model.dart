import 'package:sender/conponantes/constantes/colores.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class NotificationModel extends StatelessWidget {
  const NotificationModel({super.key, required this.title, required this.message, required this.date});

  final  String title;
  final  String message;
  final  String date;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(7)),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(100)),
              child: SvgPicture.asset(
                'assets/images/images/logo_zenon.svg',
                color: AppColors.white,
                width: 30,
                height: 30,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        date,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(message),
                ])
          ],
        ),
      ),
    );
  }
}

