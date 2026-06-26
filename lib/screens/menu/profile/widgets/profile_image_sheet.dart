import 'package:carrefour/library/library.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImageSheet extends StatelessWidget {
  const ProfileImageSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: IOColors.backgroundPrimary,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
      ),
      child: SafeArea(
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: IOColors.textQuarternary,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                title: const Text(
                  'Зураг авах',
                  style: IOStyles.body1Medium,
                ),
                leading: const Icon(Icons.camera),
                onTap: () => Get.back(result: ImageSource.camera),
              ),
              ListTile(
                title: const Text(
                  'Зургийн сангаас сонгох',
                  style: IOStyles.body1Medium,
                ),
                leading: const Icon(Icons.photo_library),
                onTap: () => Get.back(result: ImageSource.gallery),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<ImageSource?>? show() {
    return Get.bottomSheet(this, isScrollControlled: true);
  }
}
