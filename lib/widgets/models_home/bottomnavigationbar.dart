import 'package:flutter/material.dart';
import 'package:sender/conponantes/constantes/colores.dart';
import 'package:svg_flutter/svg.dart';

class Bottomnavigationbar extends StatelessWidget {
  final int currentIndex;
  const Bottomnavigationbar({super.key, this.currentIndex = 0});

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;

    if (index == 0) {
      Navigator.pushReplacementNamed(context, '/home_screen');
    } else if (index == 1) {
      Navigator.pushNamed(context, '/Orders_Page');
    } else if (index == 2) {
      Navigator.pushReplacementNamed(context, '/picked_up');
    } else if (index == 3) {
      Navigator.pushReplacementNamed(context, '/add_order');
    } else if (index == 4) {
      Navigator.pushNamed(context, '/profile_page');
    }
  }

  Color _iconColor(int index) {
    return currentIndex == index
        ? AppColors.primaryColor
        : const Color(0xFF94A3B8);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.white,
          elevation: 0,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: const Color(0xFF94A3B8),
          selectedLabelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            fontFamily: 'cairo',
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            fontFamily: 'cairo',
          ),
          currentIndex: currentIndex,
          onTap: (index) => _onItemTapped(context, index),
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: SvgPicture.asset(
                  'assets/images/icons/Icon_bottom__home.svg',
                  colorFilter: ColorFilter.mode(_iconColor(0), BlendMode.srcIn),
                  width: 22,
                  height: 22,
                ),
              ),
              label: 'الرئيسية',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: SvgPicture.asset(
                  'assets/images/icons/Icon_bottom_orders.svg',
                  colorFilter: ColorFilter.mode(_iconColor(1), BlendMode.srcIn),
                  width: 22,
                  height: 22,
                ),
              ),
              label: 'الطرود',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: SvgPicture.asset(
                  'assets/images/icons/Icon_bottom_map.svg',
                  colorFilter: ColorFilter.mode(_iconColor(2), BlendMode.srcIn),
                  width: 22,
                  height: 22,
                ),
              ),
              label: 'طلب بيك اب',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: SvgPicture.asset(
                  'assets/images/icons/add.svg',
                  colorFilter: ColorFilter.mode(_iconColor(3), BlendMode.srcIn),
                  width: 22,
                  height: 22,
                ),
              ),
              label: 'إضافة طرد',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: SvgPicture.asset(
                  'assets/images/icons/Icon_bottom_profile.svg',
                  colorFilter: ColorFilter.mode(_iconColor(4), BlendMode.srcIn),
                  width: 22,
                  height: 22,
                ),
              ),
              label: 'حسابي',
            ),
          ],
        ),
      ),
    );
  }
}
