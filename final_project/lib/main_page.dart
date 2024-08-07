import 'package:flutter/material.dart';
import 'generated/l10n.dart'; // Correct import for localization
import 'airplane_list_page.dart'; // Ensure the import path is correct
import 'flight_list_page.dart'; // Ensure the import path is correct

class MainPage extends StatefulWidget {
  final void Function(Locale) setLocale;

  MainPage({required this.setLocale});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Locale _selectedLocale = Locale('en');

  void _switchLanguage(Locale locale) {
    setState(() {
      _selectedLocale = locale;
    });
    widget.setLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appTitle),
        actions: [
          DropdownButton<Locale>(
            value: _selectedLocale,
            icon: Icon(Icons.language, color: Colors.white),
            items: [
              DropdownMenuItem(
                value: Locale('en'),
                child: Text('English'),
              ),
              DropdownMenuItem(
                value: Locale('zh'),
                child: Text('中文'),
              ),
            ],
            onChanged: (Locale? newValue) {
              if (newValue != null) {
                _switchLanguage(newValue);
              }
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AirplaneListPage()),
                );
              },
              child: Text(S.of(context).airplaneList),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FlightListPage()),
                );
              },
              child: Text(S.of(context).flightList),
            ),
          ],
        ),
      ),
    );
  }
}