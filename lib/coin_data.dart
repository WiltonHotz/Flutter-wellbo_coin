import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
  'DOGE',
];

const coinAPIURL = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'A404AE1E-B3BD-4680-8070-AE982503F3C0';
Map<String, String> headers = {'X-CoinAPI-Key':apiKey};

class CoinData {
  Future getCoinData(String selectedCurrency) async {

    var cryptoPrices = {};
    for(String crypto in cryptoList) {
      String requestURL = '$coinAPIURL/$crypto/$selectedCurrency';
      http.Response response = await http.get(requestURL, headers: headers);

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rate'].toDouble();
        if(crypto != 'DOGE') {
          cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
        } else {
          cryptoPrices[crypto] = lastPrice.toStringAsFixed(10);
        }
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
