import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sender/conponantes/constantes/colores.dart';
import 'package:svg_flutter/svg.dart';

class PersonalData extends StatefulWidget {
  const PersonalData({super.key});

  @override
  State<PersonalData> createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
  String? name;
  String? phone;
  String? address;
  String? id_company;

  void readData() async {
    const storage = FlutterSecureStorage();
    name = await storage.read(key: 'name');
    phone = await storage.read(key: 'phone');
    address = await storage.read(key: 'address');
    id_company = await storage.read(key: 'id_company');
  }

  @override
  void initState() {
    super.initState();
    readData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'البيانات الشخصية',
                style: TextStyle(
                    fontFamily: 'cairo',
                    color: AppColors.text_gray_Dark,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ]),
      ),
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.only(right: 15.0, left: 15),
            child: Column(
              children: [
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 8),
                    child: const Text(
                      'الاسم الكامل',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: AppColors.text_gray_Dark,
                          fontSize: 16,
                          fontFamily: 'cairo',
                          fontWeight: FontWeight.bold),
                    )),
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      '$name',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                          color: AppColors.text_gray_Dark,
                          fontSize: 16,
                          fontFamily: 'cairo',
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 8),
                    child: const Text(
                      ' العنوان',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: AppColors.text_gray_Dark,
                          fontSize: 16,
                          fontFamily: 'cairo',
                          fontWeight: FontWeight.bold),
                    )),
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      ' $address',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                          color: AppColors.text_gray_Dark,
                          fontSize: 16,
                          fontFamily: 'cairo',
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 8),
                    child: const Text(
                      'رقم الهاتف ',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: AppColors.text_gray_Dark,
                          fontSize: 16,
                          fontFamily: 'cairo',
                          fontWeight: FontWeight.bold),
                    )),
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      '$phone',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                          color: AppColors.text_gray_Dark,
                          fontSize: 16,
                          fontFamily: 'cairo',
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(bottom: 8),
                    child: const Text(
                      'الايدي الخاص بك ',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: AppColors.text_gray_Dark,
                          fontSize: 16,
                          fontFamily: 'cairo',
                          fontWeight: FontWeight.bold),
                    )),
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      ' $id_company ',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                          color: AppColors.text_gray_Dark,
                          fontSize: 16,
                          fontFamily: 'cairo',
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
