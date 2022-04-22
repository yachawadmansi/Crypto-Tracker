import 'package:cryptotracker/Models/Crytpocurrency.dart';
import 'package:cryptotracker/Providers/marketprovider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Home_page.dart';

class DetailsPage extends StatefulWidget {
  final String id;

  const DetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Widget titleAndDetail(String title, String detail, crossAxisAlignment) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        Text(
          detail,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Consumer<Marketprovider>(
              builder: (context, marketProvider, child) {
            Cryptocurrency currentcrypto =
                marketProvider.fetchCryptoById(widget.id);
            return RefreshIndicator(
              onRefresh: () async{
                await marketProvider.fetchdata();
              },
              child: ListView(
                physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.all(0),
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(currentcrypto.image!),
                    ),
                    title: Text(
                      currentcrypto.name! +
                          " ${currentcrypto.symbol!.toUpperCase()}",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      "	₹ " + currentcrypto.currentprice!.toStringAsFixed(5),
                      style: TextStyle(
                        color: Color(0xff0395eb),
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Price Change (24hr)",
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Builder(builder: (context ){
                        double priceChangepercentage =
                        currentcrypto.pricechange24percentage!;
                        double priceChange =
                        currentcrypto.pricechange24!;
                        if (priceChange < 0) {
                          return Text(
                            "${priceChangepercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                            style: TextStyle(color: Colors.red , fontSize: 20),
                          );
                        } else {
                          return Text(
                            "+  ${priceChangepercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                            style: TextStyle(color: Colors.green , fontSize: 20),
                          );
                        }

                      },
                      ),
                    ],
                  ),
                  SizedBox(height: 30.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetail(
                          "Market Cap",
                          " ₹ " + currentcrypto.marketCap!.toStringAsFixed(3),
                          CrossAxisAlignment.start),
                      titleAndDetail(
                          "Market Cap Rank ",
                          currentcrypto.marketcaprank!.toStringAsFixed(2),
                          CrossAxisAlignment.end),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetail(
                          "Low 24h",
                          " ₹ " + currentcrypto.low24!.toStringAsFixed(3),
                          CrossAxisAlignment.start),
                      titleAndDetail(
                          "High 24h",
                          " ₹ " + currentcrypto.high24!.toStringAsFixed(2),
                          CrossAxisAlignment.end),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetail(
                          "Circulating supply",
                          currentcrypto.circulatingsupply!.toInt().toString(),
                          CrossAxisAlignment.start),
                      // titleAndDetail("", " ₹ " + currentcrypto.high24!.toStringAsFixed(2) , CrossAxisAlignment.end),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetail(
                          "All Time low ",
                          currentcrypto.atl!.toInt().toString(),
                          CrossAxisAlignment.start),
                      titleAndDetail(
                          "All Time high",
                          currentcrypto.ath!.toInt().toString(),
                          CrossAxisAlignment.end),
                    ],
                  ),
                ],
              ),
            );
          }),
          // child: ListView(
          //   children: [
          //
          //   ],
          // ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          color: Colors.blueAccent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()),);
                },
                icon: Icon(Icons.home),
              ),
              IconButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritePage()),);
                },
                icon: Icon(Icons.wallet_membership),
              ),
              IconButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => Setting_page()),);
                },
                icon: Icon(Icons.settings),
              ),
              IconButton(
                onPressed: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => News_page()),);
                },
                icon: Icon(Icons.contact_page),
              ),
              // Icon(Icons.home),
              // Icon(Icons.settings),
            ],
          )),
    );
  }
}
