import 'package:flutter/material.dart';
import 'package:sender/conponantes/constantes/colores.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TypeServices extends StatefulWidget {
  final ValueChanged<String> onSelectionChanged;

  const TypeServices({super.key, required this.onSelectionChanged});

  @override
  _TypeServicesState createState() => _TypeServicesState();
}

class _TypeServicesState extends State<TypeServices> {
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    _loadSelectedOption();
  }

  void _loadSelectedOption() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedOption = prefs.getString('selectedOption_TypeServices') ?? '';
    });
    _notifyParent();
  }

  void updateSelection(String? option) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedOption = option;
    });
    await prefs.setString('selectedOption_TypeServices', option ?? '');
    _notifyParent();
  }

  void _notifyParent() {
    String value = '';
    if (selectedOption == 'تسليم كامل للطلب') {
      value = 'full_deliver';
    } else if (selectedOption == 'طرد مقابل طرد') {
      value = 'order_versus';
    }else if (selectedOption == 'ارجاع الطلب') {
      value = 'order_return';
    }
    widget.onSelectionChanged(value) as String;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        color: const Color(0xFFF8FAFC),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          isExpanded: true,
          dropdownColor: AppColors.white,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primaryColor),
          value: selectedOption != '' ? selectedOption : null,
          hint: const Text(
            'نوع الخدمة',
            style: TextStyle(
              fontFamily: 'cairo',
              fontSize: 13,
              color: Color(0xFF94A3B8),
            ),
          ),
          items:
              <String>[
                'تسليم كامل للطلب',
                'طرد مقابل طرد',
                'ارجاع الطلب',
              ].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: const TextStyle(
                      fontFamily: 'cairo',
                      fontSize: 13,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                );
              }).toList(),
          onChanged: updateSelection,
        ),
      ),
    );
  }
}
