import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends IOController {
  @override
  void onInit() {
    super.onInit();
    UserStoreManager.shared.store.listenKey(kUser, (_) {
      user.value = HelperManager.user;
    });
  }

  void onChangePhone() {
    MenuRoute.toPhoneChangeNumber();
  }

  void onTapEdit() {
    MenuRoute.toProfileEdit();
  }

  void onTapPhoto() async {
    final type = await const ProfileImageSheet().show();
    if (type == null) return;
    pickImage(type);
  }

  Future<void> pickImage(ImageSource type) async {
    final pickedImage = await ImagePicker().pickImage(
      source: type,
      maxHeight: 1000,
      maxWidth: 1000,
    );
    if (pickedImage != null) {
      imageUpload(pickedImage);
    }
  }

  Future imageUpload(XFile image) async {
    final fileName = image.name;
    final data = dio.FormData.fromMap(
      {
        'file': dio.MultipartFile.fromBytes(
          await image.readAsBytes(),
          filename: fileName,
        ),
      },
    );
    final response = await CustomerApi().fileUpload(formData: data);

    if (response.isSuccess) {
      final imagePath = response.json['data'].stringValue;
      changeAvatar(imagePath);
    } else {
      showError(text: response.msg);
    }
  }

  Future changeAvatar(String image) async {
    final response = await CustomerApi().updateAvatar(image: image);
    if (response.isSuccess) {
      // final imagePath = response.json['data'].stringValue;
      ClientManager.getUserInfo();
    } else {
      showError(text: response.msg);
    }
  }

  final deleteAccountButton = IOButtonModel(
    label: 'Delete Account',
    type: IOButtonType.oulineBrand,
    size: IOButtonSize.medium,
    enabledForegroundColor: IOColors.errorPrimary,
  );

  Future onDeleteAccount() async {
    final confirm = await IODialogWarning(
      title:
          'Та бүртгэлээ устгахдаа итгэлтэй байна уу? \nБүртгэл устгасны дараа таны хувийн мэдээлэл, захиалгын түүх болон апптай холбоотой бүх мэдээлэл бүрмөсөн устах бөгөөд сэргээх боломжгүй.',
    ).show();

    if (confirm == null) return;

    await UserStoreManager.shared.deleteStore();
    Get.offAllNamed(IOPages.initial);
  }
}
