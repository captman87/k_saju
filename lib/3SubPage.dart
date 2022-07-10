// ignore_for_file: file_names, non_constant_identifier_names, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'main.dart';

Container SubPage() {
  return Container(
    color: Colors.white,
    child: ListView(children: [
      Column(
        children: [
          Row_SubButton(),
          ElevatedButton(
            onPressed: (() {}),
            style: ElevatedButton.styleFrom(
                elevation: 10,
                backgroundColor: const Color.fromARGB(255, 235, 255, 57),
                shape: const CircleBorder(),
                fixedSize: Size.fromRadius(20.w)),
            child: CustomText(
              '3 Packages All in One',
              15.sp,
              Colors.black,
              TextAlign.center,
            ),
          ),
          Padding(padding: EdgeInsets.all(5.h)),
          CustomText(
              '일일 운세 구독 서비스 = 설명\n커플 궁합 구독 서비스 = 설명\n해몽 구독 서비스 = 설명\n3 Packages All in One 서비스 = 설명',
              15.sp,
              Colors.black,
              TextAlign.start)
        ],
      ),
    ]),
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
                backgroundColor: Colors.orangeAccent,
                shape: const CircleBorder(),
                fixedSize: Size.fromRadius(15.w)),
            child: CustomText(
              '일일\n운세서비스\n구독',
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
            backgroundColor: const Color.fromARGB(255, 248, 109, 109),
            shape: const CircleBorder(),
            fixedSize: Size.fromRadius(15.w)),
        child: CustomText(
          '커플\n궁합서비스\n구독',
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
                backgroundColor: const Color.fromARGB(255, 127, 255, 87),
                shape: const CircleBorder(),
                fixedSize: Size.fromRadius(15.w)),
            child: CustomText(
              '해몽\n서비스\n구독',
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
