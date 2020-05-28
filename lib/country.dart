class Country {
  final String name;
  final String flag;
  final String countryCode;
  final String callingCode;

  const Country({this.name, this.flag, this.countryCode, this.callingCode});

  factory Country.fromJson(Map<String, dynamic> json) {
    return new Country(
      name: json['name'] as String,
      flag: json['flag'] as String,
      countryCode: json['country_code'] as String,
      callingCode: json['calling_code'] as String,
    );
  }
}
