import 'package:bitcoin_ticker/exchange_card.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'constants.dart';
import 'exchange_card.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  Map<String, String> cryptoPrices = {};

  DropdownButton<String> androidDropDown() {
    List<DropdownMenuItem<String>> dropDownItem = [];
    for (String currenciesListItem in kCurrenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currenciesListItem),
        value: currenciesListItem,
      );
      dropDownItem.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownItem,
      onChanged: (value) async {
        setState(() {
          selectedCurrency = value;
          //currencyConversion(selectedCurrency);
        });
        updateUI();
      },
    );
  }

  bool isWaiting = false;
  void updateUI() async {
    isWaiting = true;
    try {
      var rate = await CoinData().getCoinData(selectedCurrency);
      print(rate);
      isWaiting = false;
      setState(() {
        cryptoPrices = rate;
      });
    } catch (e) {}
  }

  CupertinoPicker iOSPicker() {
    List<Text> dropDownItem = [];
    for (String currency in kCurrenciesList) {
      var item = Text(
        currency,
        style: TextStyle(color: Colors.white),
      );
      dropDownItem.add(item);
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {});
      },
      children: dropDownItem,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    updateUI();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ExchangeCard(
            crypto: 'BTC',
            cryptoAmount: isWaiting ? '?' : cryptoPrices['BTC'],
            selectedCurrency: selectedCurrency,
          ),
          ExchangeCard(
            crypto: 'ETH',
            cryptoAmount: isWaiting ? '?' : cryptoPrices['ETH'],
            selectedCurrency: selectedCurrency,
          ),
          ExchangeCard(
            crypto: 'LTC',
            cryptoAmount: isWaiting ? '?' : cryptoPrices['LTC'],
            selectedCurrency: selectedCurrency,
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iOSPicker() : androidDropDown(),
          ),
        ],
      ),
    );
  }
}

//android drop down
