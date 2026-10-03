import 'package:barcode_widget/barcode_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:sender/conponantes/classes/class_data_details.dart';
import 'package:sender/conponantes/constantes/colores.dart';
import 'package:sms_mms/sms_mms.dart';
import 'package:svg_flutter/svg.dart';
import 'package:url_launcher/url_launcher_string.dart';

// ignore: must_be_immutable
class DetailsOrder extends StatelessWidget {
  DetailsOrder({required this.formDataDetails, super.key});
  FormDataDetails formDataDetails = FormDataDetails();

  @override
  Widget build(BuildContext context) {
    final statusColor = (formDataDetails.color is Color)
        ? formDataDetails.color as Color
        : AppColors.primaryColor;

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
            onPressed: () => Navigator.pop(context),
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
            'تفاصيل الطرد',
            style: TextStyle(
              fontFamily: 'cairo',
              color: AppColors.text_gray_Dark,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Barcode Card
              Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.text_gray.withOpacity(0.18),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(color: statusColor, width: 4),
                      ),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(8),
                      dashPattern: const [4, 4],
                      color: AppColors.text_gray.withOpacity(0.35),
                      strokeWidth: 1.5,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Flexible(
                              child: BarcodeWidget(
                                barcode: Barcode.qrCode(),
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.text_gray.withOpacity(0.2),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                data: formDataDetails.police_number ?? "",
                                errorBuilder: (context, error) =>
                                    Center(child: Text(error)),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              child: BarcodeWidget(
                                barcode: Barcode.code128(
                                  useCode128A: true,
                                  useCode128B: true,
                                  useCode128C: true,
                                ),
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.text_gray.withOpacity(0.2),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                data: formDataDetails.police_number ?? "",
                                errorBuilder: (context, error) =>
                                    Center(child: Text(error)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 14),

              // Main Details Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.text_gray.withOpacity(0.18),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Header: Order ID and Date
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: statusColor.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: SvgPicture.asset(
                                'assets/images/icons/Icon_box.svg',
                                width: 16,
                                height: 16,
                                colorFilter: ColorFilter.mode(
                                  statusColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '#${formDataDetails.order_id ?? ""}',
                              style: const TextStyle(
                                color: AppColors.text_gray_Dark,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'cairo',
                              ),
                            ),
                          ],
                        ),
                        Text(
                          formDataDetails.date ?? "",
                          style: TextStyle(
                            color: AppColors.text_gray.withOpacity(0.9),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'cairo',
                          ),
                        ),
                      ],
                    ),

                    const Divider(height: 24, thickness: 1, color: Color(0xFFF1F5F9)),

                    // Status & Police Number
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'حالة الطلب',
                              style: TextStyle(
                                color: AppColors.text_gray,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'cairo',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: statusColor,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                formDataDetails.order_status ?? "",
                                style: const TextStyle(
                                  color: AppColors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'cairo',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SvgPicture.asset(
                                  'assets/images/icons/Icon_hach_number_order.svg',
                                  width: 14,
                                  height: 14,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.text_gray,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  'بوليصة الشحن',
                                  style: TextStyle(
                                    color: AppColors.text_gray,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'cairo',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              formDataDetails.police_number ?? "",
                              style: const TextStyle(
                                color: AppColors.text_gray_Dark,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'cairo',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const Divider(height: 24, thickness: 1, color: Color(0xFFF1F5F9)),

                    // Client Name & Total Price
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'العميل',
                              style: TextStyle(
                                color: AppColors.text_gray,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'cairo',
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              formDataDetails.client_name ?? "",
                              style: const TextStyle(
                                color: AppColors.text_gray_Dark,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'cairo',
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'الإجمالي',
                              style: TextStyle(
                                color: AppColors.text_gray,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'cairo',
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${formDataDetails.total_price ?? 0} ج.م',
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'cairo',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const Divider(height: 24, thickness: 1, color: Color(0xFFF1F5F9)),

                    // Phone 1 & Actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'رقم الهاتف الأول',
                              style: TextStyle(
                                color: AppColors.text_gray,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'cairo',
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              formDataDetails.phone_number1 ?? "",
                              textDirection: TextDirection.ltr,
                              style: const TextStyle(
                                color: AppColors.text_gray_Dark,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'cairo',
                              ),
                            ),
                          ],
                        ),
                        _buildContactActions(
                          context,
                          formDataDetails.phone_number1?.toString(),
                          statusColor,
                        ),
                      ],
                    ),

                    if (formDataDetails.phone_number2 != null &&
                        formDataDetails.phone_number2.toString().isNotEmpty) ...[
                      const Divider(height: 24, thickness: 1, color: Color(0xFFF1F5F9)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'رقم الهاتف الثاني',
                                style: TextStyle(
                                  color: AppColors.text_gray,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'cairo',
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                formDataDetails.phone_number2 ?? "",
                                textDirection: TextDirection.ltr,
                                style: const TextStyle(
                                  color: AppColors.text_gray_Dark,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'cairo',
                                ),
                              ),
                            ],
                          ),
                          _buildContactActions(
                            context,
                            formDataDetails.phone_number2?.toString(),
                            statusColor,
                          ),
                        ],
                      ),
                    ],

                    const Divider(height: 24, thickness: 1, color: Color(0xFFF1F5F9)),

                    // City & Zone
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'المحافظة',
                              style: TextStyle(
                                color: AppColors.text_gray,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'cairo',
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              formDataDetails.city ?? "",
                              style: const TextStyle(
                                color: AppColors.text_gray_Dark,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'cairo',
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              'المنطقة',
                              style: TextStyle(
                                color: AppColors.text_gray,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'cairo',
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              formDataDetails.zone ?? "",
                              style: const TextStyle(
                                color: AppColors.text_gray_Dark,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'cairo',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const Divider(height: 24, thickness: 1, color: Color(0xFFF1F5F9)),

                    // Address
                    Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/images/icons/Icon_point_location.svg',
                                width: 14,
                                height: 14,
                                colorFilter: const ColorFilter.mode(
                                  AppColors.primaryColor,
                                  BlendMode.srcIn,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                'العنوان',
                                style: TextStyle(
                                  color: AppColors.text_gray,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'cairo',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            formDataDetails.address ?? "",
                            textAlign: TextAlign.right,
                            style: const TextStyle(
                              color: AppColors.text_gray_Dark,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'cairo',
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (formDataDetails.notes != null &&
                        formDataDetails.notes.toString().isNotEmpty) ...[
                      const Divider(height: 24, thickness: 1, color: Color(0xFFF1F5F9)),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'ملاحظات',
                              style: TextStyle(
                                color: AppColors.text_gray,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'cairo',
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              formDataDetails.notes ?? "",
                              textAlign: TextAlign.right,
                              style: const TextStyle(
                                color: AppColors.text_gray_Dark,
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'cairo',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Additional Info Header
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: statusColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'بيانات إضافية',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'cairo',
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Additional Info Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.text_gray.withOpacity(0.18),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.black.withOpacity(0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow('الراسل', formDataDetails.sender_name ?? ""),
                    const Divider(height: 20, thickness: 1, color: Color(0xFFF1F5F9)),
                    _buildInfoRow(
                      'تعليمات أولى خاصة بالراسل',
                      formDataDetails.Initial_instructions ?? "",
                    ),
                    const Divider(height: 20, thickness: 1, color: Color(0xFFF1F5F9)),
                    _buildInfoRow(
                      'تعليمات ثانية خاصة بالراسل',
                      formDataDetails.Final_instructions ?? "",
                    ),
                    const Divider(height: 20, thickness: 1, color: Color(0xFFF1F5F9)),
                    _buildInfoRow(
                      'رقم بطاقة المرسل إليه',
                      formDataDetails.identity_number ?? "",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.text_gray,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            fontFamily: 'cairo',
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value.isEmpty ? '-' : value,
          textAlign: TextAlign.right,
          style: const TextStyle(
            color: AppColors.text_gray_Dark,
            fontSize: 13,
            fontWeight: FontWeight.w600,
            fontFamily: 'cairo',
          ),
        ),
      ],
    );
  }

  Widget _buildContactActions(BuildContext context, String? phone, Color color) {
    if (phone == null || phone.isEmpty) return const SizedBox.shrink();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Phone Call
        _actionButton(
          iconPath: 'assets/images/icons/phone-call.svg',
          color: AppColors.green,
          onTap: () => launchUrlString("tel://$phone"),
        ),
        const SizedBox(width: 8),
        // WhatsApp
        _actionButton(
          iconPath: 'assets/images/icons/send-01.svg',
          color: const Color(0xFF25D366),
          onTap: () => launchUrlString("https://wa.me/$phone?text=Hello"),
        ),
        const SizedBox(width: 8),
        // SMS
        _actionButton(
          iconPath: 'assets/images/icons/comment-alt.svg',
          color: AppColors.skyblue,
          onTap: () async {
            await SmsMms.send(recipients: [phone], message: 'Hello');
          },
        ),
      ],
    );
  }

  Widget _actionButton({
    required String iconPath,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 34,
        height: 34,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(
          iconPath,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
      ),
    );
  }
}
