import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svg_flutter/svg.dart';
import 'package:sender/config/Strings.dart';
import 'package:sender/conponantes/constantes/colores.dart';
import 'package:sender/widgets/models_picked_up_orders/picked_up_models.dart';

class PickedUpOrders extends StatefulWidget {
  const PickedUpOrders({super.key});

  @override
  State<PickedUpOrders> createState() => _PickedUpOrdersState();
}

class _PickedUpOrdersState extends State<PickedUpOrders> {
  List<dynamic> orders = [];
  bool isLoading = true;
  Color _savedColor = AppColors.orange;
  final _storage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _loadColor();
    fetchOrders();
  }

  Future<void> _loadColor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? colorValue = prefs.getInt('selectedColor_ColorSelector_for_pickups');
    setState(() {
      _savedColor = colorValue != null ? Color(colorValue) : AppColors.orange;
    });
  }

Future<void> fetchOrders() async {
  setState(() {
    isLoading = true;
  });

  try {
    const url = Apis.pickup_orders;
    String? token = await _storage.read(key: 'token');

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept-Charset': 'utf-8', // (اختياري) لضمان استقبال UTF-8
      },
    );

    if (response.statusCode == 200) {
      // ✅ فك الترميز بشكل صحيح
      final Map<String, dynamic> jsonData =
          json.decode(utf8.decode(response.bodyBytes));

      if (jsonData.containsKey('pickups')) {
        final List<dynamic> pickupList = jsonData['pickups'];

        setState(() {
          orders = pickupList;
          isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('المفتاح "pickups" غير موجود في الاستجابة')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('فشل الاتصال: ${response.statusCode}')),
      );
    }
  } catch (e) {
    setState(() {
      isLoading = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('حدث خطأ أثناء تحميل الطلبات')),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    ThemeData(fontFamily: 'cairo');
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        shadowColor: AppColors.text_gray_Dark.withOpacity(0.1),
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset('assets/images/icons/arrow-left.svg'),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications_on_outlined,
              color: AppColors.black.withOpacity(0.5),
            ),
          ),
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'البيك اب',
              style: TextStyle(
                color: AppColors.text_gray_Dark,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              "${orders.length} اجمالي الطلبات",
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: AppColors.text_gray_Dark,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        color: _savedColor,
        backgroundColor: AppColors.white,
        onRefresh: fetchOrders,
        child: Container(
          color: AppColors.white,
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: _savedColor,
                  ),
                )
              : orders.isEmpty
                  ? const Center(child: Text('لا توجد طلبات حالياً'))
                  : ListView.builder(
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        return ClassListviewpickup(
                          name: order['name_client'],
                          price: order['TotalPrice'].toString(),
                          phone: order['phone'].toString(),
                          date: order['date'].toString(),
                          address: order['address'].toString(),
                          order_id: order['id_police'].toString(),
                          vichele_type: order['special_intructions'].toString(),
                          notes: order['notes'].toString(),
                          number_of_orders: order['name_product'].toString(),
                          state_order: order['service_type_name'],
                          color_state:  _savedColor,
                        );
                      },
                    ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        splashColor: AppColors.white,
        onPressed: fetchOrders,
        backgroundColor: AppColors.white,
        child: Icon(
          Icons.refresh,
          color: _savedColor,
        ),
      ),
    );
  }
}
