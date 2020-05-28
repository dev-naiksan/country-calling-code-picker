library countrycodepicker;

import 'package:flutter/material.dart';

import 'country.dart';
import 'functions.dart';

class CountryPickerWidget extends StatefulWidget {
  final ValueChanged<Country> onSelected;

  const CountryPickerWidget({Key key, this.onSelected}) : super(key: key);

  @override
  _CountryPickerWidgetState createState() => _CountryPickerWidgetState();
}

class _CountryPickerWidgetState extends State<CountryPickerWidget> {
  List<Country> _list = new List();
  List<Country> _filteredList = new List();
  TextEditingController _controller = new TextEditingController();

  @override
  void initState() {
    loadList();
    super.initState();
  }

  void loadList() async {
    _list = await getCountries(context);
    setState(() {
      _filteredList = _list.map((e) => e).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 16,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 24, right: 24),
            child: TextField(
              textInputAction: TextInputAction.done,
              controller: _controller,
              onChanged: (text) {
                if (text == null || text.isEmpty) {
                  setState(() {
                    _filteredList.addAll(_list);
                  });
                } else {
                  setState(() {
                    _filteredList = _list
                        .where((element) =>
                            element.name.toLowerCase().contains(text) ||
                            element.callingCode.toLowerCase().contains(text) ||
                            element.countryCode.toLowerCase().startsWith(text))
                        .map((e) => e)
                        .toList();
                  });
                }
              },
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(0),
              itemCount: _filteredList.length,
              itemBuilder: (_, index) {
                return InkWell(
                  onTap: () {
                    widget.onSelected(_filteredList[index]);
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: 12, top: 12, left: 24, right: 24),
                    child: Row(
                      children: <Widget>[
                        Image.asset(
                          _filteredList[index].flag,
                          package: 'country_calling_code_picker',
                          width: 32,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: Text(
                          '${_filteredList[index].callingCode} ${_filteredList[index].name}',
                          style: TextStyle(fontSize: 15),
                        )),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
