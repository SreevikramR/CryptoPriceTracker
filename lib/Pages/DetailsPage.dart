import 'dart:async';

import 'package:crypto_tracking_app/models/Cryptocurrency.dart';
import 'package:crypto_tracking_app/proviers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatefulWidget {
  final String id;

  const DetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Widget titleAndDetail(
      String title, String detail, CrossAxisAlignment crossAxisAlignment) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(detail, style: TextStyle(fontSize: 18))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Consumer<MarketProvider>(
                builder: (context, marketProvider, child) {
                  CryptoCurrency currentCrypto =
                      marketProvider.fetchCryptoById(widget.id);

                  return RefreshIndicator(
                    onRefresh: () async {
                      await marketProvider.fetchData();
                    },
                    child: ListView(
                      physics: BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.all(0),
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: NetworkImage(currentCrypto.image!),
                          ),
                          title: Text(
                            currentCrypto.name! +
                                " (${currentCrypto.symbol!.toUpperCase()})",
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              currentCrypto.currentPrice!.toStringAsFixed(4),
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Price Change (24hrs)",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 22)),
                            Builder(builder: (context) {
                              double priceChange = currentCrypto.priceChange24!;
                              double priceChangePercentage =
                                  currentCrypto.priceChangePercentage24!;

                              if (priceChange < 0) {
                                return Text(
                                  "${priceChangePercentage.toStringAsFixed(2)}" +
                                      "%" +
                                      "(${priceChange.toStringAsFixed(2)})",
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 23),
                                );
                              } else {
                                return Text(
                                  "+" +
                                      "${priceChangePercentage.toStringAsFixed(2)}" +
                                      "%" +
                                      " (${priceChange.toStringAsFixed(2)})",
                                  style: TextStyle(
                                      color: Colors.green, fontSize: 23),
                                );
                              }
                            })
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            titleAndDetail(
                                "Market Cap",
                                currentCrypto.marketCap!.toStringAsFixed(2),
                                CrossAxisAlignment.start),
                            titleAndDetail(
                                "Market Cap Rank",
                                currentCrypto.marketCapRank!.toString(),
                                CrossAxisAlignment.end)
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            titleAndDetail(
                                "24hr Low",
                                currentCrypto.low24!.toStringAsFixed(4),
                                CrossAxisAlignment.start),
                            titleAndDetail(
                                "24hr High",
                                currentCrypto.high24!.toStringAsFixed(4),
                                CrossAxisAlignment.end)
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            titleAndDetail(
                                "Circulating Supply",
                                currentCrypto.circulatingSupply!
                                    .toInt()
                                    .toString(),
                                CrossAxisAlignment.start)
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            titleAndDetail(
                                "All Time High",
                                currentCrypto.ath!.toStringAsFixed(4),
                                CrossAxisAlignment.start),
                            titleAndDetail(
                                "All Time Low",
                                currentCrypto.atl!.toStringAsFixed(4),
                                CrossAxisAlignment.end)
                          ],
                        )
                      ],
                    ),
                  );
                },
              ))),
    );
  }
}