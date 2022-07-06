import 'dart:async';

import 'package:crypto_tracking_app/Pages/DetailsPage.dart';
import 'package:crypto_tracking_app/Pages/Favorites.dart';
import 'package:crypto_tracking_app/Pages/Markets.dart';
import 'Settings.dart';
import 'package:crypto_tracking_app/constants/Themes.dart';
import 'package:crypto_tracking_app/models/Cryptocurrency.dart';
import 'package:crypto_tracking_app/proviers/market_provider.dart';
import 'package:crypto_tracking_app/proviers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController viewController;

  List<Widget> pageList = <Widget>[Markets(), Favorites(), Settings()];

  @override
  void initState() {
    super.initState();
    viewController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  int pageIndex = 0;
  int numDecimals = 4;
  String pageTitle = "Top Cryptocurrencies";
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: pageIndex,
          onTap: (value) {
            setState(() {
              pageIndex = value;
              if (pageIndex == 0) {
                pageTitle = "Top Cryptocurrencies";
              } else if (pageIndex == 1) {
                pageTitle = "Favorites";
              } else if (pageIndex == 2) {
                pageTitle = "Settings";
              }
            });
            ;
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: (themeProvider.themeMode == ThemeMode.light)
              ? Colors.white
              : darkTheme.scaffoldBackgroundColor,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "Favorites"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings")
          ]),
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      pageTitle,
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          themeProvider.toggleTheme();
                        },
                        padding: EdgeInsets.all(0),
                        icon: (themeProvider.themeMode == ThemeMode.light)
                            ? Icon(Icons.dark_mode)
                            : Icon(Icons.light_mode))
                  ],
                ),
                pageList[pageIndex],
              ],
            )),
      ),
    );
  }
}
