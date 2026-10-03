import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sender/conponantes/constantes/colores.dart';
import 'package:svg_flutter/svg.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

TextEditingController Controller_size_all_orders = TextEditingController();

class _SettingsState extends State<Settings> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        shadowColor: AppColors.text_gray_Dark.withOpacity(0.1),
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('assets/images/icons/arrow-left.svg')),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/notifications_page');
              },
              icon: Icon(
                Icons.notifications_on_outlined,
                color: AppColors.black.withOpacity(0.5),
              )),
        ],
        title: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'الاعدادات الخاصة',
                style: TextStyle(
                    fontFamily: 'cairo',
                    color: AppColors.text_gray_Dark,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ]),
      ),
      body: SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [ Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                              Radius.circular(10)), // Set the border radius
                        ),
                        overlayColor: AppColors.background,
                        backgroundColor: AppColors.primaryColor, // Set the background color
                      ),
                      onPressed: () async {
                        if (Controller_size_all_orders.text.isNotEmpty &&
                            Controller_size_all_orders.text != '0') {
                          const storage = FlutterSecureStorage();
                          await storage.write(
                              key: 'sized_all_orders',
                              value: Controller_size_all_orders.text);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: AppColors.primaryColor,
                            duration: const Duration(seconds: 1),
                            content: Text(
                              "تم حفظ حجم الطلبات : ${Controller_size_all_orders.text}",
                              style: const TextStyle(fontFamily: 'cairo'),
                            ),
                          ));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            backgroundColor: AppColors.primaryColor,
                            duration: Duration(seconds: 1),
                            content: Text(
                              "قم بادخال حجم الطلبات",
                              style: TextStyle(fontFamily: 'cairo'),
                            ),
                          ));
                        }
                      },
                      child: const Text(
                        'حفظ',
                        style: TextStyle(
                            color: AppColors.white, fontFamily: 'cairo'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  const Flexible(child: NumberDropdown()),
                  const SizedBox(width: 10),
                  const Text(
                    'حــجم طلـبـات \nالطرود اليومية',
                    style: TextStyle(
                        fontFamily: 'cairo',
                        color: AppColors.text_gray_Dark,
                        fontWeight: FontWeight.bold,
                        fontSize: 13),
                  ),
                ],
              ),

              ],
      ),
    ),
  ),
    );
  }
}


class NumberDropdown extends StatefulWidget {
  const NumberDropdown({super.key});

  @override
  _NumberDropdownState createState() => _NumberDropdownState();
}

class _NumberDropdownState extends State<NumberDropdown> {
  int selectedNumber = 15; // الرقم الافتراضي

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
            color:  const Color(0xFFF5F6F9),
            borderRadius: BorderRadius.circular(15),
          ),
          padding:  const EdgeInsets.only(right: 8, left: 8),
        child: DropdownButton<int>(
          alignment: Alignment.centerRight,
          dropdownColor: AppColors.white,
        iconDisabledColor: AppColors.primaryColor,
        iconEnabledColor: AppColors.primaryColor,
         borderRadius: const BorderRadius.all(Radius.circular(15)),
        underline: const ColoredBox(color: AppColors.text_gray),
          value: selectedNumber,
          items: List.generate(16, (index) => 15 + index) // إنشاء الأرقام من 10 إلى 20
              .map((number) => DropdownMenuItem(
                    value: number,
                    child: Text(number.toString()),
                  ))
              .toList(),
          onChanged: (newValue) {
            setState(() {
              selectedNumber = newValue!;
              Controller_size_all_orders.text = selectedNumber.toString();
            });
          },
        ),
      ),
    );
  }
}