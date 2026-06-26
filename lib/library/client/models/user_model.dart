import 'package:carrefour/library/library.dart';
import 'package:g_json/g_json.dart';

class UserModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final int gender;
  final int familyCount;
  final String loyaltyUuid;
  final int districtId;
  final int khorooId;
  final String districtName;
  final String khorooName;
  final String dateBirth;
  final String password;
  final String avatar;
  final String barcode;
  final String ebarimtNumber;
  final bool isPrintBarimt;

  String get photoUrl => domain + avatar;

  UserModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        firstName = json['first_name'].stringValue,
        lastName = json['last_name'].stringValue,
        email = json['email'].stringValue,
        phone = json['phone'].stringValue,
        gender = json['gender'].integerValue,
        familyCount = json['family_count'].integerValue,
        loyaltyUuid = json['loyalty_uuid'].stringValue,
        districtId = json['district_id'].integerValue,
        khorooId = json['khoroo_id'].integerValue,
        districtName = json['district_name'].stringValue,
        khorooName = json['khoroo_name'].stringValue,
        dateBirth = json['date_birth'].stringValue,
        password = json['password'].stringValue,
        avatar = json['avatar'].stringValue,
        barcode = json['barcode'].stringValue,
        ebarimtNumber = json['ebarimt_number'].stringValue,
        isPrintBarimt = json['is_print_barimt'].booleanValue;

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone': phone,
      'gender': gender,
      'family_count': familyCount,
      'loyalty_uuid': loyaltyUuid,
      'district_id': districtId,
      'khoroo_id': khorooId,
      'district_name': districtName,
      'khoroo_name': khorooName,
      'date_birth': dateBirth,
      'password': password,
      'avatar': avatar,
      'barcode': barcode,
      'ebarimt_number': ebarimtNumber,
      'is_print_barimt': isPrintBarimt,
    };
  }
}
