import 'package:flutter/material.dart';
import 'package:sender/conponantes/constantes/colores.dart';
import 'package:sms_mms/sms_mms.dart';
import 'package:svg_flutter/svg_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ClassListviewOrder extends StatefulWidget {
  const ClassListviewOrder({
    super.key,
    required this.name,
    required this.address,
    required this.date,
    required this.notes,
    required this.order_id,
    required this.phone,
    required this.price,
    required this.state_order,
    required this.color,
    required this.showdetails,
    required this.service_type,
  });

  final String name;
  final String date;
  final String state_order;
  final dynamic order_id;
  final String address;
  final dynamic phone;
  final String notes;
  final dynamic price;
  final String service_type;
  final Color color;
  final Function? showdetails;

  @override
  State<ClassListviewOrder> createState() => _ClassListviewOrderState();
}

class _ClassListviewOrderState extends State<ClassListviewOrder> {
  Future<void> _openWhatsApp(String phone) async {
    final cleanPhone = phone.replaceAll(RegExp(r'[^0-9+]'), '');
    final uri = Uri.parse("https://wa.me/$cleanPhone?text=مرحباً");
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Row 1: Status Badge & Order ID
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Text(
                  widget.state_order,
                  style: const TextStyle(
                    color: AppColors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'cairo',
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color: widget.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: SvgPicture.asset(
                      'assets/images/icons/Icon_box.svg',
                      width: 15,
                      height: 15,
                      colorFilter: ColorFilter.mode(widget.color, BlendMode.srcIn),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '#${widget.order_id}',
                    style: const TextStyle(
                      color: Color(0xFF1E293B),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'cairo',
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Row 2: Address
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 18,
                color: Color(0xFF64748B),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  widget.address.toString().trim(),
                  style: const TextStyle(
                    color: Color(0xFF334155),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'cairo',
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Row 3: Phone & Action Buttons (Call, WhatsApp, SMS)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.phone_outlined,
                      size: 16,
                      color: Color(0xFF64748B),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      widget.phone.toString(),
                      style: const TextStyle(
                        color: Color(0xFF334155),
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'cairo',
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    // Call Button
                    InkWell(
                      onTap: () => launchUrlString("tel://${widget.phone}"),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: widget.color.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          'assets/images/icons/phone-call.svg',
                          width: 16,
                          height: 16,
                          colorFilter: ColorFilter.mode(widget.color, BlendMode.srcIn),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // WhatsApp Button
                    InkWell(
                      onTap: () => _openWhatsApp(widget.phone.toString()),
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Color(0xFFE8F7EE),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          'assets/images/icons/send-01.svg',
                          width: 16,
                          height: 16,
                          colorFilter: const ColorFilter.mode(Color(0xFF25D366), BlendMode.srcIn),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // SMS Button
                    InkWell(
                      onTap: () async {
                        await SmsMms.send(
                          recipients: [(widget.phone.toString())],
                          message: 'مرحباً',
                        );
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: const Color(0xFF64748B).withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          'assets/images/icons/comment-alt.svg',
                          width: 16,
                          height: 16,
                          colorFilter: const ColorFilter.mode(Color(0xFF64748B), BlendMode.srcIn),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Row 4: Notes (if any)
          if (widget.notes.trim().isNotEmpty && widget.notes.trim() != 'null' && widget.notes.trim() != 'none') ...[
            const SizedBox(height: 6),
            Text(
              'ملاحظة: ${widget.notes.trim()}',
              style: const TextStyle(
                color: Color(0xFF64748B),
                fontSize: 12,
                fontFamily: 'cairo',
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: 10),
          const Divider(height: 1, thickness: 0.8, color: Color(0xFFF1F5F9)),
          const SizedBox(height: 10),

          // Row 5: Total Price & Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Price
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  const Text(
                    'الإجمالي: ',
                    style: TextStyle(
                      color: Color(0xFF64748B),
                      fontSize: 12,
                      fontFamily: 'cairo',
                    ),
                  ),
                  Text(
                    '${widget.price} ج.م',
                    style: TextStyle(
                      color: widget.color,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'cairo',
                    ),
                  ),
                ],
              ),
              // Service type tag
              if (widget.service_type.isNotEmpty && widget.service_type != 'null')
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: widget.color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: widget.color.withValues(alpha: 0.3)),
                  ),
                  child: Text(
                    widget.service_type,
                    style: TextStyle(
                      color: widget.color,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'cairo',
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),

          // Details Action Button
          SizedBox(
            width: double.infinity,
            height: 38,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                foregroundColor: widget.color,
                side: BorderSide(color: widget.color.withValues(alpha: 0.4), width: 1.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onPressed: () {
                if (widget.showdetails != null) {
                  widget.showdetails!();
                }
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'مشاهدة التفاصيل',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'cairo',
                    ),
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.arrow_back_ios_new_rounded, size: 13),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
