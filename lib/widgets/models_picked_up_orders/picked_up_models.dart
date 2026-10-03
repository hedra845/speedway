import 'package:flutter/material.dart';
import 'package:sender/conponantes/constantes/colores.dart';
import 'package:sender/widgets/model_orders/titled_container.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ClassListviewpickup extends StatelessWidget {
  const ClassListviewpickup({
    super.key,
    required this.name,
    required this.address,
    required this.date,
    required this.notes,
    required this.number_of_orders,
    required this.order_id,
    required this.vichele_type,
    required this.phone,
    required this.price,
    required this.state_order,
    required this.color_state,
  });

  final String name;
  final String date;
  final String state_order;
  final String order_id;
  final String address;
  final String phone;
  final String notes;
  final dynamic price;
  final String vichele_type;
  final String number_of_orders;
  final Color color_state;


  @override
  Widget build(BuildContext context) {
    ThemeData(fontFamily: 'cairo');
    final labelStyle = const TextStyle(
      color: AppColors.black,
      fontSize: 16,
      fontWeight: FontWeight.bold,
      fontFamily: 'cairo',
    );

    final valueStyle = const TextStyle(
      color: AppColors.black,
      fontSize: 15,
      fontWeight: FontWeight.bold,
      fontFamily: 'cairo',
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
      child: TitledContainer(
        titleText_left: date,
        titleText_right: name,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _StateBadge(state_order, color_state),
                Row(
                  children: [
                    Text(order_id, style: valueStyle),
                    const SizedBox(width: 5),
                    _IconBadge('assets/images/icons/Icon_box.svg'),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            _ContactRow(color_state),
            _InfoRow(':رقم الهاتف', phone.toString(), labelStyle, TextStyle(
      color: AppColors.black,
      fontSize: 15,
      fontWeight: FontWeight.bold,
      fontFamily: 'cairo',
    ),),
            _Divider(),
            _InfoRow(':العنوان', address, labelStyle, TextStyle(
      color: AppColors.black,
      fontSize: 15,
      fontWeight: FontWeight.bold,
      fontFamily: 'cairo',
    ),),
            _Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _InfoRow(':السعر', price.toString(), labelStyle, TextStyle(
      color: AppColors.black,
      fontSize: 15,
      fontWeight: FontWeight.bold,
      fontFamily: 'cairo',
    ),),
                _InfoRow(':نوع المركبة', vichele_type, labelStyle, TextStyle(
      color: AppColors.black,
      fontSize: 15,
      fontWeight: FontWeight.bold,
      fontFamily: 'cairo',
    ),),
              ],
            ),
            _Divider(),
            _InfoRow(': عدد الشحنات ', number_of_orders, labelStyle, TextStyle(
      color: AppColors.black,
      fontSize: 15,
      fontWeight: FontWeight.bold,
      fontFamily: 'cairo',
    ),),
            _Divider(),
            _InfoRow(': ملحوظة  ', notes, labelStyle, TextStyle(
      color: AppColors.black,
      fontSize: 15,
      fontWeight: FontWeight.bold,
      fontFamily: 'cairo',
    ),),
            const SizedBox(height: 10),
            _MainActionButton(state_order, color_state),
          ],
        ),
      ),
    );
  }

  Widget _StateBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 12,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _IconBadge(String assetPath) {
    return Container(
      padding: const EdgeInsets.all(3),
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        color: color_state,
        borderRadius: BorderRadius.circular(5),
      ),
      child: SvgPicture.asset(
        assetPath,
        width: 16,
        height: 16,
        color: AppColors.white,
      ),
    );
  }

  Widget _ContactRow(Color color) {
    return Row(
      children: [
        _iconAction('sms:+2$phone?body=Hello', 'assets/images/icons/Icon_message.svg', color),
        _iconAction('https://wa.me/$phone?text=Hello', 'assets/images/icons/send-01.svg', color),
        _iconAction('tel://$phone', 'assets/images/icons/phone-call-01.svg', color),
      ],
    );
  }

  Widget _iconAction(String url, String asset, Color color) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0),
      child: GestureDetector(
        onTap: () async {
          if (await canLaunchUrlString(url)) {
            await launchUrlString(url);
          } else {
            debugPrint('Cannot launch $url');
          }
        },
        child: SvgPicture.asset(asset, color: color, width: 20, height: 20),
      ),
    );
  }

  Widget _InfoRow(String label, String value, TextStyle labelStyle, TextStyle valueStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(child: Text(value, style: TextStyle(
      color: AppColors.black,
      fontSize: 15,
      fontWeight: FontWeight.bold,
      fontFamily: 'cairo',
    ),)),
        const SizedBox(width: 6),
        Text(label, style: labelStyle),
      ],
    );
  }

  Widget _Divider() {
    return Divider(height: 5, color: AppColors.text_gray.withOpacity(0.1));
  }

  Widget _MainActionButton(String label, Color color) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'cairo',
        ),
      ),
    );
  }
}
