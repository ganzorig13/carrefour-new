import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProfileEditController extends IOController {
  final titleText = 'Нэмэлт мэдээлэл';
  final email = IOTextfieldModel(
    label: 'И-мэйл хаяг',
    placeholder: 'И-мэйл хаяг',
    validators: [ValidatorType.email],
    keyboardType: TextInputType.emailAddress,
  );
  final birthdate = IOTextfieldModel(
    label: 'Төрсөн өдөр',
    placeholder: 'YYYY / MM / DD',
    validators: [ValidatorType.notEmpty],
    keyboardType: TextInputType.number,
    inputFormatters: [
      DateInputFormatter(),
    ],
    maxLength: 10,
  );
  final gender = IODropdownModel<int>(
    label: 'Хүйс',
    placeholder: 'Хүйс',
    sheetTitle: 'Хүйс сонгох',
    validators: [ValidatorType.notEmpty],
  );
  final family = IODropdownModel<int>(
    label: 'Ам бүлийн тоо',
    placeholder: 'Ам бүлийн тоо',
    sheetTitle: 'Ам бүлийн тоо сонгох',
    validators: [ValidatorType.notEmpty],
  );

  final addressText = 'Оршин суугаа дүүрэг, хороо';

  final district = IODropdownModel(
    label: '',
    placeholder: 'Дүүрэг',
    sheetTitle: 'Дүүрэг сонгох',
    validators: [ValidatorType.notEmpty],
    hasTitle: false,
  );
  final khoroo = IODropdownModel(
    label: '',
    placeholder: 'Хороо',
    sheetTitle: 'Хороо сонгох',
    validators: [ValidatorType.notEmpty],
    hasTitle: false,
  );

  final saveButton = IOButtonModel(
    label: 'Хадгалах',
    type: IOButtonType.primary,
    size: IOButtonSize.medium,
    isEnabled: false,
  ).obs;

  final genderItems = [
    IODropdownSheetModel(name: 'Эрэгтэй', value: 0),
    IODropdownSheetModel(name: 'Эмэгтэй', value: 1),
  ];

  final familyItems = [
    IODropdownSheetModel(name: '1', value: 1),
    IODropdownSheetModel(name: '2', value: 2),
    IODropdownSheetModel(name: '3', value: 3),
    IODropdownSheetModel(name: '4', value: 4),
    IODropdownSheetModel(name: '5', value: 5),
    IODropdownSheetModel(name: '6', value: 6),
    IODropdownSheetModel(name: '7', value: 7),
  ];

  final districtItems = <IODropdownSheetModel<int>>[].obs;
  final khorooItems = <KhorooModel>[].obs;
  final filteredKhorooItems = <IODropdownSheetModel<int>>[].obs;

  @override
  void onInit() {
    super.onInit();
    email.status.addListener(checkValidation);
    birthdate.status.addListener(checkValidation);
    gender.status.addListener(checkValidation);
    family.status.addListener(checkValidation);
    district.status.addListener(checkValidation);
    khoroo.status.addListener(checkValidation);
    setInitialData();
    getAddress();
  }

  void checkValidation() {
    saveButton.update((val) {
      val?.isEnabled = email.isValid &&
          birthdate.isValid &&
          gender.isValid &&
          family.isValid &&
          district.isValid &&
          khoroo.isValid;
    });
  }

  void setInitialData() {
    if (user.value.email.isNotEmpty) {
      email.controller.text = user.value.email;
      email.status.value = IOTextfieldStatusModel(
        status: IOTextfieldStatus.success,
      );
    }

    if (user.value.dateBirth.isNotEmpty) {
      birthdate.controller.text = user.value.dateBirth
          .toDateWithFormat(format: 'yyyy-MM-dd')
          .toFormattedString(format: 'yyyy/MM/dd');
      birthdate.status.value = IOTextfieldStatusModel(
        status: IOTextfieldStatus.success,
      );
    }
    if (user.value.gender == 0 || user.value.gender == 1) {
      gender.setValue(
        IODropdownSheetModel(
          name: user.value.gender == 0 ? 'Эрэгтэй' : 'Эмэгтэй',
          value: user.value.gender,
        ),
      );
      gender.status.value = IOTextfieldStatusModel(
        status: IOTextfieldStatus.success,
      );
    }
    if (user.value.familyCount != 0) {
      family.setValue(
        IODropdownSheetModel(
          name: '${user.value.familyCount}',
          value: user.value.familyCount,
        ),
      );
      family.status.value = IOTextfieldStatusModel(
        status: IOTextfieldStatus.success,
      );
    }
    if (user.value.districtName.isNotEmpty) {
      district.setValue(
        IODropdownSheetModel(
          name: user.value.districtName,
          value: user.value.districtId,
        ),
      );
      district.status.value = IOTextfieldStatusModel(
        status: IOTextfieldStatus.success,
      );
    }
    if (user.value.khorooName.isNotEmpty) {
      khoroo.setValue(
        IODropdownSheetModel(
          name: user.value.khorooName,
          value: user.value.khorooId,
        ),
      );
      khoroo.status.value = IOTextfieldStatusModel(
        status: IOTextfieldStatus.success,
      );
    }
    checkValidation();
  }

  void onSelectGender(IODropdownSheetModel<int> item) {
    Get.focusScope?.unfocus();
    gender.setValue(item);
  }

  void onSelectFamily(IODropdownSheetModel<int> item) {
    Get.focusScope?.unfocus();
    family.setValue(item);
  }

  void onSelectDistrict(IODropdownSheetModel<int> item) {
    Get.focusScope?.unfocus();
    district.setValue(item);

    khoroo.setValue(null);
    filteredKhorooItems.value = khorooItems
        .where((e) => e.district == item.value)
        .map((e) => IODropdownSheetModel(name: e.name, value: e.id))
        .toList();
  }

  void onSelectKhoroo(IODropdownSheetModel<int> item) {
    Get.focusScope?.unfocus();
    khoroo.setValue(item);
  }

  Future getAddress() async {
    isInitialLoading.value = true;
    final response = await CustomerApi().getAddress();
    isInitialLoading.value = false;

    if (response.isSuccess) {
      districtItems.value = response.data['list_district'].listValue
          .map(
            (e) => IODropdownSheetModel(
              name: e['name'].stringValue,
              value: e['id'].integerValue,
            ),
          )
          .toList();
      final tempKhoroo = response.data['list_khoroo'].listValue
          .map((e) => KhorooModel.fromJson(e))
          .toList();
      tempKhoroo.sort((a, b) {
        final aNum = int.tryParse(a.name.split('-').first.toString()) ?? 0;
        final bNum = int.tryParse(b.name.split('-').first.toString()) ?? 0;
        return aNum.compareTo(bNum);
      });
      khorooItems.value = tempKhoroo;
    } else {
      Get.back();
      showError(text: response.msg);
    }
  }

  Future updateProfile() async {
    isLoading.value = true;
    saveButton.update((val) {
      val?.isLoading = true;
    });
    final response = await CustomerApi().updateProfile(
      email: email.value,
      dateBirth: birthdate.value
          .toDateWithFormat(format: 'yyyy/MM/dd')
          .toFormattedString(format: 'yyyy-MM-dd'),
      gender: gender.dropdownValue ?? 0,
      family: family.dropdownValue ?? 0,
      districtId: district.dropdownValue ?? 0,
      khotooId: khoroo.dropdownValue ?? 0,
    );
    isLoading.value = false;
    saveButton.update((val) {
      val?.isLoading = false;
    });

    if (response.isSuccess) {
      ClientManager.getUserInfo();
      Get.back();
      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().getPoint();
      }
      if (Get.isRegistered<PromoPageController>()) {
        Get.find<PromoPageController>().refreshNotifier.notify();
      }
    } else {
      showError(text: response.msg);
    }
  }
}
