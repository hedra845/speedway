import 'package:sender/conponantes/constantes/colores.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class ColorSelector_for_pickups extends StatefulWidget {
  const ColorSelector_for_pickups({super.key});

  @override
  _ColorSelector_for_pickupsState createState() => _ColorSelector_for_pickupsState();
}

class _ColorSelector_for_pickupsState extends State<ColorSelector_for_pickups> {
  String? selectedColor; // Stores the selected color as a string
   // ignore: unused_field
   final Color _currentColor = AppColors.yellow;
  void updateColor(String? color) {
    setState(() async {
      selectedColor = color;
      switch (color) {
        case 'اخضر':
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setInt('selectedColor_ColorSelector_for_pickups', AppColors.primaryColor.value);
          break;
        case 'احمر':
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setInt('selectedColor_ColorSelector_for_pickups', AppColors.red.value);
          break;
        case 'برتقالي':
           final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setInt('selectedColor_ColorSelector_for_pickups', AppColors.orange.value);
          break;
        case 'الحالة الاصلية':
           final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setInt('selectedColor_ColorSelector_for_pickups', AppColors.yellow.value);
          break;
        default:
           final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setInt('selectedColor_ColorSelector_for_pickups', AppColors.purple.value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6F9),
          borderRadius: BorderRadius.circular(10),
        ),
      child: DropdownButton<String>(
        value: selectedColor,
        dropdownColor: AppColors.white,
        hint: const Text('لون طرود البيك اب',style: TextStyle(fontFamily: 'cairo',fontSize: 14,fontWeight: FontWeight.bold),),
        borderRadius: const BorderRadius.all(Radius.circular(15)),
       iconDisabledColor: AppColors.primaryColor,
        iconEnabledColor: AppColors.primaryColor,
        underline: const ColoredBox(color: AppColors.text_gray),
        items: <String>['اخضر', 'احمر', 'برتقالي','الحالة الاصلية'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value,style: const TextStyle(fontFamily: 'cairo',fontSize: 12),),
          );
        }).toList(),
        onChanged: updateColor,
      ),
    );
  }
}
