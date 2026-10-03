import 'package:sender/conponantes/constantes/colores.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import '../../widgets/notifications_model/notification_model.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('assets/images/icons/arrow-left.svg')),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/Orders_Page');
              },
              icon: SvgPicture.asset('assets/images/icons/Icon_bottom_orders.svg',color: AppColors.text_gray)),
        ],
        title: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'صفحة الاشعارات',
                style: TextStyle(
                  fontFamily: 'cairo',
                    color: AppColors.text_gray_Dark,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ]),
      ),
      backgroundColor: const Color.fromARGB(255, 245, 244, 244),
      body: Container(padding: const EdgeInsets.all(10),color: AppColors.text_gray.withOpacity(0.1),width: double.infinity,height: double.infinity,
      child:ListView.builder(itemBuilder: (context, index) => const NotificationModel(title: 'hedra',message: 'hedra is here',date: '11/12/2024',),itemCount: 10,) ,
      ),
    );
  }
}










//if notifications are empty
class Notification_empty extends StatelessWidget {
  const Notification_empty({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
                  'assets/images/images/notify_rnwe.svg',
                  color: AppColors.white,
                  width: 30,
                  height: 30,
                ),
              ),
              const Text('No notifications yet!'),
            ],
          ),
        ),
      ],
    );
  }
}
