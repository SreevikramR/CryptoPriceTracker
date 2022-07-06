import 'package:crypto_tracking_app/Pages/DetailsPage.dart';
import 'package:crypto_tracking_app/Widgets/CryptoListTile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/Cryptocurrency.dart';
import '../proviers/market_provider.dart';

class Markets extends StatefulWidget {
  const Markets({Key? key}) : super(key: key);

  @override
  _MarketsState createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  @override
  Widget build(BuildContext context) {
    return Expanded(child:
        Consumer<MarketProvider>(builder: (context, marketProvider, child) {
      if (marketProvider.isLoading == true) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        if (marketProvider.markets.isNotEmpty) {
          return RefreshIndicator(
            onRefresh: () async {
              await marketProvider.fetchData();
            },
            child: ListView.builder(
              physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: marketProvider.markets.length,
              itemBuilder: (context, index) {
                CryptoCurrency currentCrypto = marketProvider.markets[index];

                return CryptoListTile(currentCrypto: currentCrypto);
              },
            ),
          );
        } else {
          return Center(
              child: Text(
                  "Unable to connect to server, try restarting the app or try again after a while."));
        }
      }
    }));
  }
}
