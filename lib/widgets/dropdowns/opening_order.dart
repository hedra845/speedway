import 'package:flutter/material.dart';
import 'package:sender/conponantes/constantes/colores.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OpeningOrder extends StatefulWidget {
  final ValueChanged<int> onSelectionChanged;

  const OpeningOrder({super.key, required this.onSelectionChanged});

  @override
  _OpeningOrderState createState() => _OpeningOrderState();
}

class _OpeningOrderState extends State<OpeningOrder> {
  String? selectedOption;

  @override
  void initState() {
    super.initState();
    _loadSelectedOption();
  }

  void _loadSelectedOption() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedOption = prefs.getString('selectedOption_opening_order') ?? '';
    });
    _notifyParent();
  }

  void updateSelection(String? option) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedOption = option;
    });
    await prefs.setString('selectedOption_opening_order', option ?? '');
    _notifyParent();
  }

  void _notifyParent() {
    int value = 0;
    if (selectedOption == 'مسموح بالفتح') {
      value = 0;
    } else if (selectedOption == 'غير مسموح بالفتح') {
      value = 1;
    }
    widget.onSelectionChanged(value);
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
            'فتح الطرد',
            style: TextStyle(
              fontFamily: 'cairo',
              fontSize: 13,
              color: Color(0xFF94A3B8),
            ),
          ),
          items: <String>['مسموح بالفتح', 'غير مسموح بالفتح'].map((String value) {
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
