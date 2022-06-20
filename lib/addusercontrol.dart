// ignore_for_file: no_leading_underscores_for_local_identifiers, depend_on_referenced_packages

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:gender_picker/source/enums.dart';
import 'package:gender_picker/source/gender_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import 'main.dart';

TextEditingController _nameController = TextEditingController();
TextEditingController _dateController = TextEditingController();
TextEditingController _timeController = TextEditingController();
Gender? selectedGender = Gender.Male;

class AddUserControlPanel extends StatelessWidget {
  AddUserControlPanel({super.key});
  final formatD = DateFormat("yyyy-MM-dd");
  final formatT = DateFormat("HH:mm");

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.5,
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: const EdgeInsets.only(left: 10, right: 10, top: 25),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        labelText: 'Name or Nickname',
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: 'CustomFont',
                            fontStyle: FontStyle.italic),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    TextFormField(
                      controller: _dateController,
                      style: const TextStyle(color: Colors.white),
                      readOnly: true,
                      onTap: () {
                        DatePicker.showDatePicker(context,
                            showTitleActions: true,
                            minTime: DateTime(1900, 3, 5),
                            maxTime: DateTime.now(),
                            onChanged: (date) {}, onConfirm: (date) {
                          String dateFormat =
                              DateFormat('yyyy-MM-dd').format(date);
                          _dateController.text = dateFormat.toString();
                        },
                            currentTime: DateTime(1990, 6, 15),
                            locale: LocaleType.ko);
                      },
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                        ),
                        labelText: 'Date of Birth',
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: 'CustomFont',
                            fontStyle: FontStyle.italic),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    DateTimeField(
                      controller: _timeController,
                      style: const TextStyle(color: Colors.white),
                      format: formatT,
                      onShowPicker: (context, currentValue) async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: TimeOfDay.fromDateTime(
                              currentValue ?? DateTime.now()),
                        );
                        return DateTimeField.convert(time);
                      },
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.watch_later_outlined,
                          color: Colors.white,
                        ),
                        labelText: 'Time of Birth',
                        labelStyle: TextStyle(
                            color: Colors.white,
                            fontFamily: 'CustomFont',
                            fontStyle: FontStyle.italic),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    GenderPickerWithImage(
                      verticalAlignedText: false,
                      selectedGenderTextStyle: const TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                      unSelectedGenderTextStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.normal),
                      onChanged: (Gender? gender) {
                        selectedGender = gender;
                      },
                      equallyAligned: true,
                      animationDuration: const Duration(milliseconds: 300),
                      isCircular: true,
                      // default : true,
                      opacityOfGradient: 0.2,
                      padding: const EdgeInsets.all(3),
                      size: 15.w, //default : 40
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.2,
                padding: const EdgeInsets.only(left: 10, right: 10, top: 25),
                child: Column(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          minimumSize: Size(
                              MediaQuery.of(context).size.width * 0.15,
                              MediaQuery.of(context).size.height * 0.2)),
                      child: const Text('S\nu\nb\nm\ni\nt'),
                      onPressed: () {
                        if (userDataController.userData.length < 5) {
                          if (_nameController.text.isNotEmpty &&
                              _dateController.text.isNotEmpty &&
                              _timeController.text.isNotEmpty) {
                            userDataController.addUserData(
                                _nameController,
                                _dateController,
                                _timeController,
                                selectedGender);
                          } else {
                            Get.snackbar(
                              '',
                              '',
                              titleText: const Text(
                                'Fill in the all blanks',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              duration: const Duration(milliseconds: 1500),
                              backgroundColor: Colors.red,
                              snackPosition: SnackPosition.TOP,
                            );
                          }
                        } else {
                          Get.snackbar(
                            '',
                            '',
                            titleText: const Text(
                              'You can only save up to 5 profiles',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            duration: const Duration(milliseconds: 1500),
                            backgroundColor: Colors.red,
                            snackPosition: SnackPosition.TOP,
                          );
                        }
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          minimumSize: Size(
                              MediaQuery.of(context).size.width * 0.15,
                              MediaQuery.of(context).size.height * 0.2)),
                      child: const Text('C\na\nn\nc\ne\nl'),
                      onPressed: () {
                        _nameController.clear();
                        _dateController.clear();
                        _timeController.clear();

                        Get.back();
                      },
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
