import 'package:http/http.dart' as http;
import 'dart:convert';

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
];

class CoinData {
  Future<dynamic> getCoinData(String selecteditem) async {
    Map<String ,String> cryptoPrices={};
    for(String crypto in cryptoList){
    http.Response response = await http.get(Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/$crypto/$selecteditem?apikey=8B9EA58C-AFBF-4AD4-AA4F-17F083842D91'));
    if (response.statusCode == 200) {
      double price = jsonDecode(response.body)['rate'];
      cryptoPrices[crypto]=price.toStringAsFixed(0);

    } else {
      print(response.statusCode);
    }
  }
   // print(cryptoPrices);
    return cryptoPrices;
  }
}

// https://rest.coinapi.io/v1/exchangerate/BTC/USD?apikey=8B9EA58C-AFBF-4AD4-AA4F-17F083842D91
// rate
