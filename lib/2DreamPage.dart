// ignore_for_file: file_names, non_constant_identifier_names, sort_child_properties_last
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'main.dart';
import 'package:dropdown_search/dropdown_search.dart';

Column DreamPage() {
  return Column(
    children: [
      DropdownSearch(
        items: [dreamDB?.dreamDBlist[5].title_ko],
      ),
      Expanded(child: Builder(builder: (context) {
        return ListView.builder(
          itemCount: dreamDB?.dreamDBlist.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: ListTile(
                title: Text(dreamDB!.dreamDBlist[index].title_ko.toString()),
              ),
            );
          },
        );
      })),
    ],
  );
}
