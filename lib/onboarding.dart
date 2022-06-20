// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:sizer/sizer.dart';
import 'addusercontrol.dart';
import 'main.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      globalBackgroundColor: Colors.white,
      pages: [
        PageViewModel(
            title: '올해는 호랑이의 해',
            body: '호랑이의 해 설명\n\n무슨 어플인지 설명',
            decoration:
                const PageDecoration(imageFlex: 1, pageColor: Colors.white),
            image: Page1_Image()),
        PageViewModel(
            title: '메뉴 설명 페이지',
            body:
                '사주 - 일,월,연의 운세는 어떠한지\n궁합 - 연인끼리 잘맞는지\n해몽 - 꿈이 무슨 의미인지\n\n\n\n\nDone을 누르고 정보등록 후 시작!',
            image: Page2_Image()),
      ],
      done: CustomText('Done', 15.sp, Colors.black, TextAlign.center),
      onDone: () {
        selectedGender = Gender.Male;
        Get.bottomSheet(AddUserControlPanel(), backgroundColor: bodyColor);
      },
      next: const Icon(Icons.arrow_forward),
    );
  }
}

SizedBox Page1_Image() {
  return SizedBox(
      width: Get.mediaQuery.size.width / 1,
      child: Image.asset('images/page1.jpg'));
}

SizedBox Page2_Image() {
  return SizedBox(
      width: Get.mediaQuery.size.width / 1.5,
      child: Image.asset('images/page2.jpg'));
}
