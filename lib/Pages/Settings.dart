import 'package:crypto_tracking_app/constants/Themes.dart';
import 'package:crypto_tracking_app/models/localStorage.dart';
import 'package:crypto_tracking_app/proviers/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:getwidget/getwidget.dart';
import 'dart:async';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  createAlert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text(
                  "This action will remove all favorites and reset the app. Are you sure you want to continue? This action is irreversible. The App will close after resetting data."),
              actions: <Widget>[
                TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      LocalStorage.clearData();
                      LocalStorage.pop();
                    },
                    child: Text(
                      "Yes, I am Sure",
                      style: TextStyle(color: Colors.white),
                    )),
                TextButton(
                    onPressed: () {
                      // Timer(Duration(milliseconds: 500), () {
                      //   closeApp(context);
                      // });
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel"))
              ]);
        });
  }

  @override
  late String currentIcon;
  Widget build(BuildContext context) {
    List<String> items = ['USD', 'INR'];
    String? selectedItem = 'USD';
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);

    if (themeProvider.themeMode == ThemeMode.light) {
      currentIcon = "dark_mode";
    } else {
      currentIcon = "light_mode";
    }
    return Expanded(
        child: ListView(
      children: <Widget>[
        // ListTile(
        //   title: Text(
        //     "Themes",
        //     style: TextStyle(fontSize: 25),
        //   ),
        //   //trailing: , Toggle to be added here
        // ),
        ListTile(
          title: Text(
            "Clear Preferences",
            style: TextStyle(fontSize: 24),
          ),
          trailing: RaisedButton(
            onPressed: () {
              createAlert(context);

              //LocalStorage.clearData();
              //LocalStorage.pop();
            },
            child: Text(
              "Clear",
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    ));
  }
}
//margin: EdgeInsets.only(top: 15),
