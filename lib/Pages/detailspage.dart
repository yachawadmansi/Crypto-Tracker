import 'dart:developer';

import 'package:cryptotracker/Models/Crytpocurrency.dart';
import 'package:cryptotracker/Providers/marketprovider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cryptotracker/Models/GraphPoint.dart';
import 'package:cryptotracker/Providers/Chart_provider.dart';
import "package:syncfusion_flutter_charts/charts.dart";
import 'Favourites.dart';
import 'Home_page.dart';

class DetailsPage extends StatefulWidget {
  final String id;

  const DetailsPage({Key? key, required this.id}) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  Widget titleAndDetail(
      String title, String detail, CrossAxisAlignment crossAxisAlignment) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        Text(
          detail,
          style: TextStyle(fontSize: 17),
        ),
      ],
    );
  }

  late GraphProvider graphProvider;

  int days = 1;
  List<bool> isSelected = [true, false, false, false];

  void toggleDate(int index) async {
    log("Loading....");

    for (int i = 0; i < isSelected.length; i++) {
      if (i == index) {
        isSelected[i] = true;
        log(isSelected.toString());
      } else {
        isSelected[i] = false;
        log(isSelected.toString());
      }
    }

    switch (index) {
      case 0:
        days = 1;
        break;
      case 1:
        days = 7;
        break;
      case 2:
        days = 28;
        break;
      case 3:
        days = 90;
        break;
      default:
        break;
    }

    await graphProvider.initializeGraph(widget.id, days);

    setState(() {});

    log("Graph Loaded!");
  }

  void initializeInitialGraph() async {
    log("Loading Graph...");

    await graphProvider.initializeGraph(widget.id, days);
    setState(() {});

    log("Graph Loaded!");
  }

  @override
  void initState() {
    super.initState();

    graphProvider = Provider.of<GraphProvider>(context, listen: false);
    initializeInitialGraph();
  }

  @override
  void dispose() {
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(

        appBar: AppBar(

        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: ListView(

              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: ToggleButtons(
                    borderRadius: BorderRadius.circular(10),
                    onPressed: (index) {
                      toggleDate(index);
                    },
                    children: [
                      Text("1D"),
                      Text("7D"),
                      Text("28D"),
                      Text("90D"),
                    ],
                    isSelected: isSelected,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 300,
                  child: SfCartesianChart(
                    primaryXAxis: DateTimeAxis(),
                    series: <AreaSeries>[
                      AreaSeries<GraphPoint, dynamic>(
                          color: Color(0xff1ab7c3).withOpacity(0.5),
                          borderColor: Color(0xff1ab7c3),
                          borderWidth: 2,
                          dataSource: graphProvider.graphPoints,
                          xValueMapper: (GraphPoint graphPoint, index) =>
                          graphPoint.date,
                          yValueMapper: (GraphPoint graphpoint, index) =>
                          graphpoint.price),
                    ],
                  ),
                ),
                Consumer<Marketprovider>(
                  builder: (context, marketProvider, child) {
                    Cryptocurrency currentCrypto =
                    marketProvider.fetchCryptoById(widget.id);

                    return ListView(


                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        ListTile(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                          contentPadding: EdgeInsets.all(10),
                          tileColor: Color.fromARGB(19, 92, 92, 92),


                          leading: (
                              ClipOval(
                                child: Image.network(currentCrypto.image!),


                              )
                          ),
                          title: Text(
                            currentCrypto.name! +
                                " (${currentCrypto.symbol!.toUpperCase()})",
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          subtitle: Text(
                            "₹ " +
                                currentCrypto.currentprice!.toStringAsFixed(4),
                            style: TextStyle(
                                color: Color(0xff0395eb),
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Price Change (24h)",
                              style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20 ,),
                            ),
                            Builder(
                              builder: (context) {
                                double priceChange =
                                currentCrypto.pricechange24!;
                                double priceChangePercentage =
                                currentCrypto.pricechange24percentage!;

                                if (priceChange < 0) {
                                  // negative
                                  return Text(
                                    "${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 23),
                                  );
                                } else {
                                  // positive
                                  return Text(
                                    "+${priceChangePercentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(4)})",
                                    style: TextStyle(
                                        color: Colors.green, fontSize: 23),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            titleAndDetail(
                                "Market Cap",
                                "₹ " +
                                    currentCrypto.marketCap!.toStringAsFixed(4),
                                CrossAxisAlignment.start),
                            titleAndDetail(
                                "Market Cap Rank",
                                "#" + currentCrypto.marketcaprank.toString(),
                                CrossAxisAlignment.end),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            titleAndDetail(
                                "Low 24h",
                                "₹ " + currentCrypto.low24!.toStringAsFixed(4),
                                CrossAxisAlignment.start),
                            titleAndDetail(
                                "High 24h",
                                "₹ " + currentCrypto.high24!.toStringAsFixed(4),
                                CrossAxisAlignment.end),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            titleAndDetail(
                                "Circulating Supply",
                                currentCrypto.circulatingsupply!
                                    .toInt()
                                    .toString(),
                                CrossAxisAlignment.start),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            titleAndDetail(
                                "All Time Low",
                                currentCrypto.atl!.toStringAsFixed(4),
                                CrossAxisAlignment.start),
                            titleAndDetail(
                                "All Time High",
                                currentCrypto.ath!.toStringAsFixed(4),
                                CrossAxisAlignment.start),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class DetailsPage extends StatefulWidget {
//   final String id;
//
//   const DetailsPage({Key? key, required this.id}) : super(key: key);
//
//   @override
//   _DetailsPageState createState() => _DetailsPageState();
// }
//
// class _DetailsPageState extends State<DetailsPage> {
//   Widget titleAndDetail(String title, String detail, crossAxisAlignment) {
//     return Column(
//       crossAxisAlignment: crossAxisAlignment,
//       children: [
//         Text(
//           title,
//           style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//         ),
//         Text(
//           detail,
//           style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//         )
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.white,
//         iconTheme: IconThemeData(
//           color: Colors.black,
//         ),
//       ),
//       body: SafeArea(
//         child: Container(
//           padding: EdgeInsets.only(
//             left: 20,
//             right: 20,
//           ),
//           child: Consumer<Marketprovider>(
//               builder: (context, marketProvider, child) {
//             Cryptocurrency currentcrypto =
//                 marketProvider.fetchCryptoById(widget.id);
//             return RefreshIndicator(
//               onRefresh: () async {
//                 await marketProvider.fetchdata();
//               },
//               child: ListView(
//                 physics: BouncingScrollPhysics(
//                     parent: AlwaysScrollableScrollPhysics()),
//                 children: [
//                   ListTile(
//                     contentPadding: EdgeInsets.all(0),
//                     leading: CircleAvatar(
//                       backgroundColor: Colors.white,
//                       backgroundImage: NetworkImage(currentcrypto.image!),
//                     ),
//                     title: Text(
//                       currentcrypto.name! +
//                           " ${currentcrypto.symbol!.toUpperCase()}",
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     subtitle: Text(
//                       "	₹ " + currentcrypto.currentprice!.toStringAsFixed(5),
//                       style: TextStyle(
//                         color: Color(0xff0395eb),
//                         fontSize: 25,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Price Change (24hr)",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 20),
//                       ),
//                       Builder(
//                         builder: (context) {
//                           double priceChangepercentage =
//                               currentcrypto.pricechange24percentage!;
//                           double priceChange = currentcrypto.pricechange24!;
//                           if (priceChange < 0) {
//                             return Text(
//                               "${priceChangepercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
//                               style: TextStyle(color: Colors.red, fontSize: 20),
//                             );
//                           } else {
//                             return Text(
//                               "+  ${priceChangepercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
//                               style:
//                                   TextStyle(color: Colors.green, fontSize: 20),
//                             );
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 30.0),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       titleAndDetail(
//                           "Market Cap Rank ",
//                           currentcrypto.marketcaprank!.toStringAsFixed(0),
//                           CrossAxisAlignment.start),
//                     ],
//                   ),
//                   SizedBox(height: 10.0,),
//                   SafeArea(
//                     child: Expanded(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           titleAndDetail(
//                               "Market Cap",
//                               " ₹ " + currentcrypto.marketCap!.toStringAsFixed(2),
//                               CrossAxisAlignment.start),
//                         ],
//                       ),
//                     ),
//                   ),
//                   SizedBox(height: 15.0),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       titleAndDetail(
//                           "Low 24h",
//                           " ₹ " + currentcrypto.low24!.toStringAsFixed(3),
//                           CrossAxisAlignment.start),
//                       titleAndDetail(
//                           "High 24h",
//                           " ₹ " + currentcrypto.high24!.toStringAsFixed(2),
//                           CrossAxisAlignment.end),
//                     ],
//                   ),
//                   SizedBox(height: 20.0),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       titleAndDetail(
//                           "Circulating supply",
//                           currentcrypto.circulatingsupply!.toInt().toString(),
//                           CrossAxisAlignment.start),
//                       titleAndDetail("", " ₹ " + currentcrypto.high24!.toStringAsFixed(2) , CrossAxisAlignment.end),
//                     ],
//                   ),
//                   SizedBox(height: 20.0),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       titleAndDetail(
//                           "All Time low ",
//                           currentcrypto.atl!.toInt().toString(),
//                           CrossAxisAlignment.start),
//                       titleAndDetail(
//                           "All Time high",
//                           currentcrypto.ath!.toInt().toString(),
//                           CrossAxisAlignment.end),
//                     ],
//                   ),
//                   SizedBox(
//                     height: 100.0,
//                   ),
//                   (currentcrypto.isFavorite == false)
//                       ? GestureDetector(
//                           onTap: () {
//                             marketProvider.addFavourite(currentcrypto);
//                           },
//                           child: Container(
//                               padding: EdgeInsetsDirectional.only(
//                                   start: 75.0, top: 10.0, bottom: 10.0),
//                               width: double.infinity,
//                               height: 40.0,
//                               color: Colors.teal,
//                               child: Text(
//                                 "Add To Favourite",
//                                 style: TextStyle(
//                                     fontSize: 22.0,
//                                     color: Colors.green.shade500,
//                                     fontWeight: FontWeight.bold),
//                               )),
//                         )
//                       : GestureDetector(
//                           onTap: () {
//                             marketProvider.removeFavourite(currentcrypto);
//                           },
//                     child: Container(
//                         padding: EdgeInsetsDirectional.only(
//                             start: 75.0, top: 10.0, bottom: 10.0),
//                         width: double.infinity,
//                         height: 40.0,
//                         color: Colors.teal,
//                         child: Text(
//                           "Remove From  Favourite",
//                           style: TextStyle(
//                               fontSize: 22.0,
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold),
//                         )),
//                         ),
//                   SizedBox(
//                     height: 10.0,
//                   ),
//                   BottomAppBar(
//                     color: Colors.black,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => Homepage()),
//                             );
//                           },
//                           icon: Icon(
//                             Icons.home,
//                             color: Colors.white,
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                   builder: (context) => Favourites()),
//                             );
//                           },
//                           icon: Icon(
//                             CupertinoIcons.heart_fill,
//                             color: Colors.white,
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             // Navigator.push(context, MaterialPageRoute(builder: (context) => Setting_page()),);
//                           },
//                           icon: Icon(
//                             CupertinoIcons.news_solid,
//                             color: Colors.white,
//                           ),
//                         ),
//                         IconButton(
//                           onPressed: () {
//                             // Navigator.push(context, MaterialPageRoute(builder: (context) => News_page()),);
//                           },
//                           icon: Icon(
//                             CupertinoIcons.settings_solid,
//                             color: Colors.white,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }),
//         ),
//       ),
//     );
//   }
// }
