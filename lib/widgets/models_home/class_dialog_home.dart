import 'package:flutter/material.dart';
import 'package:sender/conponantes/constantes/colores.dart';
import 'package:sender/widgets/models_home/dialogchart.dart';
import 'package:svg_flutter/svg.dart';

class ClassDialogHome extends StatefulWidget {
  const ClassDialogHome({super.key});


  @override
  State<ClassDialogHome> createState() => _ClassDialogHomeState();
}

class _ClassDialogHomeState extends State<ClassDialogHome> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog<String>(
          context: context,
          builder:
              (BuildContext context) => Dialog.fullscreen(
                backgroundColor: AppColors.white,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 10),
                        const PieChartSample2(),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.primaryColor,
                            ),
                            child: const Text(
                              'Close',
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 16,
                                fontFamily: 'cairo',
                                fontWeight: FontWeight.bold,
                              ),
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

      child: Container(
        height: MediaQuery.of(context).size.width * 0.1,
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
          color: AppColors.orange,
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  'assets/images/icons/chart-pie.svg',
                  color: AppColors.white,
                  width: 20,
                  height: 20,
                ),
                const SizedBox(width: 5),
                const Text(
                  'احصائيات',
                  style: TextStyle(
                    color: AppColors.white,
                    fontFamily: 'cairo',
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
