import 'package:country_calling_code_picker/country.dart';
import 'package:flutter/material.dart';
import 'package:country_calling_code_picker/countrycodepicker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Country _selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country Picker'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Selected Calling code: ${_selectedCountry?.callingCode}',
            ),
            FlatButton(
              child: Text('Select Country Code'),
              onPressed: _onPressed,
            )
          ],
        ),
      ),
    );
  }

  void _onPressed() async {
    final country =
        await Navigator.push(context, new MaterialPageRoute(builder: (context) {
      return PickerPage();
    }));
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }
}

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
