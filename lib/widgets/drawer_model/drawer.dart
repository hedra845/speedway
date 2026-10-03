import 'package:sender/conponantes/constantes/colores.dart';
import 'package:flutter/material.dart';
import 'package:sender/presentaion/assigned/assigned.dart';
import 'package:sender/presentaion/help_center/web_view.dart';
import 'package:sender/presentaion/on_the_way/on_way_orders.dart';
import 'package:sender/presentaion/orders/orders.dart';
import 'package:sender/presentaion/orders_delivered/orders_delivered.dart';
import 'package:sender/presentaion/orders_notDelivered/orders_notDelivered.dart';
import 'package:sender/presentaion/orders_onArchieve/orders_onArchieve.dart';
import 'package:sender/presentaion/orders_returned/orders_returned.dart';
import 'package:sender/presentaion/pickups/picked_up_orders.dart';
import 'package:svg_flutter/svg.dart';

class DrawerFb1 extends StatefulWidget {
  const DrawerFb1({super.key});

  @override
  State<DrawerFb1> createState() => _DrawerFb1State();
}

class _DrawerFb1State extends State<DrawerFb1> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: AppColors.white,
        child: ListView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                          Image.asset(
                            'assets/images/images/app_logo.png',
                            width: 150,
                            height: 100,
                            fit: BoxFit.contain,
                          ),
                      const SizedBox(height: 12),
                       const Divider(color: AppColors.orange),
                      MenuItem(
                        text: 'كل الطرود',
                        src: 'assets/images/icons/Icon_box_total_orders.svg',
                        onClicked: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const Orders(), // Page 1
                            ),
                          );
                        },
                      ),
                      MenuItem(
                        text: 'طرود لم يتم استلامها ',
                        src: 'assets/images/icons/time-forward.svg',
                        onClicked: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) =>
                                      const OrdersNotdelivered(), // Page 1
                            ),
                          );
                        },
                      ),
                      MenuItem(
                        text: 'طرود مع المندوب',
                        src: 'assets/images/icons/delivery-man.svg',
                        onClicked: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const OnWayOrders(), // Page 1
                            ),
                          );
                        },
                      ),
                      MenuItem(
                        text: 'طرود المعلقة',
                        src: 'assets/images/icons/icon_box_assigned_orders.svg',
                        onClicked: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) => const Ordersassigned(), // Page 1
                            ),
                          );
                        },
                      ),
                      MenuItem(
                        text: 'الطرود المرتجعة',
                        src: 'assets/images/icons/restock.svg',
                        onClicked: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) => const OrdersReturned(), // Page 1
                            ),
                          );
                        },
                      ),
                      MenuItem(
                        text: 'الطرود المسلمة',
                        src: 'assets/images/icons/box-circle-check.svg',
                        onClicked: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) => const Ordersdelivered(), // Page 1
                            ),
                          );
                        },
                      ),
                      MenuItem(
                        text: 'طلبات البيك اب',
                        src: 'assets/images/icons/Icon_van.svg',
                        onClicked: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) => const PickedUpOrders(), // Page 1
                            ),
                          );
                        },
                      ),
                      MenuItem(
                        text: 'طرود في الارشيف',
                        src: 'assets/images/icons/box_archive.svg',
                        onClicked: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder:
                                  (context) => const OrdersOnarchieve(), // Page 1
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30,),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                      
                       Column(
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           SvgPicture.asset(
                                      'assets/images/icons/logo_z2zenon.svg',
                                      colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                                      width: 35,
                                      height: 35,
                                    ),
                                           Text(
                                  "@copyright reserved to Engineers H&M ",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'cairo',
                                    color: AppColors.text_gray,
                                  ),
                                ),
                                 GestureDetector(
                                   onTap: () {
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyWebViewPage()));
                                   },
                                   child: Text(
                                    " 2025 own by A2ZENON",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'cairo',
                                      color: AppColors.primaryColor,
                                    ),
                                                         ),
                                 ),
                         ],
                       ),
                     ],
                   ),
                 ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();
    switch (index) {
      case 0:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const Scaffold(), // Page 1
          ),
        );
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const Scaffold(), // Page 2
          ),
        );
        break;
    }
  }
}

class SharedPreferences {
  static getInstance() {}
}

class MenuItem extends StatelessWidget {
  final String text;
  final String src;
  final VoidCallback? onClicked;

  const MenuItem({
    required this.text,
    required this.src,
    this.onClicked,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const textColor = AppColors.text_gray_Dark;
    const color = AppColors.primaryColor;
    const hoverColor = Colors.white70;

    return ListTile(
      leading: SvgPicture.asset(src, colorFilter: const ColorFilter.mode(color, BlendMode.srcIn)),
      title: Text(
        text,
        style: const TextStyle(color: textColor, fontFamily: 'cairo'),
      ),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }
}
