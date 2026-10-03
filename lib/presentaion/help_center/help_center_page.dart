import 'package:sender/conponantes/constantes/colores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:svg_flutter/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpCenter extends StatelessWidget {
  const HelpCenter({super.key});
  final String description = '''
سيستم شركة شحن هو نظام إدارة مصمم لتتبع وتنظيم عمليات الشحن والتوصيل، يشمل تتبع الطرود، إدارة الشحنات، تسجيل البيانات اللوجستية، وإدارة العملاء. يمكن أن يشمل وظائف مثل:

- إدارة الطلبات: تسجيل وتتبع طلبات الشحن من الاستلام إلى التوصيل.
- تتبع الشحنات: توفير تحديثات في الوقت الحقيقي حول موقع الطرود.
- إدارة المخزون: تنظيم المنتجات والمخزون في المخازن.
- إدارة العملاء: معلومات العملاء وتاريخ الطلبات.
- التقارير: توليد تقارير أداء العمليات والشحنات.

هذا السيستم يهدف إلى تحسين الكفاءة، تقليل الأخطاء، وتوفير تجربة أفضل للعملاء.
''';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        shadowColor: AppColors.text_gray_Dark.withOpacity(0.1),
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: SvgPicture.asset('assets/images/icons/arrow-left.svg')),
        actions: [
          const Row(children: []),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/notifications_page');
              },
              icon: Icon(
                Icons.notifications_on_outlined,
                color: AppColors.black.withOpacity(0.5),
              )),
        ],
        title: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'مركز المساعدة',
                style: TextStyle(
                    fontFamily: 'cairo',
                    color: AppColors.text_gray_Dark,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ]),
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(16.0),
          color: AppColors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.white.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          children: [
                            const Text(
                              'مركز المساعدة',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'cairo',
                                color: AppColors.text_gray_Dark,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            SvgPicture.asset(
                              'assets/images/icons/logo_z2zenon.svg',
                              color: AppColors.primaryColor,
                              width: 20,
                              height: 20,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),

                      //start description

                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.white.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: 'cairo',
                            color: AppColors.text_gray_Dark,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      //end description

                      const SizedBox(
                        height: 10,
                      ),

                      // cards
                      //first card

                      Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColor),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.white.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const CircleAvatar(
                              backgroundImage: AssetImage(
                                  'assets/images/images/WhatsApp Image 2025-01-02 at 23.33.14_cc728c81.jpg'),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Engineer Hedra",
                                      style: TextStyle(
                                          fontFamily: 'cairo',
                                          color: AppColors.text_gray_Dark,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          '0155...',
                                          style: TextStyle(
                                              fontFamily: 'cairo',
                                              color: AppColors.text_gray_Dark,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        IconButton(
                                            iconSize: 20,
                                            onPressed: () {
                                              Clipboard.setData(
                                                  const ClipboardData(
                                                      text: '01551407492'));
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                backgroundColor:
                                                    AppColors.primaryColor,
                                                duration: Duration(seconds: 1),
                                                content: Text(
                                                  "تم نسخ الرقم الي الحافظة",
                                                  style: TextStyle(
                                                      fontFamily: 'cairo'),
                                                ),
                                              ));
                                            },
                                            icon: const Icon(
                                              Icons.content_copy_rounded,
                                              color: AppColors.primaryColor,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                                const Text(
                                  "App Developer and UI&UX Designer",
                                  style: TextStyle(
                                      fontFamily: 'cairo',
                                      color: AppColors.text_gray_Dark,
                                      fontSize: 14),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),

                      //end firstcards

                      const SizedBox(
                        height: 10,
                      ),

                      //second card

                      Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primaryColor),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.white.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const CircleAvatar(
                                backgroundImage: AssetImage(
                                    'assets/images/images/WhatsApp Image 2025-01-10 at 17.13.26_48c764b8.jpg'),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Text(
                                        "Engineer Mahmoud",
                                        style: TextStyle(
                                            fontFamily: 'cairo',
                                            color: AppColors.text_gray_Dark,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            '011...',
                                            style: TextStyle(
                                                fontFamily: 'cairo',
                                                color: AppColors.text_gray_Dark,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w900),
                                          ),
                                          IconButton(
                                              iconSize: 20,
                                              onPressed: () {
                                                Clipboard.setData(
                                                    const ClipboardData(
                                                        text: '01148422820'));
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  backgroundColor:
                                                      AppColors.primaryColor,
                                                  duration:
                                                      Duration(seconds: 1),
                                                  content: Text(
                                                    "تم نسخ الرقم الي الحافظة",
                                                    style: TextStyle(
                                                        fontFamily: 'cairo'),
                                                  ),
                                                ));
                                              },
                                              icon: const Icon(
                                                Icons.content_copy_rounded,
                                                color: AppColors.primaryColor,
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Text(
                                    "full stack developer",
                                    style: TextStyle(
                                        fontFamily: 'cairo',
                                        color: AppColors.text_gray_Dark,
                                        fontSize: 12),
                                  ),
                                ],
                              )
                            ],
                          )),

                      //end second card
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "@copyright reserved to Engineers H&M",
                        style: TextStyle(
                            fontFamily: 'cairo',
                            color: AppColors.text_gray_Dark),
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.white,
        onPressed: () {
          launch("https://wa.me/+201551407492?text=استفسار");
        },
        child: SvgPicture.asset(
          'assets/images/icons/Question mark.svg',
          color: AppColors.primaryColor,
        ),
      ),
    );
  }
}
