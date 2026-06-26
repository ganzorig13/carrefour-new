import 'package:carrefour/library/library.dart';
import 'package:carrefour/screens/screens.dart';
import 'package:dio/dio.dart' as dio;

class CustomerApi extends IOClient {
  Future<IOResponse> getAccessToken({required String refresh}) {
    const path = '/api/customer/token/refresh';
    final data = {
      'refresh_token': refresh,
    };
    return sendPostRequest(path, data: data, hasToken: false);
  }

  Future<IOResponse> sendOtp({
    required String phone,
    required String type,
    String? validationToken,
  }) {
    const path = '/api/customer/auth';
    final data = <String, dynamic>{
      'phone': phone,
      'code_type': type,
      if (validationToken != null && validationToken.isNotEmpty) 'validation_token': validationToken,
    };
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> checkOtp({
    required String phone,
    required String type,
    required String otp,
    String? validationToken,
  }) {
    const path = '/api/customer/auth/verify';
    final data = <String, dynamic>{
      'phone': phone,
      'code_type': type,
      'auth_code': otp,
      if (validationToken != null && validationToken.isNotEmpty) 'validation_token': validationToken,
    };
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> register({required SignUpModel model}) async {
    const path = '/api/customer/register';
    final data = {
      'phone': model.phone,
      'first_name': model.firstName,
      'last_name': model.lastName,
      'password': model.password,
      'token': model.otpToken,
      'device_os_type': HelperManager.os,
      'device_model_no': await HelperManager.deviceModel,
      'firebase_token': HelperManager.fcmToken,
    };
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> login({
    required String phone,
    required String token,
  }) async {
    const path = '/api/customer/login';
    final data = {
      'phone': phone,
      'token': token,
      'device_os_type': HelperManager.os,
      'device_model_no': await HelperManager.deviceModel,
      'firebase_token': HelperManager.fcmToken,
    };
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> getBanner({required String key}) {
    const path = '/api/site/banner';
    final query = {'key': key};
    return sendGetRequest(path, query: query);
  }

  Future<IOResponse> getCatalogList() {
    const path = '/api/site/catalog/list';

    return sendGetRequest(path);
  }

  Future<IOResponse> getCatalogInfo({required int id}) {
    const path = '/api/site/catalog/detail';
    final data = {'id': id};
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> getUserInfo() {
    const path = '/api/customer/profile';
    return sendPostRequest(path);
  }

  Future<IOResponse> getAddress() {
    const path = '/api/customer/address/info';
    return sendPostRequest(path);
  }

  Future<IOResponse> changePin({
    required String oldPin,
    required String newPin,
  }) {
    const path = '/api/customer/password/change';
    final data = {
      'old_password': oldPin,
      'new_password': newPin,
    };
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> resetPin({
    required String token,
    required String pin,
  }) {
    const path = '/api/customer/password/reset';
    final data = {
      'token': token,
      'new_password': pin,
    };
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> createPin({required String pin}) {
    const path = '/api/customer/password/create';
    final data = {
      'new_password': pin,
    };
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> updateProfile({
    required String email,
    required String dateBirth,
    required int gender,
    required int family,
    required int districtId,
    required int khotooId,
  }) {
    const path = '/api/customer/profile/update';
    final data = {
      'email': email,
      'date_birth': dateBirth,
      'gender': gender,
      'family_count': family,
      'district_id': districtId,
      'khoroo_id': khotooId,
    };
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> updateAvatar({
    required String image,
  }) {
    const path = '/api/customer/avatar';
    final data = {
      'image_url': image,
    };
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> changePhone({
    required String phone,
    required String token,
  }) {
    const path = '/api/customer/phone/change';
    final data = {
      'new_phone': phone,
      'token': token,
    };
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> getPoint() {
    const path = '/api/customer/balance';
    return sendPostRequest(path);
  }

  Future<IOResponse> getPurchaseHistory({
    required int limit,
    required int offset,
  }) {
    final path = '/api/purchase/history?limit=$limit&offset=$offset';
    return sendPostRequest(path);
  }

  Future<IOResponse> getPointHistory({
    required String type,
    required int limit,
    required int offset,
  }) {
    final data = {'type': type};
    final path = '/api/purchase/history/point?limit=$limit&offset=$offset';
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> getFinance({required int month}) {
    final data = {'month_count': month};
    const path = '/api/purchase/myfinance';
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> usePoint({
    required Map<String, dynamic> qrData,
    required String pin,
    required bool hasBiometric,
  }) {
    final data = <String, dynamic>{
      'password': pin,
      'is_biometric': hasBiometric,
    };
    data.addAll(qrData);
    const path = '/api/purchase/point/confirm';
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> getNotificationList({
    required int limit,
    required int offset,
  }) {
    final path = '/notification/list?limit=$limit&offset=$offset';
    return sendPostRequest(path);
  }

  Future<IOResponse> getNotificationDetail({required int id}) {
    const path = '/notification/detail';
    final data = {
      'id': id,
    };
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> getNotificationCount() {
    const path = '/notification/count';
    return sendPostRequest(path);
  }

  Future<IOResponse> getRateInfo() {
    const path = '/api/site/feedback/info';
    return sendGetRequest(path);
  }

  Future<IOResponse> sendRateInfo({
    required int id,
    required String answer,
    required int point,
  }) {
    const path = '/api/site/feedback/new';
    final data = {
      'purchase_id': id,
      'rating': point,
      if (answer.isNotEmpty) 'answer': answer,
    };
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> fileUpload({
    required dio.FormData formData,
  }) {
    const path = '/api/site/upload/file';
    return sendMultiPartRequest(path, formData: formData);
  }

  Future<IOResponse> getPromoList({
    required String type,
  }) {
    const path = '/mission/list';
    final data = {
      'type': type,
    };
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> getPromoDetail({required int id}) {
    const path = '/mission/detail';
    final data = {
      'id': id,
    };
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> getPromoSurveyDetail({required int id}) {
    const path = '/mission/survey/detail';
    final data = {
      'id': id,
    };
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> submitPromoSurvey({required Map<String, dynamic> data}) {
    const path = '/mission/survey/respond';
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> setCompletePromo({required int missionId}) {
    const path = '/mission/setcomplete';
    final data = {'id': missionId};
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> addEbarimt({
    required String number,
    required bool isPrint,
  }) {
    const path = '/api/customer/ebarimt/change';
    final data = {
      'ebarimt_number': number,
      'is_print_barimt': isPrint,
    };
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> giftCards() {
    const path = '/api/customer/gift-cards';
    return sendPostRequest(path);
  }

  Future<IOResponse> giftCardDetail({
    required String code,
    required String type,
  }) {
    const path = '/api/customer/gift-card/detail';
    final data = {
      'code': code,
      'type': type,
    };
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> giftCardLink({
    required String barcodeValue,
  }) {
    const path = '/api/customer/gift-card/link';
    final data = {
      'code': barcodeValue,
    };
    return sendPostRequest(path, data: data);
  }

  Future<IOResponse> appVersionCheck() async {
    const path = '/api/app/version-check';

    final currentVersion = await HelperManager.version;

    final data = {
      'platform': HelperManager.os,
      'current_version': currentVersion,
    };

    print('))))))))))++++${HelperManager.os}');
    print('))))))))))++++$currentVersion');

    return sendPostRequest(
      path,
      data: data,
      hasToken: false,
    );
  }
}
