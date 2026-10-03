import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';

Widget class_containers_home(double height,double width,String iconPath,Color color,Color iconAndText,String name,String number) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    constraints: BoxConstraints(minHeight: height),
    width: width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: color,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(iconPath,color: iconAndText,width: 22,height: 22,),
        const SizedBox(height: 4,),
        Text(name,style: const TextStyle(fontSize: 14, fontFamily: 'cairo'), maxLines: 1, overflow: TextOverflow.ellipsis,),
        const SizedBox(height: 4,),
        Text(number,style: TextStyle(color: iconAndText,fontSize: 18,fontWeight: FontWeight.bold, fontFamily: 'cairo'), maxLines: 1, overflow: TextOverflow.ellipsis,),
      ],
    ),
  );
}