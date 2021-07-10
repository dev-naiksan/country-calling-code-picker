class Country {
  final String name;
  final String flag;
  final String countryCode;
  final String callingCode;

  const Country(this.name, this.flag, this.countryCode, this.callingCode);

  factory Country.fromJson(Map<String, dynamic> json) {
    return new Country(
      json['name'] as String,
      json['flag'] as String,
      json['country_code'] as String,
      json['calling_code'] as String,
    );
  }
}
