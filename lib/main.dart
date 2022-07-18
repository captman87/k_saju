// ignore_for_file: non_constant_identifier_names, prefer_typing_uninitialized_variables, must_be_immutable
import 'dart:convert';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '1DreamPage.dart';
import '2subPage.dart';
import 'custom_icon.dart';
import 'google_sign_in.dart';
import 'dailylinechart_control.dart';
import 'onboarding.dart';
import 'package:sizer/sizer.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'profilelistspage.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

final userDataController = Get.put(UserData());
bool? isOnboarding;
var data;
QuerySnapshot<Map<String, dynamic>>? dataSnapshot;
List<DreamDB> dreamDB = [];
const Color headColor = Color.fromARGB(255, 20, 100, 70);
const Color bodyColor = Color(0xff232d37);
const Color circleColor = Color.fromARGB(255, 25, 25, 25);
RxInt selectedIndex = 0.obs;

Future InitStorage() async {
  await GetStorage.init();
  if (!GetStorage().hasData('DREAM_DB')) {
    final ref = FirebaseFirestore.instance.collection('DREAM_DESC');
    dataSnapshot = await ref.get();
    for (var element in dataSnapshot!.docs) {
      DreamDB data = DreamDB.fromSnapshot(element);
      dreamDB.add(data);
    }
  } else {
    dreamDB = DreamDB.decode(GetStorage().read('DREAM_DB'));
  }

  data = GetStorage().read('USER_DATA');

  await GetStorage().read('isOnboarding') == null
      ? isOnboarding = true
      : isOnboarding = false;

  data == null ? null : userDataController.userData = RxList.from(data);

  await GetStorage().read('SelectedIndex') == null
      ? selectedIndex.value = 0
      : selectedIndex.value = GetStorage().read('SelectedIndex');
}

Future<void> main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    name: 'K Saju',
    options: const FirebaseOptions(
      apiKey: 'AIzaSyCp15f-ZQZXIui1bjp1-xhxI4qC91jtr8o',
      appId: '1:134045567895:android:879ab14cfb42a8f7e712d2',
      projectId: 'k-saju-sk3',
      messagingSenderId: '134045567895',
      authDomain: 'k-saju-sk3.firebaseapp.com',
    ),
  );
  await InitStorage();

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

  void initialization() async {
    try {
      await AuthRepo.signInWithGoogle().then((value) {
        Get.snackbar('title', 'Welcome: ${value.user?.displayName ?? ""}');
      });
    } catch (e) {
      exit(0);
    }
    FlutterNativeSplash.remove();
  }
}

class Home extends StatelessWidget {
  Home({super.key});
  final MyTabController _tabx = Get.put(MyTabController());
  DateTime prebackpress = DateTime.now();
  RxString appbarTitle = '운세 보고서'.obs;

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
                      color: Colors.black,
                      size: 30,
                    ),
                    label: Obx((() => CustomText(
                        userDataController.userData[selectedIndex.value]['name']
                            .toString(),
                        15.sp,
                        Colors.black,
                        TextAlign.center))))
              ],
              elevation: 1,
              backgroundColor: headColor,
              title: Obx(
                (() => CustomText(
                    appbarTitle.value, 20.sp, Colors.white, TextAlign.start)),
              )),
          body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabx.controller,
            children: [
              Container(
                color: bodyColor,
                child: Column(
                  children: [
                    DailyLineChart(),
                    TextButton(
                        onPressed: () {
                          print(dreamDB[77].title_ko);
                        },
                        child: Text('test')),
                  ],
                ),
              ),
              const DreamSearchPage(),
              SubPage_Container(),
            ],
          ),
          bottomNavigationBar: ConvexAppBar(
              controller: _tabx.controller,
              backgroundColor: headColor,
              activeColor: circleColor,
              style: TabStyle.reactCircle,
              items: const [
                TabItem(
                    icon: Icon(
                  CustomIcon.calendar,
                  color: Colors.white,
                )),
                TabItem(
                    icon: Icon(
                  CustomIcon.dreaming,
                  color: Colors.white,
                )),
                TabItem(
                    icon: Icon(
                  CustomIcon.sub,
                  color: Colors.white,
                  size: 30,
                )),
              ],
              initialActiveIndex: 0,
              onTap: (int index) {
                switch (index) {
                  case 0:
                    appbarTitle.value = '운세 보고서';
                    break;
                  case 1:
                    appbarTitle.value = '해몽';
                    break;
                  case 2:
                    appbarTitle.value = '구독 서비스';
                    break;
                }
              })),
    ));
  }
}

class MyTabController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController controller;

  @override
  void onInit() {
    super.onInit();
    controller = TabController(vsync: this, length: 3);
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
    if (index < selectedIndex.value) {
      selectedIndex.value = selectedIndex.value - 1;
    }
    userData.removeAt(index);
    GetStorage().write('SelectedIndex', selectedIndex.value);
    GetStorage().write('USER_DATA', userData);
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

class DreamDB {
  int id;
  String title_ko;
  String title_en;
  String desc_ko;
  String desc_en;

  DreamDB({
    required this.id,
    required this.title_ko,
    required this.title_en,
    required this.desc_ko,
    required this.desc_en,
  });

  factory DreamDB.fromSnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> snapshot) {
    return DreamDB(
        id: snapshot['id'],
        title_ko: snapshot['title_ko'],
        title_en: snapshot['title_en'],
        desc_ko: snapshot['desc_ko'],
        desc_en: snapshot['desc_en']);
  }

  factory DreamDB.fromJson(Map<String, dynamic> json) {
    return DreamDB(
        id: json['id'],
        title_ko: json['title_ko'],
        title_en: json['title_en'],
        desc_ko: json['desc_ko'],
        desc_en: json['desc_en']);
  }

  static Map<String, dynamic> toMap(DreamDB dreamDB) => {
        'id': dreamDB.id,
        'title_ko': dreamDB.title_ko,
        'title_en': dreamDB.title_en,
        'desc_ko': dreamDB.desc_ko,
        'desc_en': dreamDB.desc_en,
      };

  static String encode(List<DreamDB> dreamDB) => json.encode(
        dreamDB
            .map<Map<String, dynamic>>((dreamDB) => DreamDB.toMap(dreamDB))
            .toList(),
      );

  static List<DreamDB> decode(String dreamDB) =>
      (json.decode(dreamDB) as List<dynamic>)
          .map<DreamDB>((item) => DreamDB.fromJson(item))
          .toList();
}
