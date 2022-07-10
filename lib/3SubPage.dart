// ignore_for_file: file_names, non_constant_identifier_names, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'main.dart';

Container SubPage_Container() {
  return Container(
    color: Colors.white,
    child: Column(
      children: [
        Row_SubButton(),
        ElevatedButton(
          onPressed: (() {}),
          style: ElevatedButton.styleFrom(
              elevation: 10,
              primary: const Color.fromARGB(255, 235, 255, 57),
              shape: const CircleBorder(),
              fixedSize: Size.fromRadius(30.w)),
          child: CustomText(
            '3 Packages All in One',
            15.sp,
            Colors.black,
            TextAlign.center,
          ),
        ),
        Padding(padding: EdgeInsets.all(5.h)),
        CustomText(
            '일일 운세 구독 서비스 = 설명\n\n커플 궁합 구독 서비스 = 설명\n\n해몽 구독 서비스 = 설명\n\n3 Packages All in One 서비스 = 설명',
            15.sp,
            Colors.black,
            TextAlign.start)
      ],
    ),
  );
}

Row Row_SubButton() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          ElevatedButton(
            onPressed: (() {}),
            style: ElevatedButton.styleFrom(
                elevation: 10,
                primary: Colors.orangeAccent,
                shape: const CircleBorder(),
                fixedSize: Size.fromRadius(15.w)),
            child: CustomText(
              '일일 운세 구독\n(월, 연 운세는 광고표시)',
              12.sp,
              Colors.black,
              TextAlign.center,
            ),
          ),
        ],
      ),
      ElevatedButton(
        onPressed: (() {}),
        style: ElevatedButton.styleFrom(
            elevation: 10,
            primary: const Color.fromARGB(255, 248, 109, 109),
            shape: const CircleBorder(),
            fixedSize: Size.fromRadius(15.w)),
        child: CustomText(
          '커플 궁합서비스 구독',
          12.sp,
          Colors.black,
          TextAlign.center,
        ),
      ),
      Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          ElevatedButton(
            onPressed: (() {}),
            style: ElevatedButton.styleFrom(
                elevation: 10,
                primary: const Color.fromARGB(255, 127, 255, 87),
                shape: const CircleBorder(),
                fixedSize: Size.fromRadius(15.w)),
            child: CustomText(
              '해몽 서비스 구독',
              12.sp,
              Colors.black,
              TextAlign.center,
            ),
          ),
        ],
      ),
    ],
  );
}
