import 'package:flutter/material.dart';
import 'package:sender/conponantes/constantes/colores.dart';
import 'package:svg_flutter/svg.dart';

class Container_row extends StatelessWidget {
  const Container_row({
    super.key,
    required this.container_color,
    required this.icon,
    required this.title,
    required this.money,
    required this.title_of_first_row,
    required this.money_of_first_row,
    required this.title_of_second_row,
    required this.money_of_second_row,
  });

  final Color container_color;
  final String icon;
  final String title;
  final String money;
  final String title_of_first_row;
  final String money_of_first_row;
  final String title_of_second_row;
  final String money_of_second_row;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      padding: const EdgeInsets.symmetric(vertical: 8),
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.14,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: container_color,
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 6,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Row(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: AppColors.white,
                          width: 1.5,
                        ),
                      ),
                      width: 19,
                      height: 19,
                      child: SvgPicture.asset(
                        icon,
                        width: 11,
                        height: 10,
                      )),
                  const SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                          fontFamily: 'cairo',
                          color: AppColors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 10),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              '\$$money',
              style: const TextStyle(
                  fontFamily: 'cairo',
                  color: AppColors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            const SizedBox(
              height: 4,
            ),
            const Divider(
              color: AppColors.white,
              thickness: 1,
              height: 8,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title_of_first_row,
                        style: const TextStyle(
                            fontFamily: 'cairo',
                            color: AppColors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 10),
                      ),
                      Text(
                        '\$$money_of_first_row',
                        style: const TextStyle(
                          fontFamily: 'cairo',
                            color: AppColors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 10),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title_of_second_row,
                        style: const TextStyle(
                            fontFamily: 'cairo',
                            color: AppColors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 10),
                      ),
                      Text(
                        '\$$money_of_second_row',
                        style: const TextStyle(
                          fontFamily: 'cairo',
                            color: AppColors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: 10),
                      ),
                    ],
                  ),
                )
              ],
            )
          ]),
    );
  }
}
