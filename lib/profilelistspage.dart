// ignore_for_file: no_leading_underscores_for_local_identifiers, non_constant_identifier_names, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sizer/sizer.dart';
import 'addusercontrol.dart';
import 'main.dart';

class ProfileListsPage extends StatelessWidget {
  ProfileListsPage({super.key});
  final _selectedIndexControl = Get.put(SelectedIndexController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bodyColor,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: headColor,
          title: CustomText('프로필정보', 15.sp, Colors.white, TextAlign.center),
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(
                () => ListView.builder(
                    itemCount: userDataController.userData.length,
                    itemBuilder: ((context, index) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: Card(
                          child: Obx(
                            () => ListTile(
                                onTap: () {
                                  _selectedIndexControl
                                      .selectedIndexController(index);
                                  GetStorage().write(
                                      'SelectedIndex', selectedIndex.value);
                                },
                                selected: index == selectedIndex.value,
                                tileColor: Colors.grey,
                                leading: userDataController.userData[index]
                                            ['gender'] ==
                                        Gender.Male.toString()
                                    ? const Icon(
                                        Icons.male,
                                        color: Colors.blue,
                                        size: 40,
                                      )
                                    : const Icon(
                                        Icons.female,
                                        color: Colors.pink,
                                        size: 40,
                                      ),
                                title: SelectedText(index, selectedIndex),
                                subtitle: CustomText(
                                    '${userDataController.userData[index]['dateofbirth']}  ${userDataController.userData[index]['timeofbirth']}',
                                    12.sp,
                                    Colors.black,
                                    TextAlign.left),
                                trailing:
                                    userDataController.userData.length > 1 &&
                                            index != selectedIndex.value
                                        ? IndexIconButton(context, index)
                                        : null),
                          ),
                        ),
                      );
                    })),
              ),
            ),
            Container(
              color: Colors.blueGrey,
              child: ListTile(
                title: CustomText(
                    '사용자 추가하기', 15.sp, Colors.white, TextAlign.center),
                trailing: const Icon(
                  Icons.add,
                  size: 35,
                ),
                onTap: () {
                  selectedGender = Gender.Male;
                  Get.bottomSheet(AddUserControlPanel(),
                      backgroundColor: bodyColor);
                },
              ),
            )
          ],
        ));
  }

  Row SelectedText(int index, RxInt _selectedIndex) {
    if (index == _selectedIndex.value) {
      return Row(
        children: [
          CustomText(userDataController.userData[index]['name'], 15.sp,
              Colors.black, TextAlign.left),
          CustomText('  selected', 10.sp, Colors.red, TextAlign.left),
        ],
      );
    } else {
      return Row(
        children: [
          CustomText(userDataController.userData[index]['name'], 15.sp,
              Colors.black, TextAlign.left),
        ],
      );
    }
  }

  IconButton IndexIconButton(BuildContext context, int index) {
    return IconButton(
      onPressed: () {
        Get.dialog(AlertDialog(
          title: CustomText(
              'Are you sure?', 12.sp, Colors.black, TextAlign.center),
          content: CustomText(
              "Delete ${userDataController.userData[index]['name']}'s Profile",
              12.sp,
              Colors.black,
              TextAlign.center),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                return Navigator.of(context).pop(false);
              },
              child:
                  CustomText('CANCEL', 12.sp, Colors.black, TextAlign.center),
            ),
            ElevatedButton(
              onPressed: () {
                userDataController.dismissUserData(index);
                return Navigator.of(context).pop(true);
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child:
                  CustomText('DELETE', 12.sp, Colors.black, TextAlign.center),
            ),
          ],
        ));
      },
      icon: const Icon(
        Icons.delete,
        color: Colors.purple,
      ),
    );
  }
}

class SelectedIndexController extends GetxController {
  void selectedIndexController(int index) {
    selectedIndex.value = index;
  }
}
