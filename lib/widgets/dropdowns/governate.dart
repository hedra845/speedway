import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sender/config/Strings.dart';
import 'package:sender/conponantes/constantes/colores.dart';

// Controller for managing the dropdown selection state
class SelectionController extends ChangeNotifier {
  String? selectedOption;

  void updateSelection(String? option) {
    selectedOption = option;
    notifyListeners();
  }
}

class GovernateDropdown extends StatefulWidget {
  final SelectionController controller;
  final void Function(String?)? onSelectionChanged; // Callback function

  const GovernateDropdown({
    super.key,
    required this.controller,
    this.onSelectionChanged, // Optional callback
  });

  @override
  _GovernateDropdownState createState() => _GovernateDropdownState();
}

class _GovernateDropdownState extends State<GovernateDropdown> {
  List<dynamic> options = [];
  bool isLoading = true;

  final Dio _dio = Dio(); // Initialize Dio instance

  @override
  void initState() {
    super.initState();
    _fetchOptions();
  }

  Future<void> _fetchOptions() async {
    const FlutterSecureStorage secureStorage = FlutterSecureStorage();
    // Read the token with the key 'token'
    String? token = await secureStorage.read(key: 'token');
    const String url = Apis.governates; // API endpoint

    try {
      _dio.options.headers = {
        'Authorization': 'Bearer $token', // Add token in header
      };

      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        setState(() {
          options = response.data['governates'];
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception('Failed to load options');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
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
                value: widget.controller.selectedOption,
                hint: const Text(
                  'اختر المحافظة',
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
                      option['governorate_name_ar'].toString(),
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
