import 'package:cryptotracker/Models/Crytpocurrency.dart';
import 'package:cryptotracker/Pages/detailspage.dart';
import 'package:cryptotracker/Providers/marketprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CryptoListTile extends StatelessWidget {
  final Cryptocurrency currentCrypto;
  const CryptoListTile({Key? key, required this.currentCrypto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Marketprovider marketProvider =
        Provider.of<Marketprovider>(context, listen: false);
    return Container(
      // padding: EdgeInsetsDirectional.all(10.0),
      child: ListTile(
        minVerticalPadding: 15.0,
        // contentPadding : EdgeInsetsGeometry.lerp(),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsPage(
                id: currentCrypto.id!,
              ),
            ),
          );
        },
        contentPadding: EdgeInsets.all(5.0),
        hoverColor: Colors.grey.shade50,

        leading: CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(currentCrypto.image!),
        ),
        title: Row(
          children: [
            Flexible(
              child: Text(
                "${currentCrypto.marketcaprank} " + currentCrypto.name!,
                overflow: TextOverflow.ellipsis,
                // style: TextStyle(color: Colors.white),
              ),
            ),
            SizedBox(
              width: 10.0,
            ),
            (currentCrypto.isFavorite == false)
                ? GestureDetector(
                    onTap: () {
                      marketProvider.addFavourite(currentCrypto);
                    },
                    child: Icon(
                      CupertinoIcons.heart,
                      size: 20.0,
                      color: Colors.white,
                    ),
                  )
                : GestureDetector(
                    onTap: () {
                      marketProvider.removeFavourite(currentCrypto);
                    },
                    child: Icon(
                      CupertinoIcons.heart_fill,
                      size: 20.0,
                      color: Colors.red,
                    ),
                  )
          ],
        ),
        subtitle: Text(
          currentCrypto.symbol!.toUpperCase(),
          // style: TextStyle(color: Colors.white),
        ),
        trailing: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "₹ " + currentCrypto.currentprice!.toStringAsFixed(4),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF0395eb),
                fontSize: 18,
              ),
            ),
            Builder(builder: (context) {
              double priceChangepercentage =
                  currentCrypto.pricechange24percentage!;
              double priceChange = currentCrypto.pricechange24!;
              if (priceChange < 0) {
                return Text(
                  "${priceChangepercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                  style: TextStyle(color: Colors.red),
                );
              } else {
                return Text(
                  "+  ${priceChangepercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                  style: TextStyle(color: Colors.green),
                );
              }
            })
          ],
        ),
      ),
    );
  }
}
