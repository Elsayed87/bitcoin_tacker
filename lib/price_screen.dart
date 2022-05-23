import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_screen.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';

  DropdownButton AndoridDropDown() {
    List<DropdownMenuItem<String>> dropList = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropList.add(newItem);
    }
    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropList,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value.toString();
            getRate();
          });
        });
  }

  Widget IosPicker() {
    List<Text> pickerList = [];
    for (String currency in currenciesList) {
      pickerList.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (index) {
        setState(() {
          selectedCurrency = currenciesList[index].toString();
          getRate();
        });
      },
      children: pickerList,
    );
  }

  @override
  void initState() {
    getRate();

    super.initState();
  }

  String value = '?';
  var myMap;
  bool isWaiting = false;
  void getRate() async {
    isWaiting = true;
    try {
      CoinData coinData = CoinData();
      myMap = await coinData.getCoinData(selectedCurrency);
      setState(() {
        value = myMap.toString();
        isWaiting = false;
      });
    } catch (e) {
      print(e);
    }
  }
  void createCryptoCard(){
    for (String crypto in cryptoList){
      CryptoCard(cryptoCurrency: crypto,
        value:isWaiting ? '?' : myMap[cryptoList[0]] ,
        selectedCurrency: selectedCurrency,);
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Column(
            children: [
              CryptoCard(
                value: isWaiting ? '?' : myMap[cryptoList[0]],
                selectedCurrency: selectedCurrency,
                cryptoCurrency: 'BTC',
              ),
              CryptoCard(
                value: isWaiting ? '?' : myMap[cryptoList[1]],
                selectedCurrency: selectedCurrency,
                cryptoCurrency: 'ETH',
              ),
              CryptoCard(
                value: isWaiting ? '?' : myMap[cryptoList[2]],
                selectedCurrency: selectedCurrency,
                cryptoCurrency: 'LTC',
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? IosPicker() : AndoridDropDown(),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  CryptoCard({
    required this.value,
    required this.selectedCurrency,
    required this.cryptoCurrency,
  });

  final String value;
  final String selectedCurrency;
  final String cryptoCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Colors.lightBlueAccent,
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Text(
            '1 $cryptoCurrency = $value $selectedCurrency',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
