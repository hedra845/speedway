import 'package:sender/conponantes/constantes/colores.dart';
import 'package:sender/widgets/model_card/widget_earning.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

class TotalCollected extends StatefulWidget {
  const TotalCollected({super.key});

  @override
  State<TotalCollected> createState() => _TotalCollectedState();
}

  int _currentIndex = 0;
  const int _counter_home = 0;
  const int _counter_orders = 0;
  const int _counter_earnings = 0;
  int total_orders = 153;
  int total_pending = 19;
  int total_collected = 5000;
  int total_earnings = 1000;
  int total_cancelled = 9;


class _TotalCollectedState extends State<TotalCollected> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: SvgPicture.asset('assets/images/icons/arrow-left.svg'),
        ),
        surfaceTintColor: AppColors.white,
        shadowColor: AppColors.text_gray_Dark.withOpacity(0.1),
        backgroundColor: AppColors.white,
        centerTitle: true,
        title: const Text(' Total Collected \t\t\t-\t\t\t   اجمالي المال',
            style: TextStyle(
              fontFamily: 'cairo',
              color: AppColors.text_gray_Dark,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
      ),
      //body
      body: Container(
         decoration: const BoxDecoration(
          color: AppColors.white,
        ),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                height: 150,
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  scrollDirection: Axis.horizontal,
                  children: [
                    earningsCard(
                        'اليوم', '\$200', '30-12-2022', AppColors.primaryColor),
                    const SizedBox(
                      width: 10,
                    ),
                    earningsCard('امس', '\$1000', '28-12-2022',
                        const Color(0xff858D90)),
                    const SizedBox(
                      width: 10,
                    ),
                    earningsCard('هذا الاسبوع', '\$465', '20-12-2022',
                        const Color(0xff565F64)),
                    const SizedBox(
                      width: 10,
                    ),
                    earningsCard('هذا الشهر', '\$32444', '10-12-2022',
                        const Color(0xff273238)),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        earningsDetail("54646-744984", "30-12-2022", 200,AppColors.primaryColor),
                      ]);
                },
                padding: const EdgeInsets.only(right: 15,left: 15,bottom: 15),
                itemCount: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
