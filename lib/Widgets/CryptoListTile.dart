import 'package:crypto_tracking_app/models/Cryptocurrency.dart';
import 'package:crypto_tracking_app/proviers/market_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Pages/DetailsPage.dart';

class CryptoListTile extends StatelessWidget {
  final CryptoCurrency currentCrypto;

  const CryptoListTile({Key? key, required this.currentCrypto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    int numDecimals = 2;
    if (currentCrypto.currentPrice! < 0.1) {
      numDecimals = 8;
    } else {
      numDecimals = 2;
    }
    MarketProvider marketProvider =
        Provider.of<MarketProvider>(context, listen: false);

    return ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsPage(id: currentCrypto.id!),
              ));
        },
        contentPadding: EdgeInsets.only(left: 0, right: 0),
        leading: CircleAvatar(
            backgroundColor: Colors.white,
            backgroundImage: NetworkImage(currentCrypto.image!)),
        title: Flexible(
          child: Text(
            currentCrypto.name! + " #" + currentCrypto.marketCapRank.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Text(currentCrypto.symbol!.toUpperCase()),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  currentCrypto.currentPrice!.toStringAsFixed(numDecimals),
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Builder(builder: (context) {
                  double priceChange = currentCrypto.priceChange24!;
                  double priceChangePercentage =
                      currentCrypto.priceChangePercentage24!;

                  if (priceChange < 0) {
                    return Text(
                      "${priceChangePercentage.toStringAsFixed(2)}" + "%",
                      style: TextStyle(color: Colors.red),
                    );
                  } else {
                    return Text(
                      "+" + "${priceChangePercentage.toStringAsFixed(2)}" + "%",
                      style: TextStyle(color: Colors.green),
                    );
                  }
                })
              ],
            ),
            (currentCrypto.isFavorite == false)
                ? IconButton(
                    onPressed: () {
                      marketProvider.addFavorite(currentCrypto);
                    },
                    icon: Icon(CupertinoIcons.heart))
                : IconButton(
                    onPressed: () {
                      marketProvider.removeFavorite(currentCrypto);
                    },
                    icon: Icon(CupertinoIcons.heart_fill),
                    color: Colors.red,
                  )
          ],
        ));
  }
}
