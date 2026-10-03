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
import 'package:svg_flutter/svg.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class Ordersdelivered extends StatefulWidget {
  final String? search_scan;
  const Ordersdelivered({super.key, this.search_scan});

  @override
  _OrdersdeliveredState createState() => _OrdersdeliveredState();
}

const _storage = FlutterSecureStorage();

class _OrdersdeliveredState extends State<Ordersdelivered> {
  int _pageSize = 0;
  final PagingController<int, dynamic> _pagingController =
      PagingController(firstPageKey: 1);
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> allOrders = [];
  int _ordersCount = 0;

  @override
  void initState() {
    super.initState();

    _pagingController.addPageRequestListener((pageKey) {
      _fetchOrders(pageKey);
    });


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
      var response = await dio.post(Apis.orders_delivered,
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


  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        shadowColor: AppColors.text_gray_Dark.withOpacity(0.1),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset('assets/images/icons/arrow-left.svg'),
        ),
        actions: [
          SizedBox(
            width: 130,
                     height: 50,
            child: TextFormField(
              onChanged: _filterOrders,
              controller: _searchController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search,
                    color: AppColors.text_gray, size: 20),
                fillColor: const Color(0xFFF5F6F9),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                hintText: 'بحث',
                hintStyle: const TextStyle(
                    fontFamily: 'cairo',
                    fontSize: 14.0,
                    color: AppColors.text_gray_Dark),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.text_gray)),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.text_gray)),
              ),
              textAlign: TextAlign.right,
              style: const TextStyle(fontFamily: 'cairo'),
            ),
          ),
          IconButton(
            onPressed: () async {
              final scannedValue = await Navigator.push<String>(
                context,
                MaterialPageRoute(
                    builder: (context) => const BarcodeScannerScreen()),
              );

              if (scannedValue != null && scannedValue.isNotEmpty) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Ordersdelivered(search_scan: scannedValue),
                  ),
                );
              }
            },
            icon: SvgPicture.asset('assets/images/icons/qr-scan.svg',
                color: AppColors.purple),
          ),
        ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('تم التسليم',
                style: TextStyle(
                    fontFamily: 'cairo',
                    color: AppColors.text_gray_Dark,
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            Text("عدد الطرود ($_ordersCount)",
                style: const TextStyle(
                    fontFamily: 'cairo',
                    fontWeight: FontWeight.normal,
                    color: AppColors.text_gray_Dark,
                    fontSize: 10)),
          ],
        ),
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
                color: AppColors.purple,
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
                          color: AppColors.purple,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            firstPageProgressIndicatorBuilder: (_) =>
                Center(child: CircularProgressIndicator(color: AppColors.purple,)),
            newPageProgressIndicatorBuilder: (_) =>
                Center(child: CircularProgressIndicator(color: AppColors.purple,)),
            noItemsFoundIndicatorBuilder: (_) => Center(
                child: Text(
              'لا يوجد طرود',
              style: TextStyle(
                  fontFamily: 'cairo',
                  fontWeight: FontWeight.normal,
                  color: AppColors.purple,
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
                        color: AppColors.purple,
                        fontSize: 15),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.purple,
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
        child: Icon(Icons.refresh, color: AppColors.purple,),
      ),
    );
  }
}
