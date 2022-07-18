// ignore_for_file: file_names, non_constant_identifier_names, sort_child_properties_last
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dreamdescPage.dart';
import 'main.dart';

class DreamSearchPage extends StatefulWidget {
  const DreamSearchPage({Key? key}) : super(key: key);

  @override
  State<DreamSearchPage> createState() => _DreamSearchPageState();
}

class _DreamSearchPageState extends State<DreamSearchPage> {
  TextEditingController editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    for (var element in dreamDB) {
      duplicateItems.add(element);
    }
  }

  bool isVisible = true;
  List<DreamDB> duplicateItems = [];
  List<DreamDB> items = [];

  void filterSearchResults(String query) {
    List<DreamDB> dummySearchList = [];
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<DreamDB> dummyListData = [];
      for (var item in dummySearchList) {
        if (item.title_ko.contains(query)) {
          dummyListData.add(item);
        }
      }
      setState(() {
        items.clear();
        items.addAll(dummyListData);
        isVisible = false;
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(items);
        isVisible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        color: bodyColor,
        child: Column(
          children: [
            TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                controller: editingController,
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 202, 199, 179),
                  hintText: "Search",
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.green,
                  ),
                )),
            Visibility(
              visible: isVisible,
              child: SizedBox(
                  height: Get.mediaQuery.size.height * 0.5,
                  width: Get.mediaQuery.size.width * 0.5,
                  child: Image.asset('images/magnifying-glass.png')),
            ),
            Expanded(child: Builder(builder: (context) {
              return ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  return DreamList_Card(items, index);
                },
              );
            })),
          ],
        ),
      ),
    );
  }
}

Card DreamList_Card(List<DreamDB> items, int index) {
  return Card(
    child: ListTile(
      title: Text(items[index].title_ko),
      onTap: (() {
        print(items[index].desc_en);
        Get.to(DreamDescPage(), arguments: items[index]);
      }),
    ),
  );
}
