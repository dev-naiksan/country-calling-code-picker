library countrycodepicker;

import 'package:flutter/material.dart';

import 'country.dart';
import 'functions.dart';

const TextStyle _defaultItemTextStyle = const TextStyle(fontSize: 16);
const TextStyle _defaultSearchInputStyle = const TextStyle(fontSize: 16);

class CountryPickerWidget extends StatefulWidget {
  /// This callback will be called on selection of a [Country].
  final ValueChanged<Country> onSelected;

  /// [itemTextStyle] can be used to change the TextStyle of the Text in ListItem. Default is [_defaultItemTextStyle]
  final TextStyle itemTextStyle;

  /// [searchInputStyle] can be used to change the TextStyle of the Text in SearchBox. Default is [searchInputStyle]
  final TextStyle searchInputStyle;

  /// [searchInputDecoration] can be used to change the decoration for SearchBox.
  final InputDecoration searchInputDecoration;

  /// Flag icon size (width). Default set to 32.
  final double flagIconSize;

  ///Can be set to `true` for showing the List Separator. Default set to `false`
  final bool showSeparator;

  const CountryPickerWidget({
    Key key,
    this.onSelected,
    this.itemTextStyle = _defaultItemTextStyle,
    this.searchInputStyle = _defaultSearchInputStyle,
    this.searchInputDecoration,
    this.flagIconSize = 32,
    this.showSeparator = false,
  }) : super(key: key);

  @override
  _CountryPickerWidgetState createState() => _CountryPickerWidgetState();
}

class _CountryPickerWidgetState extends State<CountryPickerWidget> {
  List<Country> _list = new List();
  List<Country> _filteredList = new List();
  TextEditingController _controller = new TextEditingController();

  void _onSearch(text) {
    if (text == null || text.isEmpty) {
      setState(() {
        _filteredList.clear();
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
  }

  @override
  void initState() {
    loadList();
    super.initState();
  }

  void loadList() async {
    _list = await Utils.getCountries(context);
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
            child: SizedBox(
              height: 52,
              child: TextField(
                style: widget.searchInputStyle,
                decoration: widget.searchInputDecoration ??
                    InputDecoration(
                        suffixIcon: Visibility(
                          visible: _controller.text.isNotEmpty,
                          child: InkWell(
                            child: Icon(Icons.clear),
                            onTap: () => setState(() {
                              _controller.clear();
                              _filteredList.clear();
                              _filteredList.addAll(_list);
                            }),
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(),
                            borderRadius: BorderRadius.circular(30))),
                textInputAction: TextInputAction.done,
                controller: _controller,
                onChanged: _onSearch,
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.only(top: 16),
              itemCount: _filteredList.length,
              separatorBuilder: (_, index) =>
                  widget.showSeparator ? Divider() : Container(),
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
                          width: widget.flagIconSize,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Expanded(
                            child: Text(
                          '${_filteredList[index].callingCode} ${_filteredList[index].name}',
                          style: widget.itemTextStyle,
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
