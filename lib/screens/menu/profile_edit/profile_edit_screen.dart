import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/menu/profile_edit/profile_edit_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileEditScreen extends GetView<ProfileEditController> {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return IOScaffold(
      appBar: IOAppBar(
        titleText: controller.titleText,
      ),
      body: Obx(
        () => controller.isInitialLoading.value
            ? const IOLoading()
            : SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    IOTextfieldWidget(
                      model: controller.email,
                    ),
                    const SizedBox(height: 16),
                    IOTextfieldWidget(
                      model: controller.birthdate,
                    ),
                    const SizedBox(height: 16),
                    IODropdownWidget(
                      model: controller.gender,
                      pickItems: controller.genderItems,
                      onSelect: controller.onSelectGender,
                    ),
                    const SizedBox(height: 16),
                    IODropdownWidget(
                      model: controller.family,
                      pickItems: controller.familyItems,
                      onSelect: controller.onSelectFamily,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      controller.addressText,
                      textAlign: TextAlign.left,
                      style: IOStyles.caption1Bold.copyWith(
                        color: IOColors.brand500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: IODropdownWidget(
                            model: controller.district,
                            pickItems: controller.districtItems.toList(),
                            onSelect: controller.onSelectDistrict,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: IODropdownWidget(
                            model: controller.khoroo,
                            pickItems: controller.filteredKhorooItems.toList(),
                            onSelect: controller.onSelectKhoroo,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
      ),
      bottomNavigationBar: Obx(
        () => IOBottomNavigationBar(
          child: IOButtonWidget(
            model: controller.saveButton.value,
            onPressed: controller.updateProfile,
          ),
        ),
      ),
    );
  }
}
