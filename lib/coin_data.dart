import 'package:bitcoin_ticker/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants.dart';

class CoinData {
  String _url;
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};

    for (String crypto in kCryptoList) {
      _url = '$kAPIUrl/$crypto/$selectedCurrency?apikey=$kAPIKey';

      http.Response response = await http.get(_url);

      if (response.statusCode == 200) {
        String data = response.body;
        var decodedData = jsonDecode(data);
        var coinRate = decodedData['rate'];
        String amount = coinRate.toStringAsFixed(0);
        cryptoPrices[crypto] = amount;
        //return amount;
      } else {
        print(response.statusCode);
      }
    }
    return cryptoPrices;
  }
}
