import 'dart:async';
import 'package:cryptotracker/Models/API.dart';
import 'package:cryptotracker/Models/Crytpocurrency.dart';
import 'package:cryptotracker/Models/localStorage.dart';
import 'package:flutter/cupertino.dart';

class Marketprovider with  ChangeNotifier{
  bool isloading = true;
  List<Cryptocurrency> markets = [];

  Marketprovider(){
    fetchdata();
  }

  Future<void> fetchdata() async{
    List<dynamic> _markets = await API.getMarkets();
    List<String> favourites = await LocalStorage.fetchFavourites();

    List<Cryptocurrency> temp = [];
    for (var market in _markets ){
      Cryptocurrency newCrypto = Cryptocurrency.fromJSON(market);
      if(favourites.contains(newCrypto.id)){
        newCrypto.isFavorite = true;
      }
      temp.add(newCrypto);
    }
    markets = temp;
    isloading  = false;
    notifyListeners();


  }

  Cryptocurrency fetchCryptoById(String id) {
    Cryptocurrency crypto = markets.where((element) => element.id == id).toList()[0];
    return crypto;
  }
  Future<void> addFavourite(Cryptocurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFavorite = true;
    await LocalStorage.addFavourite(crypto.id!);
    notifyListeners();
  }
  Future<void> removeFavourite(Cryptocurrency crypto) async {
    int indexOfCrypto = markets.indexOf(crypto);
    markets[indexOfCrypto].isFavorite = false;
    await LocalStorage.removeFavourite(crypto.id!);
    notifyListeners();

  }
}