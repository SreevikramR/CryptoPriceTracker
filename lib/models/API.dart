import 'dart:convert';

import 'package:http/http.dart' as http;

class API {
  static Future<List<dynamic>> getMarkets() async {
    String Currency = "usd";
    String url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=" +
        Currency +
        "&order=market_cap_desc&per_page=100&page=1&sparkline=false&price_change_percentage=24h";
    try {
      Uri requestPath = Uri.parse(url);

      var response = await http.get(requestPath);
      var decodedResponse = jsonDecode(response.body);

      List<dynamic> markets = decodedResponse as List<dynamic>;
      return markets;
    } catch (ex) {
      return [];
    }
  }
}
