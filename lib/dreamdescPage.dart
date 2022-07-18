import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:ksaju/main.dart';

class DreamDescPage extends StatefulWidget {
  DreamDescPage({super.key});

  @override
  State<DreamDescPage> createState() => _DreamDescPageState();
}

class _DreamDescPageState extends State<DreamDescPage> {
  DreamDB argumentDB = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('해몽'),
      ),
      body: Column(
        children: [
          Text(argumentDB.title_ko),
          Text(argumentDB.desc_ko),
          Text(argumentDB.title_en),
          Text(argumentDB.desc_en),
        ],
      ),
    );
  }
}
