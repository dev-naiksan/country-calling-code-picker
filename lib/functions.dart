import 'dart:convert';

import 'package:flutter/widgets.dart';

import './country.dart';

class Utils {
  static Future<List<Country>> getCountries(BuildContext context) async {
    String rawData = await DefaultAssetBundle.of(context).loadString(
        'packages/country_calling_code_picker/raw/country_codes.json');
    if (rawData == null) {
      return [];
    }
    final parsed = json.decode(rawData.toString()).cast<Map<String, dynamic>>();
    return parsed.map<Country>((json) => new Country.fromJson(json)).toList();
  }
}
