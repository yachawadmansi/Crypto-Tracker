import 'package:cryptotracker/Models/Crytpocurrency.dart';
import 'package:cryptotracker/Providers/marketprovider.dart';
import 'package:cryptotracker/Widgets/Cryptolisttile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Markets extends StatefulWidget {
  const Markets({Key? key}) : super(key: key);

  @override
  _MarketsState createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: Consumer<Marketprovider>(
        builder: (context, marketProvider, child) {
          if (marketProvider.isloading == true) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (marketProvider.markets.length > 0) {
              return RefreshIndicator(
                onRefresh: () async{
                  await marketProvider.fetchdata();

                },
                child: ListView.builder(
                  physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  itemCount: marketProvider.markets.length,
                  itemBuilder: (context, index) {
                    Cryptocurrency currentCrypto =
                    marketProvider.markets[index];

                    return CryptoListTile(currentCrypto: currentCrypto);
                  },
                ),
              );
            } else {
              return Text("Data not found");
            }
          }
        },
      ),
    );

  }
}
