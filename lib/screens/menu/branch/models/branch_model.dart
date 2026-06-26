import 'package:carrefour/library/library.dart';
import 'package:g_json/g_json.dart';

class BranchModel {
  final int id;
  final String name;
  final String photo;
  final String address;
  final String workingHoursStart;
  final String workingHoursEnd;
  final double latitude;
  final double longtitude;
  final String phone;
  final String phone2;

  String get photoUrl => domain + photo;
  String get workHours =>
      // ignore: prefer_interpolation_to_compose_strings
      workingHoursStart
          .toDateWithFormat(format: 'HH:mm:ss')
          .toFormattedString(format: 'HH:mm') +
      '-' +
      workingHoursEnd
          .toDateWithFormat(format: 'HH:mm:ss')
          .toFormattedString(format: 'HH:mm');

  BranchModel.fromJson(JSON json)
      : id = json['id'].integerValue,
        name = json['name'].stringValue,
        photo = json['photo'].stringValue,
        address = json['address'].stringValue,
        workingHoursStart = json['working_hours_start'].stringValue,
        workingHoursEnd = json['working_hours_end'].stringValue,
        latitude = json['latitude'].ddoubleValue,
        longtitude = json['longtitude'].ddoubleValue,
        phone = json['phone'].stringValue,
        phone2 = json['phone2'].stringValue;
}
