import 'package:cryptotracker/Models/Crytpocurrency.dart';
import 'package:cryptotracker/Providers/marketprovider.dart';
import 'package:cryptotracker/Widgets/Cryptolisttile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Consumer<Marketprovider>(
            builder: (context , marketProvider , child){
              List<Cryptocurrency> favourites = marketProvider.markets.where((element) => element.isFavorite == true).toList();
              if(favourites.length > 0){
                return ListView.builder(
                  itemCount: favourites.length,
                  itemBuilder: (context , index){
                    Cryptocurrency currentCrypto = favourites[index];
                    return CryptoListTile(currentCrypto: currentCrypto);

                  },);
              }
              else{
                return Center(
                  child: Text("No Favourites yet !!!", style: TextStyle(color: Colors.grey , fontSize: 20.0 ,  ), ),
                );
              }

            }
          ),
        ),
      ),
    );
  }
}
