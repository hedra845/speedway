import 'dart:convert';
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sender/config/Strings.dart';
import 'package:sender/conponantes/constantes/colores.dart';

class PieChartSample2 extends StatefulWidget {
  const PieChartSample2({super.key});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  static const _storage = FlutterSecureStorage();
  int touchedIndex = -1;
  List<PieChartSectionData> sections = [];
  List<Map<String, dynamic>> indicators = [];
  bool isLoading = true;
  String? errorMessage;

  

  // تخزين الألوان لكل حالة بناءً على الاسم
  final Map<String, Color> stateColors = {};

  // دالة لإنشاء لون عشوائي
  Color getRandomColor() {
    Random random = Random();
    return Color.fromARGB(
      255,
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchChartData();
  }

  Future<void> fetchChartData() async {
    String? token = await _storage.read(key: 'token');
    String? uid = await _storage.read(key: 'uid');
    var headers = {'Authorization': 'Bearer $token'};

    try {
      final response = await http.get(
        Uri.parse(Apis.statics),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);

        // تحقق مما إذا كانت البيانات تحتوي على قائمة أو كائن واحد فقط
        if (responseData['statics'] is List) {
          final List<dynamic> staticsList = responseData['statics'];

          setState(() {
            sections = generateSections(staticsList);
            indicators = generateIndicators(staticsList);
            isLoading = false;
          });
        } else if (responseData['statics'] is Map<String, dynamic>) {
          // إذا كانت البيانات عبارة عن كائن واحد فقط، نحوله إلى قائمة
          final List<dynamic> staticsList = [responseData['statics']];

          setState(() {
            sections = generateSections(staticsList);
            indicators = generateIndicators(staticsList);
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = "تنسيق البيانات غير صحيح";
            isLoading = false;
          });
        }
      } else {
        setState(() {
          errorMessage = "فشل في جلب البيانات";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = "حدث خطأ: ${e.toString()}";
        isLoading = false;
      });
    }
  }

  List<Color> colors = []; // قائمة لتخزين الألوان

  List<PieChartSectionData> generateSections(List<dynamic> staticsList) {
    colors.clear(); // تفريغ الألوان في كل استدعاء جديد
    return List.generate(staticsList.length, (index) {
      final statics = staticsList[index];

      // استخدام اللون من الـ API أو توليد لون جديد إذا لم يكن موجودًا
      Color sectionColor = statics['color'] != null
          ? Color(int.parse(statics['color'].replaceFirst("#", "0xFF")))
          : getRandomColor();

      colors.add(sectionColor); // تخزين اللون لضمان استخدامه في `Indicator`

      return PieChartSectionData(
        color: sectionColor,
        value: statics['total'].toDouble(),
        title: '${statics['total']}',
        radius: 50,
        titleStyle: const TextStyle(
          fontSize: 10,
          fontFamily: 'cairo',
          fontWeight: FontWeight.bold,
          color: AppColors.white,
          shadows: [Shadow(color: Colors.black, blurRadius: 2)],
        ),
      );
    });
  }

  List<Map<String, dynamic>> generateIndicators(List<dynamic> staticsList) {
    return List.generate(staticsList.length, (index) {
      final statics = staticsList[index];
      return {
        "color": colors[index], // استخدام نفس اللون المخزن
        "text": statics['name'],
        "total": statics['total'],
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              color: AppColors.primaryColor,
              backgroundColor: AppColors.white,
            ))
          : errorMessage != null
              ? Center(child: Text(errorMessage!))
              : Scrollbar(
                child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 240,
                          width: 240,
                          child: PieChart(
                            PieChartData(
                              pieTouchData: PieTouchData(
                                touchCallback:
                                    (FlTouchEvent event, pieTouchResponse) {
                                  setState(() {
                                    if (!event.isInterestedForInteractions ||
                                        pieTouchResponse == null ||
                                        pieTouchResponse.touchedSection == null) {
                                      touchedIndex = -1;
                                      return;
                                    }
                                    touchedIndex = pieTouchResponse
                                        .touchedSection!.touchedSectionIndex;
                                  });
                                },
                              ),
                              borderData: FlBorderData(show: false),
                              sectionsSpace: 0,
                              centerSpaceRadius: 40,
                              sections: sections,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: indicators
                              .map((item) => Indicator(
                                    color: item['color'],
                                    text: "${item['text']}: (${item['total']})",
                                    isSquare: true,
                                  ))
                              .toList(),
                        ),
                        const SizedBox(width: 28),
                      ],
                    ),
                ),
    );
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
     mainAxisAlignment: MainAxisAlignment.center,
     crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'cairo',
            fontWeight: FontWeight.bold,
            color: textColor ?? Colors.black,
          ),
        )
      ],
    );
  }
}
