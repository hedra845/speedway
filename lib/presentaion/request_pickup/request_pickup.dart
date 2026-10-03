import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    show FlutterSecureStorage;
import 'package:http/http.dart' as http;
import 'package:sender/config/Strings.dart';
import 'package:sender/conponantes/constantes/colores.dart';
import 'package:flutter/material.dart';
import 'package:sender/widgets/dropdowns/centers.dart';
import 'package:sender/widgets/dropdowns/governate.dart';
import 'package:sender/widgets/forms_models/textformfeilds.dart';
import 'package:sender/presentaion/add%20order/form_add_order.dart';
import 'package:svg_flutter/svg.dart';
import 'package:intl/intl.dart' hide TextDirection;

class Form_request_pickup extends StatefulWidget {
  const Form_request_pickup({super.key});

  @override
  State<Form_request_pickup> createState() => _Form_request_pickupState();
}

class _Form_request_pickupState extends State<Form_request_pickup> {
  String? selectedWeight;

  final List<String> weightOptions = ['Car', 'Motorcycle'];
  String title = 'اضافة طلب';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller_name_company = TextEditingController(
    text: company_name.toString(),
  );
  // ignore: unused_field
  final TextEditingController _controller_name_reference_number =
      TextEditingController();
  // ignore: unused_field
  final TextEditingController _controller_client_name = TextEditingController();
  final TextEditingController _controller_date = TextEditingController(
    text: DateFormat('yyyy-MM-dd').format(DateTime.now()),
  );
  final TextEditingController _controller_address = TextEditingController();
  final TextEditingController _controller_number_of_packages =
      TextEditingController();
  final TextEditingController _vichele_type = TextEditingController();
  final TextEditingController _controller_notes = TextEditingController();
  final SelectionController _controller_governate = SelectionController();
  final SelectorController _controller_center = SelectorController();
  String? gaovernateValue;
  String? centerValue;
  bool isVisible = false;
  bool _isReadOnly = true;
  // ignore: unused_element

  void _toggleReadOnly() {
    setState(() {
      _isReadOnly = !_isReadOnly;
    });
  }

  void sowshowCenters() {
    setState(() {
      if (gaovernateValue != null) {
        isVisible = true;
      } else {
        isVisible = false;
      }
    });
  }

  Future<void> submitPickupRequest() async {
    final storage = const FlutterSecureStorage();
    String? companyName = await storage.read(key: 'name');
    _controller_name_company.text = companyName.toString();
    String? token = await storage.read(key: 'token');
    String? uid = await storage.read(key: 'uid');
    String? companyId = await storage.read(key: 'company_id');
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(Apis.request_pickup_orders),
    );
    request.fields.addAll({
      'uid': uid.toString(),
      'center_id': centerValue.toString(),
      'governate_id': gaovernateValue.toString(),
      'address': _controller_address.text,
      'vichele_type': _vichele_type.text,
      'company_id': companyId.toString(),
      'date': _controller_date.text,
      'orders_count': _controller_number_of_packages.text,
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.primaryColor,
          content: Text(
            style: TextStyle(color: AppColors.white),
            await response.stream.bytesToString().then(
              (value) => json.decode(value)["message"],
            ),
          ),
        ),
      );
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.text_gray_Dark,
          surfaceTintColor: AppColors.white,
          shadowColor: AppColors.text_gray_Dark.withOpacity(0.08),
          elevation: 1,
          leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/home_screen');
            },
            icon: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.text_gray_Dark,
              size: 20,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/notifications_page');
              },
              icon: Icon(
                Icons.notifications_none_rounded,
                color: AppColors.text_gray_Dark.withOpacity(0.7),
              ),
            ),
          ],
          title: const Text(
            'طلب بيك اب',
            style: TextStyle(
              fontFamily: 'cairo',
              color: AppColors.text_gray_Dark,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GovernateDropdown(
                        controller: _controller_governate,
                        onSelectionChanged: (value) {
                          setState(() {
                            gaovernateValue = value;
                            centerValue = null;
                            sowshowCenters();
                          });
                        },
                      ),
                    ),
                    if (isVisible) ...[
                      const SizedBox(width: 8),
                      Expanded(
                        child: CentersDropdown(
                          controller: _controller_center,
                          gavernate_id: gaovernateValue,
                          onSelectionChanged: (value) {
                            setState(() {
                              centerValue = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 12),
                TexxtFormFeild(
                  'العنوان',
                  _controller_address,
                  (value) => value == null || value.isEmpty
                      ? 'ادخل العنوان من فضلك'
                      : null,
                  false,
                  null,
                  TextInputType.streetAddress,
                  3,
                  AppColors.red,
                  const Icon(Icons.star, size: 10),
                ),
                const SizedBox(height: 12),
                TexxtFormFeild(
                  'اسم الشركة',
                  _controller_name_company,
                  (value) => value == null || value.isEmpty
                      ? 'ادخل اسم الشركة من فضلك'
                      : null,
                  _isReadOnly,
                  null,
                  TextInputType.name,
                  1,
                  AppColors.red,
                  const Icon(Icons.star, size: 10),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FAFC),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: AppColors.text_gray.withOpacity(0.25),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: selectedWeight,
                      hint: const Text(
                        "اختر وسيلة النقل",
                        style: TextStyle(
                          color: AppColors.text_gray_Dark,
                          fontFamily: 'cairo',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      icon: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.primaryColor,
                      ),
                      dropdownColor: AppColors.white,
                      items: weightOptions.map((String value) {
                        String arabicLabel = value == 'Car'
                            ? 'سيارة'
                            : (value == 'Motorcycle' ? 'دراجة نارية' : value);
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            arabicLabel,
                            style: const TextStyle(
                              color: AppColors.text_gray_Dark,
                              fontFamily: 'cairo',
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedWeight = newValue;
                          String weightToSend = selectedWeight ?? "0";
                          _vichele_type.text = weightToSend;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                TexxtFormFeild(
                  'عدد الشحنات',
                  _controller_number_of_packages,
                  (value) => value == null || value.isEmpty
                      ? 'ادخل عدد الشحنات من فضلك'
                      : null,
                  false,
                  null,
                  TextInputType.number,
                  1,
                  AppColors.red,
                  const Icon(Icons.star, size: 10),
                ),
                const SizedBox(height: 12),
                TexxtFormFeild(
                  'تاريخ الطلب',
                  _controller_date,
                  (value) => value == null || value.isEmpty
                      ? 'ادخل التاريخ من فضلك'
                      : null,
                  false,
                  null,
                  TextInputType.datetime,
                  1,
                  AppColors.red,
                  const Icon(Icons.star, size: 10),
                ),
                const SizedBox(height: 12),
                TexxtFormFeild(
                  'الملاحظات',
                  _controller_notes,
                  (value) => null,
                  false,
                  null,
                  TextInputType.text,
                  3,
                  AppColors.text_gray_Dark,
                  const Icon(Icons.star, size: 10),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState?.validate() == true) {
                        if (centerValue != null && gaovernateValue != null) {
                          submitPickupRequest();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: AppColors.primaryColor,
                              content: Text(
                                'اختر المنطقة والمحافظة من فضلك',
                                style: TextStyle(
                                  fontFamily: 'cairo',
                                  color: AppColors.white,
                                ),
                              ),
                            ),
                          );
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/icons/dolly-flatbed-alt.svg',
                          colorFilter: const ColorFilter.mode(
                            AppColors.white,
                            BlendMode.srcIn,
                          ),
                          width: 20,
                          height: 20,
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'طلب بيك اب',
                          style: TextStyle(
                            fontFamily: 'cairo',
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
