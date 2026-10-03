import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sender/config/Strings.dart';
import 'package:sender/conponantes/classes/class_data_details.dart';
import 'package:sender/conponantes/constantes/colores.dart';
import 'package:sender/presentaion/scanner/scanar_main_orders.dart';
import 'package:sender/widgets/model_orders/titled_container.dart';
import 'package:sender/widgets/model_orders/class_listview_order.dart';
import 'package:sender/presentaion/Details%20Order/details_order.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svg_flutter/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class Orders extends StatefulWidget {
  final String? search_scan;
  const Orders({super.key, this.search_scan});

  @override
  _OrdersState createState() => _OrdersState();
}

const _storage = FlutterSecureStorage();

class _OrdersState extends State<Orders> {
  int _pageSize = 0;
  final PagingController<int, dynamic> _pagingController =
      PagingController(firstPageKey: 1);
  Color _savedColor = AppColors.primaryColor;
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> allOrders = [];
  int _ordersCount = 0;

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((pageKey) {
      _fetchOrders(pageKey);
    });

    _loadColor();

    // ✅ بدء البحث مباشرة إن وُجد باركود
    if (widget.search_scan != null && widget.search_scan!.isNotEmpty) {
      _searchController.text = widget.search_scan!;
      Future.delayed(const Duration(milliseconds: 2000), () {
        _filterOrders(widget.search_scan!);
      });
    }
  }

  Future<void> _fetchOrders(int pageKey) async {
    String? token = await _storage.read(key: 'token');
    String? uid = await _storage.read(key: 'uid');
    String? valueSieze = await _storage.read(key: 'sized_all_orders');
    valueSieze ??= '15';
    _pageSize = int.parse(valueSieze);
    var headers = {'Authorization': 'Bearer $token'};
    var data =
        FormData.fromMap({'uid': uid, 'page': pageKey, 'size': _pageSize});

    var dio = Dio();
    try {
      var response = await dio.post(Apis.orders_url,
          data: data, options: Options(headers: headers));

      if (response.statusCode == 200) {
        final responseData = response.data;
        List<dynamic> newOrders = responseData['orders'];
        setState(() {
          _ordersCount = responseData['orders_count'] ?? 0;
        });

        final isLastPage = newOrders.length < _pageSize;
        if (isLastPage) {
          _pagingController.appendLastPage(newOrders);
        } else {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(newOrders, nextPageKey);
        }

        allOrders.addAll(newOrders);
        _filterOrders(_searchController.text);
      } else {
        _pagingController.error = response.statusMessage;
      }
    } catch (e) {
      _pagingController.error = e;
    }
  }

  void _filterOrders(String query) {
    if (query.isEmpty) {
      _pagingController.itemList = allOrders;
    } else {
      final filteredOrders = allOrders.where((order) {
        return order.values.any((value) =>
            value != null &&
            value.toString().toLowerCase().contains(query.toLowerCase()));
      }).toList();

      _pagingController.itemList = filteredOrders;
    }
  }

  Future<void> _loadColor() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int? colorValue = prefs.getInt('selectedColor_ColorSelector_for_home');
    setState(() {
      _savedColor =
          colorValue != null ? Color(colorValue) : AppColors.primaryColor;
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.white,
          surfaceTintColor: AppColors.white,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: Color(0xFF334155),
              size: 20,
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'كل الطرود',
                style: TextStyle(
                  fontFamily: 'cairo',
                  color: Color(0xFF1E293B),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                "عدد الطرود ($_ordersCount)",
                style: const TextStyle(
                  fontFamily: 'cairo',
                  fontWeight: FontWeight.normal,
                  color: Color(0xFF64748B),
                  fontSize: 11,
                ),
              ),
            ],
          ),
          actions: [
            SizedBox(
              width: 140,
              height: 40,
              child: TextFormField(
                onChanged: _filterOrders,
                controller: _searchController,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                style: const TextStyle(fontFamily: 'cairo', fontSize: 13),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF94A3B8), size: 18),
                  fillColor: const Color(0xFFF1F5F9),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'بحث...',
                  hintStyle: const TextStyle(
                    fontFamily: 'cairo',
                    fontSize: 12.0,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                final scannedValue = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(builder: (context) => const BarcodeScannerScreen()),
                );

                if (scannedValue != null && scannedValue.isNotEmpty) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Orders(search_scan: scannedValue),
                    ),
                  );
                }
              },
              icon: SvgPicture.asset(
                'assets/images/icons/qr-scan.svg',
                colorFilter: ColorFilter.mode(_savedColor, BlendMode.srcIn),
                width: 22,
                height: 22,
              ),
            ),
            const SizedBox(width: 4),
          ],
        ),
      body: Container(
        color: AppColors.white,
        child: PagedListView<int, dynamic>(
          pagingController: _pagingController,
          builderDelegate: PagedChildBuilderDelegate<dynamic>(
            itemBuilder: (context, order, index) => TitledContainer(
              titleText_right: "${order['name_client']}",
              titleText_left: "${order['date']}",
              child: ClassListviewOrder(
                name: "${order['name_client']}",
                price: order['cost'],
                phone: order['phone'],
                date: '${order['date']}',
                address: order['address'],
                order_id: order['id'],
                notes: '${order['notes']}',
                state_order: order['state_name'],
                service_type: order['service_type_name'],
                color: _savedColor,
                showdetails: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsOrder(
                        formDataDetails: FormDataDetails(
                          client_name: "${order['name_client']}",
                          order_id: "${order['id']}",
                          notes: "${order['notes']}",
                          address: order['address'],
                          date: "${order['date']}",
                          phone_number1: "${order['phone']}",
                          phone_number2: "${order['phone2']}",
                          total_price: "${order['cost']}",
                          sender_name: "${order['sender']}",
                          identity_number: "${order['identy_number']}",
                          city: "${order['governate_name']}",
                          zone: "${order['center_name']}",
                          police_number: "${order['id_police']}",
                          order_status: "${order['state_name']}",
                          Initial_instructions: "${order['special_intructions']}",
                          Final_instructions: "${order['special_intructions2']}",
                          color: _savedColor,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            firstPageProgressIndicatorBuilder: (_) =>
                Center(child: CircularProgressIndicator(color: _savedColor)),
            newPageProgressIndicatorBuilder: (_) =>
                Center(child: CircularProgressIndicator(color: _savedColor)),
            noItemsFoundIndicatorBuilder: (_) => Center(
                child: Text(
              'لا يوجد طرود',
              style: TextStyle(
                  fontFamily: 'cairo',
                  fontWeight: FontWeight.normal,
                  color: _savedColor,
                  fontSize: 15),
            )),
            firstPageErrorIndicatorBuilder: (_) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'هنالك خطا ما',
                    style: TextStyle(
                        fontFamily: 'cairo',
                        fontWeight: FontWeight.normal,
                        color: _savedColor,
                        fontSize: 15),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: _savedColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () => _pagingController.refresh(),
                    child: const Text(
                      'حاول مرة اخري',
                      style: TextStyle(
                          fontFamily: 'cairo',
                          fontWeight: FontWeight.normal,
                          color: AppColors.white,
                          fontSize: 15),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _pagingController.refresh(),
          backgroundColor: AppColors.white,
          child: Icon(Icons.refresh, color: _savedColor),
        ),
      ),
    );
  }
}
