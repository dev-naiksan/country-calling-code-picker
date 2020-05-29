# Country Calling Code Picker

Searchable country picker widget ready to user in a dialog, bottom sheet and even in full screen!
![Example](https://user-images.githubusercontent.com/65971744/83264373-9782d680-a1dd-11ea-88f2-cebe687da65a.png)

1: Import the plugin using
```dart
 import 'package:country_calling_code_picker/picker.dart';
```

2: Use utility function showCountryPickerSheet to show a bottom sheet picker.
![Screenshot_20200529-182708](https://user-images.githubusercontent.com/65971744/83264384-9c478a80-a1dd-11ea-8385-bca897f1d3d5.png)
```dart
void _showCountryPicker() async{
    final country = await showCountryPickerSheet(context,);
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
}

```   
3: Use utility function showCountryPickerDialog to show a dialog.
![Screenshot_20200529-182701](https://user-images.githubusercontent.com/65971744/83264376-994c9a00-a1dd-11ea-86a1-4fec8554f6f9.png)
```dart
void _showCountryPicker() async{
    final country = await showCountryPickerDialog(context,);
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
}

```  
4: CountryPickerWidget can be used for showing in a full screen.
![Screenshot_20200529-183002](https://user-images.githubusercontent.com/65971744/83264392-9e114e00-a1dd-11ea-99a0-1387fd9d2c0f.png)
```dart
class PickerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Country'),
      ),
      body: Container(
        child: CountryPickerWidget(
          onSelected: (country) => Navigator.pop(context, country),
        ),
      ),
    );
  }
}

```  
5. If you just need the list of countries for making your own custom country picker, you can all getCountries() which returns list of countries. 

```dart
List<Country> list = await getCountries(context);
```
