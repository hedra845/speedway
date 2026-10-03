import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sender/config/Strings.dart';
import 'package:sender/conponantes/constantes/colores.dart';
import 'package:sender/presentaion/assigned/assigned.dart';
import 'package:sender/presentaion/on_the_way/on_way_orders.dart';
import 'package:sender/presentaion/orders/orders.dart';
import 'package:sender/presentaion/orders_delivered/orders_delivered.dart';
import 'package:sender/presentaion/orders_notDelivered/orders_notDelivered.dart';
import 'package:sender/presentaion/orders_onArchieve/orders_onArchieve.dart';
import 'package:sender/presentaion/orders_onCompany/orders_onCompany.dart';
import 'package:sender/presentaion/orders_redeliver/orders_redeliver.dart';
import 'package:sender/presentaion/orders_returned/orders_returned.dart';
import 'package:sender/presentaion/orders_returnedToSender/orders_returnedToSender.dart';
import 'package:sender/presentaion/pickups/picked_up_orders.dart';
import 'package:sender/widgets/drawer_model/drawer.dart';
import 'package:sender/widgets/models_home/bottomnavigationbar.dart';
import 'package:sender/widgets/models_home/dialogchart.dart';
import 'package:svg_flutter/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class Home_page extends StatefulWidget {
  const Home_page({super.key});

  @override
  State<Home_page> createState() => _Home_pageState();
}

class _Home_pageState extends State<Home_page> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static const _storage = FlutterSecureStorage();

  String? companyName;
  int? balance;
  int? ordersInWay;
  int? deliveryOrders;
  int? pickupOrders;
  int? waitingorders;
  int? delayedorders;
  int? returnedorders;
  int? pendingOrders;
  int? allOrders;
  int? ordersReadyToSupply;
  int? allOrdersCost;
  int? oncompanyorders;
  int? ondelegateorders;
  int? onarchieveorders;
  int? returnedtosender;

  List<Map<String, dynamic>> staticsList = [];

  @override
  void initState() {
    super.initState();
    _loadCompanyName();
    _fetchAndLoad();
  }

  Future<void> _loadCompanyName() async {
    try {
      final name = await _storage.read(key: 'name');
      if (name != null && mounted) {
        setState(() {
          companyName = name;
        });
      }
    } catch (_) {}
  }

  Future<void> _fetchAndLoad() async {
    try {
      String? token = await _storage.read(key: 'token');
      final headers = {'Authorization': 'Bearer $token'};
      final uri = Uri.parse(Apis.statics);
      final response = await http.get(uri, headers: headers);

      if (response.statusCode == 200) {
        final jsonMap = json.decode(response.body) as Map<String, dynamic>;
        if (!mounted) return;
        setState(() {
          balance = jsonMap['balance'];
          ordersInWay = jsonMap['ordersinway'];
          deliveryOrders = jsonMap['deliveryorders'];
          pickupOrders = jsonMap['pickuporders'];
          returnedorders = jsonMap['returnedorders'];
          waitingorders = jsonMap['waitingorders'];
          delayedorders = jsonMap['delayedorders'];
          pendingOrders = jsonMap['pendingorders'];
          allOrders = jsonMap['allorders'];
          ordersReadyToSupply = jsonMap['ordersreadytosupply'];
          allOrdersCost = jsonMap['allorderscost'];
          oncompanyorders = jsonMap['oncompanyorders'];
          ondelegateorders = jsonMap['ondelegateorders'];
          onarchieveorders = jsonMap['onarchieveorders'];
          returnedtosender = jsonMap['returnedtosender'];

          if (jsonMap['statics'] != null) {
            staticsList = (jsonMap['statics'] as List<dynamic>).cast<Map<String, dynamic>>();
          }
        });
      }
    } catch (_) {
      // ignore network errors
    }
  }

  Future<void> _openWhatsAppSupport() async {
    final uri = Uri.parse("https://wa.me/${data.company_number}?text=${Uri.encodeComponent('أريد مساعدة')}");
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        await launchUrl(uri);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: AppColors.background,
        drawer: const DrawerFb1(),
        appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          toolbarHeight: 62,
          titleSpacing: 6,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(1),
            child: Container(
              color: const Color(0xFFF1F5F9),
              height: 1,
            ),
          ),
          leadingWidth: 52,
          leading: Container(
            margin: const EdgeInsets.only(right: 12),
            child: Center(
              child: InkWell(
                onTap: () => _scaffoldKey.currentState?.openDrawer(),
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  width: 38,
                  height: 38,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.container_primarycolor.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Transform.flip(
                    flipX: true,
                    child: SvgPicture.asset(
                      'assets/images/icons/Icon_menu.svg',
                      colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            ),
          ),
          title: Row(
            children: [
              Image.asset(
                'assets/images/images/app_logo.png',
                height: 20,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
              ),
              const SizedBox(width: 8),
              Container(
                height: 22,
                width: 1.2,
                color: const Color(0xFFE2E8F0),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      companyName != null && companyName!.isNotEmpty
                          ? companyName!
                          : 'الصفحة الرئيسية',
                      style: const TextStyle(
                        fontFamily: 'cairo',
                        color: Color(0xFF0F172A),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        height: 1.15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 1),
                    const Text(
                      'لوحة المتابعة والتحكم',
                      style: TextStyle(
                        fontFamily: 'cairo',
                        color: Color(0xFF64748B),
                        fontSize: 10.5,
                        fontWeight: FontWeight.w600,
                        height: 1.15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            Container(
              margin: const EdgeInsets.only(left: 12),
              child: Center(
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, '/notifications_page'),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    width: 38,
                    height: 38,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.container_primarycolor.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.notifications_none_rounded,
                      color: AppColors.primaryColor,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        body: RefreshIndicator(
          color: AppColors.primaryColor,
          backgroundColor: AppColors.white,
          onRefresh: _fetchAndLoad,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Financial Cards (بنفس ألوان التطبيق الأصلية: Purple & PrimaryColor)
                Row(
                  children: [
                    // البطاقة الأولى: فلوس التوريدة القادمة (AppColors.purple)
                    Expanded(
                      child: _buildTopFinancialCard(
                        title: 'فلوس التوريدة القادمة',
                        amount: '${balance ?? 0}',
                        subtitle: 'جاهز للتوريد: ${ordersReadyToSupply ?? 0}',
                        primaryColor: AppColors.purple,
                        gradientEndColor: const Color(0xFF4F5FE3),
                        iconPath: 'assets/images/icons/Icon_box.svg',
                      ),
                    ),
                    const SizedBox(width: 10),
                    // البطاقة الثانية: مجموع الاوردرات (AppColors.primaryColor)
                    Expanded(
                      child: _buildTopFinancialCard(
                        title: 'مجموع الاوردرات',
                        amount: '${allOrdersCost ?? 0}',
                        subtitle: 'إجمالي: ${allOrders ?? 0} طرد',
                        primaryColor: AppColors.primaryColor,
                        gradientEndColor: AppColors.secondaryColor,
                        iconPath: 'assets/images/icons/Icon_total_collected.svg',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // شريط طرود البيك اب والطرود الجاهزة للتوريد (بطاقتان جنب بعض بتصميم أنيق)
                Row(
                  children: [
                    // طرود البيك اب
                    Expanded(
                      child: _buildQuickActionCard(
                        title: 'طرود البيك اب',
                        count: '${pickupOrders ?? 0}',
                        iconPath: 'assets/images/icons/Icon_van.svg',
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const PickedUpOrders(),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    // الطرود الجاهزة للتوريد
                    Expanded(
                      child: _buildQuickActionCard(
                        title: 'جاهز للتوريد',
                        count: '${ordersReadyToSupply ?? 0}',
                        iconPath: 'assets/images/icons/supply-chain-steps.svg',
                        onTap: null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // عنوان القسم مع شارة التعداد
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 16,
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'حالات الشحنات',
                          style: TextStyle(
                            fontFamily: 'cairo',
                            fontSize: 14.5,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.container_primarycolor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'إجمالي: ${allOrders ?? 0}',
                        style: const TextStyle(
                          fontFamily: 'cairo',
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // شبكة بطاقات الحالات (بالألوان الأصلية تماماً: container_*color و *color)
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.30,
                  children: [
                    _buildOriginalStatusCard(
                      title: 'اجمالي الطرود',
                      count: '${allOrders ?? 0}',
                      iconPath: 'assets/images/icons/Icon_box_total_orders.svg',
                      bgColor: AppColors.container_primarycolor,
                      iconAndNumberColor: AppColors.primaryColor,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Orders()),
                      ),
                    ),
                    _buildOriginalStatusCard(
                      title: 'لم يتم الاستلام',
                      count: '${waitingorders ?? 0}',
                      iconPath: 'assets/images/icons/time-forward.svg',
                      bgColor: AppColors.container_redcolor,
                      iconAndNumberColor: AppColors.red,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const OrdersNotdelivered()),
                      ),
                    ),
                    _buildOriginalStatusCard(
                      title: 'بالمقر',
                      count: '${oncompanyorders ?? 0}',
                      iconPath: 'assets/images/icons/house-chimney.svg',
                      bgColor: AppColors.container_pinkcolor,
                      iconAndNumberColor: AppColors.pink,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const OrdersOncompany()),
                      ),
                    ),
                    _buildOriginalStatusCard(
                      title: 'مع المندوب',
                      count: '${ondelegateorders ?? 0}',
                      iconPath: 'assets/images/icons/delivery-man.svg',
                      bgColor: AppColors.container_yellowcolor,
                      iconAndNumberColor: AppColors.orange,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const OnWayOrders()),
                      ),
                    ),
                    _buildOriginalStatusCard(
                      title: 'تم التسليم',
                      count: '${deliveryOrders ?? 0}',
                      iconPath: 'assets/images/icons/box-circle-check.svg',
                      bgColor: AppColors.container_purplecolor,
                      iconAndNumberColor: AppColors.purple,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const Ordersdelivered()),
                      ),
                    ),
                    _buildOriginalStatusCard(
                      title: 'مرتجع',
                      count: '${returnedorders ?? 0}',
                      iconPath: 'assets/images/icons/restock.svg',
                      bgColor: AppColors.container_greencolor,
                      iconAndNumberColor: AppColors.green,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const OrdersReturned()),
                      ),
                    ),
                    _buildOriginalStatusCard(
                      title: 'مرتجع للراسل',
                      count: '${returnedtosender ?? 0}',
                      iconPath: 'assets/images/icons/undo.svg',
                      bgColor: AppColors.container_black_pinkcolor,
                      iconAndNumberColor: AppColors.black_pink,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const OrdersReturnedtosender()),
                      ),
                    ),
                    _buildOriginalStatusCard(
                      title: 'الارشيف',
                      count: '${onarchieveorders ?? 0}',
                      iconPath: 'assets/images/icons/box_archive.svg',
                      bgColor: AppColors.container_black_bluecolor,
                      iconAndNumberColor: AppColors.black_blue,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const OrdersOnarchieve()),
                      ),
                    ),
                    _buildOriginalStatusCard(
                      title: 'اعادة التوصيل',
                      count: '${delayedorders ?? 0}',
                      iconPath: 'assets/images/icons/re_deliverd.svg',
                      bgColor: AppColors.container_skybluecolor,
                      iconAndNumberColor: AppColors.skyblue,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const OrdersRedeliver()),
                      ),
                    ),
                    _buildOriginalStatusCard(
                      title: 'المخزن',
                      count: '${oncompanyorders ?? 0}',
                      iconPath: 'assets/images/icons/shop.svg',
                      bgColor: AppColors.container_orangecolor,
                      iconAndNumberColor: AppColors.orange,
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => const OrdersOncompany()),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // الأزرار السفلية بالألوان الأصلية (المعلقة: primaryColor | احصائيات: orange)
                Row(
                  children: [
                    // المعلقة
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const Ordersassigned(),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AppColors.primaryColor, AppColors.secondaryColor],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryColor.withOpacity(0.28),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/icons/icon_box_assigned_orders.svg',
                                      colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                                      width: 18,
                                      height: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'المعلقة',
                                      style: TextStyle(
                                        color: AppColors.white,
                                        fontFamily: 'cairo',
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: AppColors.white.withOpacity(0.22),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    '${pendingOrders ?? 0}',
                                    style: const TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      fontFamily: 'cairo',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // احصائيات
                    Expanded(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => Dialog.fullscreen(
                                backgroundColor: AppColors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        const SizedBox(height: 10),
                                        const PieChartSample2(),
                                        const SizedBox(height: 24),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.primaryColor,
                                            foregroundColor: Colors.white,
                                            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text(
                                            'إغلاق',
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: 'cairo',
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [AppColors.orange, Color(0xFFFFAE33)],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.orange.withOpacity(0.28),
                                  blurRadius: 8,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/icons/chart-pie.svg',
                                  colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                                  width: 18,
                                  height: 18,
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'الإحصائيات',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontFamily: 'cairo',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 70),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const Bottomnavigationbar(currentIndex: 0),
        floatingActionButton: FloatingActionButton.small(
          backgroundColor: AppColors.primaryColor,
          elevation: 3,
          onPressed: _openWhatsAppSupport,
          tooltip: 'الدعم الفني',
          child: const Icon(
            Icons.support_agent_rounded,
            color: Colors.white,
            size: 22,
          ),
        ),
      ),
    );
  }

  // بطاقات التوريدة ومجموع الأوردرات بالألوان الأصلية الكاملة مع لمسة عصرية ناعمة
  Widget _buildTopFinancialCard({
    required String title,
    required String amount,
    required String subtitle,
    required Color primaryColor,
    required Color gradientEndColor,
    required String iconPath,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, gradientEndColor],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(0.25),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 26,
                height: 26,
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.22),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  iconPath,
                  colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                ),
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'cairo',
                    color: AppColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 7),
          Center(
            child: Text(
              '$amount ج.م',
              style: const TextStyle(
                fontFamily: 'cairo',
                color: AppColors.white,
                fontWeight: FontWeight.w800,
                fontSize: 19,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 7),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.white.withOpacity(0.18),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                subtitle,
                style: const TextStyle(
                  fontFamily: 'cairo',
                  color: AppColors.white,
                  fontSize: 10.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // بطاقات الإجراء السريع (بيك اب / جاهز للتوريد) بتصميم نظيف ومتناسق
  Widget _buildQuickActionCard({
    required String title,
    required String count,
    required String iconPath,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.primaryColor.withOpacity(0.18),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.container_primarycolor.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: SvgPicture.asset(
                      iconPath,
                      colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF1E293B),
                      fontFamily: 'cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Container(
                constraints: const BoxConstraints(minWidth: 28),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.container_primarycolor,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  count,
                  style: const TextStyle(
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13.5,
                    fontFamily: 'cairo',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // بطاقة الحالة الأصلية بالخلفية الباستيل ولون الأيقونة والرقم الأصلي
  Widget _buildOriginalStatusCard({
    required String title,
    required String count,
    required String iconPath,
    required Color bgColor,
    required Color iconAndNumberColor,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: iconAndNumberColor.withOpacity(0.2),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: iconAndNumberColor.withOpacity(0.04),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 36,
                height: 36,
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: AppColors.white.withOpacity(0.7),
                  shape: BoxShape.circle,
                ),
                child: SvgPicture.asset(
                  iconPath,
                  colorFilter: ColorFilter.mode(iconAndNumberColor, BlendMode.srcIn),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12.5,
                  fontFamily: 'cairo',
                  color: Color(0xFF1E293B),
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 2),
              Text(
                count,
                style: TextStyle(
                  color: iconAndNumberColor,
                  fontSize: 19,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'cairo',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
