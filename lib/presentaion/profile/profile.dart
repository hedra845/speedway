import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sender/conponantes/constantes/colores.dart';
import 'package:sender/conponantes/futures/future_delet_token.dart';
import 'package:sender/widgets/models_change_color/ColorSelector_for_home.dart';
import 'package:sender/widgets/models_change_color/ColorSelector_for_pickups.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:svg_flutter/svg_flutter.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.text_gray_Dark,
          surfaceTintColor: AppColors.white,
          shadowColor: AppColors.text_gray_Dark.withOpacity(0.08),
          elevation: 1,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.text_gray_Dark,
              size: 20,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/notifications_page');
              },
              icon: Icon(
                Icons.notifications_none_rounded,
                color: AppColors.text_gray_Dark.withOpacity(0.7),
              ),
            ),
          ],
          title: const Text(
            'الملف الشخصي',
            style: TextStyle(
              fontFamily: 'cairo',
              color: AppColors.text_gray_Dark,
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            children: [
              const ProfilePic(),
              const SizedBox(height: 20),

              // Theme Colors Row
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.text_gray.withOpacity(0.15),
                  ),
                ),
                child: SizedBox(
                  height: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(child: ColorSelector_for_pickups()),
                      const SizedBox(width: 10),
                      Flexible(child: ColorSelector_for_home()),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              ProfileMenu(
                text: "بياناتي الشخصية",
                icon: "assets/images/icons/User Icon.svg",
                press: () => Navigator.pushNamed(context, '/personal_data'),
              ),
              ProfileMenu(
                text: "الإشعارات",
                icon: "assets/images/icons/Bell.svg",
                press: () => Navigator.pushNamed(context, '/notifications_page'),
              ),
              ProfileMenu(
                text: "الإعدادات",
                icon: "assets/images/icons/Settings.svg",
                press: () => Navigator.pushNamed(context, '/Settings'),
              ),
              ProfileMenu(
                text: "مركز المساعدة",
                icon: "assets/images/icons/Question mark.svg",
                press: () => Navigator.pushNamed(context, '/help_center'),
              ),
              ProfileMenu(
                text: "دليل الاستخدام",
                icon: "assets/images/icons/guide-alt.svg",
                press: () => Navigator.pushNamed(context, '/help_center'),
              ),
              ProfileMenu(
                text: "تسجيل الخروج",
                icon: "assets/images/icons/Log out.svg",
                isDestructive: true,
                press: () async {
                  await clearToken();
                  if (mounted) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login_screen',
                      (route) => false,
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfilePic extends StatefulWidget {
  const ProfilePic({super.key});

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  final ImagePicker _picker = ImagePicker();
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    final imageBase64 = prefs.getString('profile_image');
    if (imageBase64 != null && mounted) {
      setState(() {
        _imagePath = imageBase64;
      });
    }
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = File(image.path).readAsBytesSync();
      final imageBase64 = base64Encode(bytes);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image', imageBase64);

      if (mounted) {
        setState(() {
          _imagePath = imageBase64;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 110,
        width: 110,
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  width: 2.5,
                  color: AppColors.primaryColor,
                ),
              ),
              child: ClipOval(
                child: _imagePath != null
                    ? Image.memory(
                        base64Decode(_imagePath!),
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/images/app_logo.png',
                        fit: BoxFit.contain,
                      ),
              ),
            ),
            Positioned(
              left: -4,
              bottom: 0,
              child: SizedBox(
                height: 38,
                width: 38,
                child: RawMaterialButton(
                  onPressed: _pickImage,
                  elevation: 2.0,
                  fillColor: AppColors.white,
                  padding: const EdgeInsets.all(8.0),
                  shape: const CircleBorder(
                    side: BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  child: SvgPicture.string(
                    cameraIcon,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    required this.text,
    required this.icon,
    this.press,
    this.isDestructive = false,
  });

  final String text, icon;
  final VoidCallback? press;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final itemColor = isDestructive ? AppColors.red : AppColors.primaryColor;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: press,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.text_gray.withOpacity(0.14),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  padding: const EdgeInsets.all(9),
                  decoration: BoxDecoration(
                    color: itemColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset(
                    icon,
                    colorFilter: ColorFilter.mode(itemColor, BlendMode.srcIn),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontFamily: 'cairo',
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: isDestructive
                          ? AppColors.red
                          : AppColors.text_gray_Dark,
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 15,
                  color: AppColors.text_gray.withOpacity(0.6),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

const cameraIcon = '''<svg width="20" height="16" viewBox="0 0 20 16" fill="none" xmlns="http://www.w3.org/2000/svg">
<path fill-rule="evenodd" clip-rule="evenodd" d="M10 12.0152C8.49151 12.0152 7.26415 10.8137 7.26415 9.33902C7.26415 7.86342 8.49151 6.6619 10 6.6619C11.5085 6.6619 12.7358 7.86342 12.7358 9.33902C12.7358 10.8137 11.5085 12.0152 10 12.0152ZM10 5.55543C7.86698 5.55543 6.13208 7.25251 6.13208 9.33902C6.13208 11.4246 7.86698 13.1217 10 13.1217C12.133 13.1217 13.8679 11.4246 13.8679 9.33902C13.8679 7.25251 12.133 5.55543 10 5.55543ZM18.8679 13.3967C18.8679 14.2226 18.1811 14.8935 17.3368 14.8935H2.66321C1.81887 14.8935 1.13208 14.2226 1.13208 13.3967V5.42346C1.13208 4.59845 1.81887 3.92664 2.66321 3.92664H4.75C5.42453 3.92664 6.03396 3.50952 6.26604 2.88753L6.81321 1.41746C6.88113 1.23198 7.06415 1.10739 7.26604 1.10739H12.734C12.9358 1.10739 13.1189 1.23198 13.1877 1.41839L13.734 2.88845C13.966 3.50952 14.5755 3.92664 15.25 3.92664H17.3368C18.1811 3.92664 18.8679 4.59845 18.8679 5.42346V13.3967ZM17.3368 2.82016H15.25C15.0491 2.82016 14.867 2.69466 14.7972 2.50917L14.2519 1.04003C14.0217 0.418041 13.4113 0 12.734 0H7.26604C6.58868 0 5.9783 0.418041 5.74906 1.0391L5.20283 2.50825C5.13302 2.69466 4.95094 2.82016 4.75 2.82016H2.66321C1.19434 2.82016 0 3.98846 0 5.42346V13.3967C0 14.8326 1.19434 16 2.66321 16H17.3368C18.8057 16 20 14.8326 20 13.3967V5.42346C20 3.98846 18.8057 2.82016 17.3368 2.82016Z" fill="#757575"/>
</svg>
''';
