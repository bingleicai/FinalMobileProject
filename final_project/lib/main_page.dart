import 'package:flutter/material.dart';
import 'airplane_list_page.dart'; // Import the AirplaneListPage
import 'generated/l10n.dart';

class MainPage extends StatelessWidget {
  final Function(Locale) changeLanguage;

  MainPage({required this.changeLanguage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).appTitle),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'en') {
                changeLanguage(Locale('en'));
              } else if (value == 'zh') {
                changeLanguage(Locale('zh'));
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: 'en',
                  child: Text('English'),
                ),
                PopupMenuItem(
                  value: 'zh',
                  child: Text('中文'),
                ),
              ];
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
              child: Text(S.of(context).airplaneList), // Change the button text to "Airplane List"
            ),
          ],
        ),
      ),
    );
  }
}
