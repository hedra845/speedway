import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sender/config/Strings.dart';
import 'package:sender/conponantes/constantes/colores.dart';

// Controller for managing the dropdown selection state
class SelectorController extends ChangeNotifier {
  String? selectedOption;

  void updateSelection(String? option) {
    selectedOption = option;
    notifyListeners();
  }
}

class CentersDropdown extends StatefulWidget {
  final SelectorController controller;
  final void Function(String?)? onSelectionChanged;
  final String? gavernate_id; // يجب أن يكون String? لأنه يمكن أن يكون null

  const CentersDropdown({
    super.key,
    required this.controller,
    this.onSelectionChanged,
    required this.gavernate_id,
  });

  @override
  _CentersDropdownState createState() => _CentersDropdownState();
}

class _CentersDropdownState extends State<CentersDropdown> {
  List<dynamic> options = [];
  bool isLoading = true;
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    _fetchOptions();
  }

  // **📌 إعادة تحميل البيانات عند تغيير `gavernate_id`**
  @override
  void didUpdateWidget(covariant CentersDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.gavernate_id != widget.gavernate_id) {
      _fetchOptions(); // إعادة تحميل المراكز عند تغيير المحافظة
    }
  }

  Future<void> _fetchOptions() async {
    if (widget.gavernate_id == null || widget.gavernate_id!.isEmpty) {
      setState(() {
        options = [];
        isLoading = false;
      });
      return;
    }

    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    String? token = await secureStorage.read(key: 'token');
    String url = "${Apis.centers}${widget.gavernate_id}";

    try {
      _dio.options.headers = {
        'Authorization': 'Bearer $token',
      };

      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        setState(() {
          options = response.data['centers'] ?? [];
          isLoading = false;
        });
      } else {
        setState(() {
          options = [];
          isLoading = true;
        });
      }
    } catch (e) {
      setState(() {
        options = [];
        isLoading = true;
      });
      print('Error fetching options: $e');
    }
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
      child: isLoading
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),
            )
          : DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                dropdownColor: AppColors.white,
                icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primaryColor),
                value: options.any((option) =>
                        option['id'].toString() ==
                        widget.controller.selectedOption)
                    ? widget.controller.selectedOption
                    : null,
                hint: const Text(
                  'اختر المركز',
                  style: TextStyle(
                    fontFamily: 'cairo',
                    fontSize: 13,
                    color: Color(0xFF94A3B8),
                  ),
                ),
                items: options.map<DropdownMenuItem<String>>((option) {
                  return DropdownMenuItem<String>(
                    value: option['id'].toString(),
                    child: Text(
                      option['center_name'].toString(),
                      style: const TextStyle(
                        fontFamily: 'cairo',
                        fontSize: 13,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    widget.controller.updateSelection(value);
                  });

                  if (widget.onSelectionChanged != null) {
                    widget.onSelectionChanged!(value);
                  }
                },
              ),
            ),
    );
  }
}
