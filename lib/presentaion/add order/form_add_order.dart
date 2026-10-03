// ignore_for_file: non_constant_identifier_names
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sender/config/Strings.dart';
import 'package:sender/conponantes/constantes/colores.dart';
import 'package:flutter/material.dart';
import 'package:sender/widgets/dropdowns/centers.dart';
import 'package:sender/widgets/dropdowns/governate.dart';
import 'package:sender/widgets/dropdowns/opening_order.dart';
import 'package:sender/widgets/dropdowns/type_services.dart';
import 'package:sender/widgets/forms_models/textformfeilds.dart';
import 'package:svg_flutter/svg.dart';

class FormAddOrder extends StatefulWidget {
  const FormAddOrder({super.key});

  @override
  State<FormAddOrder> createState() => _FormAddOrderState();
}

String? selectedValue;
String? gaovernateValue;
String? centerValue;
bool isVisible = false;
String? company_name;
dynamic data_shipping_price;
 Map<String, dynamic> dataShippingPrice = {};
  String cost = '';
  String weightPrice = '';
  String shippingPrice = '';
  String totalPrice = '';

class _FormAddOrderState extends State<FormAddOrder> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  _loadStoredValue() async {
    company_name = await storage.read(key: 'name');
  }

  @override
  void initState() {
    super.initState();
    _loadStoredValue();
    // Load value on app start
  }

  String title = 'اضافة طلب';
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller_name_company = TextEditingController(
    text: company_name,
  );
  final TextEditingController _controller_name_reference_number =
      TextEditingController();
  final TextEditingController _controller_client_name = TextEditingController();
  final TextEditingController _controller_phone_number_one =
      TextEditingController();
  final TextEditingController _controller_phone_number_two =
      TextEditingController();
  final TextEditingController _controller_address = TextEditingController();
  // ignore: unused_field
  final TextEditingController _controller_type_services =
      TextEditingController();
  final TextEditingController _controller_opening_order =
      TextEditingController();
  final TextEditingController _controller_price = TextEditingController();
  final TextEditingController _controller_notes = TextEditingController();
  final TextEditingController _controller_weight = TextEditingController();
  final SelectionController _controller_governate = SelectionController();
  final SelectorController _controller_center = SelectorController();
  // ignore: unused_field
  final TextEditingController _controller_sender = TextEditingController();
  final TextEditingController _controller_sender_name = TextEditingController();
  final TextEditingController _controller_prouduct_name =
      TextEditingController();
  final TextEditingController _controller_instructions =
      TextEditingController();
  final TextEditingController _controller_identy_number =
      TextEditingController();

  bool _isReadOnly = true;
  // ignore: unused_element
  void _toggleReadOnly() {
    setState(() {
      _isReadOnly = !_isReadOnly;
    });
  }

  void updateSelectedValue(String value) {
    setState(() {
      selectedValue = value;
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

  Future<void> sendrequest() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    // Read the token with the key 'token'
    String? token = await secureStorage.read(key: 'token');
    String? uid = await secureStorage.read(key: 'uid');
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest('POST', Uri.parse(Apis.orders_store));
    request.fields.addAll({
      "uid": uid.toString(),
      "name_client":
          _controller_client_name.text.trim().isNotEmpty
              ? _controller_client_name.text.trim()
              : "0",

      "phone":
          _controller_phone_number_one.text.trim().isNotEmpty
              ? _controller_phone_number_one.text.trim()
              : "0",

      "phone2":
          _controller_phone_number_two.text.trim().isNotEmpty
              ? _controller_phone_number_two.text.trim()
              : "0",

      "center_id":
          centerValue?.toString().trim().isNotEmpty == true
              ? centerValue.toString()
              : "0",

      "governate_id":
          gaovernateValue?.toString().trim().isNotEmpty == true
              ? gaovernateValue.toString()
              : "0",

      "address":
          _controller_address.text.trim().isNotEmpty
              ? _controller_address.text.trim()
              : "none",

      "cost":
          _controller_price.text.trim().isNotEmpty
              ? _controller_price.text.trim()
              : "0",

      "sender_police":
          _controller_name_reference_number.text.trim().isNotEmpty
              ? _controller_name_reference_number.text.trim()
              : "0",

      "special_intructions":
          _controller_instructions.text.trim().isNotEmpty
              ? _controller_instructions.text.trim()
              : "none",

      "name_product":
          _controller_prouduct_name.text.trim().isNotEmpty
              ? _controller_prouduct_name.text.trim()
              : "none",

      "sender":
          _controller_sender_name.text.trim().isNotEmpty
              ? _controller_sender_name.text.trim()
              : "none",

      "identy_number":
          _controller_identy_number.text.trim().isNotEmpty
              ? _controller_identy_number.text.trim()
              : "0",

      "open":
          _controller_opening_order.text.trim().isNotEmpty
              ? _controller_opening_order.text.trim()
              : "0",

      "service_type":
          _controller_type_services.text.trim().isNotEmpty
              ? _controller_type_services.text.trim()
              : "0",

      "notes":
          _controller_notes.text.trim().isNotEmpty
              ? _controller_notes.text.trim()
              : "none",

      "weghit":
          _controller_weight.text.trim().isNotEmpty
              ? _controller_weight.text.trim()
              : "0",
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.primaryColor,
          content: Text(
            await response.stream.bytesToString().then(
              (value) => json.decode(value)["success"],
            ),
          ),
        ),
      );
    } else {
      Clipboard.setData(ClipboardData(text: response.toString()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColors.red,
          content: Text(response.reasonPhrase.toString()),
        ),
      );
    }
  }

  void _handleSelectionChanged(int open_order__value) {
    setState(() {
      _controller_opening_order.text = open_order__value.toString();
    });
  }

  void _handleSelectionChanged_typeservice(String type_services_value) {
    setState(() {
      _controller_type_services.text = type_services_value.toString();
    });
  }

 Future<void> _loadShippingPrice() async {    
  const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    // Read the token with the key 'token'
    String? token = await secureStorage.read(key: 'token');
    String? uid = await secureStorage.read(key: 'uid');
    var headers = {'Authorization': 'Bearer $token'};

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(Apis.orders_shipping_price),
    );

    request.fields.addAll({
      'uid': uid ?? '',
      'type': 'order',
      'weight': _controller_weight.text,
      'cost': _controller_price.text,
      'governate_id': gaovernateValue ?? '',
      'center_id': centerValue ?? '',
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      final responseString = await response.stream.bytesToString();
      final data = json.decode(responseString);

      setState(() {
        dataShippingPrice = data;
        cost = data['cost'].toString();
        weightPrice = data['weightprice'].toString();
        shippingPrice = data['shipping_price'].toString();
        totalPrice = data['total_price'].toString();
      });

      // Show Dialog
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: AppColors.white,
                                        titlePadding: const EdgeInsets.all(
                                          10.0,
                                        ),
                                        title: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            dialog__container(
                                              'التكلفة',
                                              '${data['cost']}',
                                              AppColors.container_primarycolor,
                                              AppColors.primaryColor,
                                                  'assets/images/icons/sack-dollar.svg',
                                            ),
                                            SizedBox(width: 5),
                                            dialog__container(
                                              'تكلفة الوزن',
                                              '${data['weightprice']}',
                                              AppColors.container_redcolor,
                                              AppColors.red,
                                               'assets/images/icons/scale.svg',
                                            ),
                                            SizedBox(width: 5),
                                            dialog__container(
                                              'سعر الشحن',
                                              '${data['shipping_price']}',
                                              AppColors.container_pinkcolor,
                                              AppColors.pink,
                                               'assets/images/icons/calculator-money.svg',
                                            ),
                                            SizedBox(width: 5),
                                            dialog__container(
                                              ' المجموع',
                                              '${data['total_price']}',
                                              AppColors.container_yellowcolor,
                                              AppColors.yellow,
                                               'assets/images/icons/calculator-bill.svg',
                                            ),
                                          ],
                                        ),
                                        content: const Text(
                                          "هل أنت متأكد من هذا الإجراء؟",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontFamily: 'cairo',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            child: const Text("إلغاء",
                                              style: TextStyle(
                                                fontFamily: 'cairo',
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.primaryColor,
                                              )),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColors.primaryColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8.0),
                                              ),
                                            ),
                                            child: const Text("نعم",
                                              style: TextStyle(
                                                fontFamily: 'cairo',
                                                fontWeight: FontWeight.bold,
                                                color: AppColors.white,
                                              )),
                                            onPressed: () {
                                              sendrequest();
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                    } else {
      print(response.reasonPhrase);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: AppColors.primaryColor,
          content: Text('حدث خطأ أثناء ارسال الطلب ',
              style: TextStyle(color: AppColors.white)),),
      );
    }
  }

  @override
  void dispose() {
    _controller_price.dispose();
    _controller_weight.dispose();
    super.dispose();
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
            'إضافة اوردر',
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            child: Column(
              children: [
                TexxtFormFeild(
                  'اسم الشركة',
                  _controller_name_company,
                  (value) => null,
                  _isReadOnly,
                  null,
                            TextInputType.name,
                            1,
                            AppColors.red,
                            const Icon(Icons.star, size: 10),
                          ),
                          const SizedBox(height: 10),
                          TexxtFormFeild(
                            'الرقم المرجعي للراسل',
                            _controller_name_reference_number,
                            (value) => null,
                            false,
                            null,
                            TextInputType.number,
                            1,
                            AppColors.text_gray_Dark,
                            const Icon(Icons.star, size: 10),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: OpeningOrder(
                                  onSelectionChanged: _handleSelectionChanged,
                                ),
                              ),
                              SizedBox(width: 7),
                              Expanded(
                                child: TypeServices(
                                  onSelectionChanged:
                                      _handleSelectionChanged_typeservice,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          TexxtFormFeild(
                            'اسم العميل',
                            _controller_client_name,
                            (value) {
                              if (value == null || value.isEmpty) {
                                return 'ادخل اسم العميل ';
                              }
                              return null;
                            },
                            false,
                            null,
                            TextInputType.name,
                            1,
                            AppColors.red,
                            const Icon(Icons.star, size: 10),
                          ),
                          const SizedBox(height: 10),
                          TexxtFormFeild(
                            ' اسم الراسل',
                            _controller_sender_name,
                            (value) {
                              return null;
                            },
                            false,
                            null,
                            TextInputType.name,
                            1,
                            AppColors.text_gray_Dark,
                            const Icon(Icons.star, size: 10),
                          ),
                          const SizedBox(height: 10),
                          TexxtFormFeild(
                            'رقم الهاتف الاول',
                            _controller_phone_number_one,
                            (value) {
                              if (value == null || value.isEmpty) {
                                return 'ادخل رقم الهاتف الاول من فضلك';
                              }
                              return null;
                            },
                            false,
                            null,
                            TextInputType.number,
                            1,
                            AppColors.red,
                            const Icon(Icons.star, size: 10),
                          ),
                          const SizedBox(height: 10),
                          TexxtFormFeild(
                            'رقم الهاتف الثاني',
                            _controller_phone_number_two,
                            (value) {
                              return null;
                            },
                            false,
                            null,
                            TextInputType.number,
                            1,
                            AppColors.text_gray_Dark,
                            const Icon(Icons.star, size: 10),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: GovernateDropdown(
                                  controller: _controller_governate,
                                  onSelectionChanged: (value) {
                                    setState(() {
                                      gaovernateValue =
                                          value; // تحديث ID المحافظة
                                      centerValue = null;
                                      sowshowCenters(); // إعادة تعيين المركز لإجبار إعادة البناء
                                    });
                                  },
                                ),
                              ),
                              const SizedBox(width: 7),
                              if (isVisible)
                                Expanded(
                                  child: CentersDropdown(
                                    controller: _controller_center,
                                    gavernate_id:
                                        gaovernateValue, // تمرير ID المحافظة
                                    onSelectionChanged: (value) {
                                      setState(() {
                                        centerValue = value;
                                      });
                                    },
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          TexxtFormFeild(
                            'العنوان',
                            _controller_address,
                            (value) {
                              if (value == null || value.isEmpty) {
                                return 'ادخل العنوان من فضلك';
                              }
                              return null;
                            },
                            false,
                            null,
                            TextInputType.streetAddress,
                            4,
                            AppColors.red,
                            const Icon(Icons.star, size: 10),
                          ),
                          const SizedBox(height: 10),
                          TexxtFormFeild(
                            'السعر',
                            _controller_price,
                            (value) {
                              if (value == null || value.isEmpty) {
                                return 'ادخل السعر من فضلك';
                              }
                              return null;
                            },
                            false,
                            null,
                            TextInputType.number,
                            1,
                            AppColors.red,
                            const Icon(Icons.star, size: 10),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: TexxtFormFeild(
                                  'اسم المنتج',
                                  _controller_prouduct_name,
                                  (value) {
                                    return null;
                                  },
                                  false,
                                  null,
                                  TextInputType.text,
                                  1,
                                  AppColors.text_gray_Dark,
                                  const Icon(Icons.star, size: 10),
                                ),
                              ),
                              const SizedBox(width: 7),
                              Expanded(
                                child: TexxtFormFeild(
                                  'الوزن',
                                  _controller_weight,
                                  (value) {
                                    return null;
                                  },
                                  false,
                                  null,
                                  TextInputType.number,
                                  1,
                                  AppColors.text_gray_Dark,
                                  const Icon(Icons.star, size: 10),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          TexxtFormFeild(
                            'الملاحظات',
                            _controller_notes,
                            (value) {
                              return null;
                            },
                            false,
                            null,
                            TextInputType.text,
                            3,
                            AppColors.text_gray_Dark,
                            const Icon(Icons.star, size: 10),
                          ),
                          const SizedBox(height: 10),
                          TexxtFormFeild(
                            'تعليمات خاصه',
                            _controller_instructions,
                            (value) {
                              return null;
                            },
                            false,
                            null,
                            TextInputType.text,
                            3,
                            AppColors.text_gray_Dark,
                            const Icon(Icons.star, size: 10),
                          ),
                          const SizedBox(height: 10),
                          TexxtFormFeild(
                            'رقم البطاقة',
                            _controller_identy_number,
                            (value) {
                              return null;
                            },
                            false,
                            null,
                            TextInputType.number,
                            3,
                            AppColors.text_gray_Dark,
                            const Icon(Icons.star, size: 10),
                          ),
                          const SizedBox(height: 10),
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
                                  if (centerValue != null &&
                                      gaovernateValue != null) {
                                    _loadShippingPrice();
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
                                    'assets/images/icons/box-alt.svg',
                                    colorFilter: const ColorFilter.mode(
                                      AppColors.white,
                                      BlendMode.srcIn,
                                    ),
                                    width: 20,
                                    height: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  const Text(
                                    'إضافة الطلب',
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

Widget dialog__container(
  String title,
  String content,
  Color color,
  Color iconColor,
  String icon,
) {
  return Container(
    width: 65,
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          icon,
          colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
          width: 14,
          height: 14,
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            fontFamily: 'cairo',
          ),
        ),
        const SizedBox(height: 3),
        Text(
          content,
          style: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            fontFamily: 'cairo',
          ),
        ),
      ],
    ),
  );
}
