import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_hub/Modules/UISections/Preferences/Language/Controller/LanguageController.dart';
import 'package:movie_hub/Modules/UISections/Preferences/Language/Model/LanguageEnum.dart';

import '../../../../../l10n/l10n.dart';

class LanguageView extends StatelessWidget {
  final controller = Get.find<LanguageController>();
  LanguageView({super.key});

  @override
  Widget build(BuildContext context) {
    const list = LanguageEnum.values;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
        ),
        itemCount: list.length,
        itemBuilder: (context, index) {
          final item = list[index];

          return GestureDetector(
            onTap: () {
              controller.setNewLanguage(item.getLocale());
            },
            child: Obx(() {
              final isSelected = (item.getLocale() ==
                  L10n.all[controller.selectedLanguageIndex.value]);
              return Container(
                  margin: const EdgeInsets.all(8),
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.blueAccent),
                  child: Stack(
                    children: [
                      Center(
                        child: Text(
                          item.getTitle(),
                          style: const TextStyle(
                              color: Colors.purple, fontSize: 20),
                        ),
                      ),
                      _setSelectedIconIfNeeded(isSelected),
                    ],
                  ));
            }),
          );
        },
      ),
    );
  }

  Widget _buildLanguageContainer(String name) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.deepPurple,
      ),
      child: Center(
        child: Text(
          name,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _setSelectedIconIfNeeded(bool isSelected) {
    if (isSelected) {
      return const Positioned(
        top: 0,
        right: 0,
        child: Icon(
          Icons.check_circle,
          color: Colors.green,
          size: 24,
        ),
      );
    } else {
      return Container();
    }
  }
}
