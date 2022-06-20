// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'onboarding.dart';
import 'package:sizer/sizer.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'profilelists.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

final userDataController = Get.put(UserData());
bool? isOnboarding;
var data;
const Color headColor = Color.fromARGB(255, 255, 106, 68);
const Color bodyColor = Color.fromARGB(255, 55, 55, 55);

void initialization() async {
  print('ready in 3...');
  await Future.delayed(const Duration(seconds: 1));
  print('ready in 2...');
  await Future.delayed(const Duration(seconds: 1));
  print('ready in 1...');
  await Future.delayed(const Duration(seconds: 1));
  print('go!');
  FlutterNativeSplash.remove();
}

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await GetStorage.init();
  data = GetStorage().read('USER_DATA');
  GetStorage().read('isOnboarding') == null
      ? isOnboarding = true
      : isOnboarding = false;
  data == null ? null : userDataController.userData = RxList.from(data);
  runApp(const Ksaju());
}

class Ksaju extends StatelessWidget {
  const Ksaju({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
            onInit: () => initialization(),
            title: 'K Saju',
            debugShowCheckedModeBanner: false,
            home: data == null ? const OnBoardingPage() : Home());
      },
    );
  }
}

class Home extends StatelessWidget {
  Home({super.key});
  final MyTabController _tabx = Get.put(MyTabController());
  DateTime prebackpress = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
      onWillPop: () async {
        final timegap = DateTime.now().difference(prebackpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        prebackpress = DateTime.now();
        if (cantExit) {
          Get.snackbar(
            'EXIT APP',
            '"Back" again to exit',
            backgroundColor: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2),
          );
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
          backgroundColor: Colors.grey,
          appBar: AppBar(
            actions: [
              TextButton.icon(
                  onPressed: () {
                    Get.to(ProfileListsPage());
                  },
                  icon: const Icon(
                    Icons.person_pin,
                    color: Colors.white,
                  ),
                  label: Obx((() => CustomText(
                      userDataController.userData[selectedIndex.value]['name']
                          .toString(),
                      12.sp,
                      Colors.white,
                      TextAlign.center))))
            ],
            elevation: 1,
            backgroundColor: headColor,
            title: CustomText('K 사주', 20.sp, Colors.white, TextAlign.start),
          ),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabx.controller,
            children: [
              Container(color: bodyColor),
              Container(color: bodyColor),
              Container(color: bodyColor),
              Container(color: bodyColor),
            ],
          ),
          bottomNavigationBar: ConvexAppBar(
              controller: _tabx.controller,
              backgroundColor: headColor,
              style: TabStyle.reactCircle,
              items: const [
                TabItem(icon: Icons.calendar_today),
                TabItem(icon: Icons.favorite),
                TabItem(icon: Icons.person),
                TabItem(icon: Icons.settings),
              ],
              initialActiveIndex: 0,
              onTap: (int index) {})),
    ));
  }
}

class MyTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: 4);
  }
}

class UserData extends GetxController {
  RxList<Map<String, dynamic>> userData = <Map<String, dynamic>>[].obs;

  void addUserData(
      TextEditingController nameController,
      TextEditingController dateController,
      TextEditingController timeController,
      Gender? selectedGender) {
    userData.add({
      'name': nameController.text,
      'dateofbirth': dateController.text,
      'timeofbirth': timeController.text,
      'gender': selectedGender.toString(),
    });
    GetStorage().write('USER_DATA', userData);
    nameController.clear();
    dateController.clear();
    timeController.clear();
    if (isOnboarding == true) {
      isOnboarding = false;
      GetStorage().write('isOnboarding', isOnboarding);
      Get.offAll(Home());
    } else {
      Get.back();
    }
  }

  void dismissUserData(int index) {
    userData.removeAt(index);
    GetStorage().write('USER_DATA', userData);
  }

  Icon Choosed_Gender_CircleAvatar(String selectedGender) {
    if (selectedGender == Gender.Male.toString()) {
      return const Icon(
        Icons.male,
        color: Colors.blue,
        size: 40,
      );
    }
    return const Icon(
      Icons.female,
      color: Colors.pink,
      size: 40,
    );
  }

  Color Choosed_Gender_Color(String selectedGender) {
    if (selectedGender == Gender.Male.toString()) {
      return const Color(0xFFBBDEFB);
    }
    return const Color(0xFFFFCDD2);
  }
}

Text CustomText(
    String text, double fontsize, Color fontcolor, TextAlign textAlign) {
  return Text(
    text,
    textAlign: textAlign,
    style: TextStyle(
        fontSize: fontsize,
        color: fontcolor,
        fontFamily: 'CustomFont',
        fontWeight: FontWeight.bold),
  );
}
