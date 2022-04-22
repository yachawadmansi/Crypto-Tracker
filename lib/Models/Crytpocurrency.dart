class Cryptocurrency {
  String? id;
  String? symbol;
  String? name;
  String? image;
  double? currentprice;
  double? marketCap;
  double? high24;
  double? low24;
  double? pricechange24;
  double? pricechange24percentage;
  double? circulatingsupply;
  double? ath;
  double? atl;
  int? marketcaprank;
  bool isFavorite = false ;

  Cryptocurrency(
      {required this.id,
      required this.symbol,
      required this.name,
      required this.image,
      required this.currentprice,
      required this.marketcaprank,
      required this.marketCap,
      required this.high24,
      required this.low24,
      required this.pricechange24,
      required this.circulatingsupply,
      required this.pricechange24percentage,
      required this.ath,
      required this.atl});

  factory Cryptocurrency.fromJSON(Map<String, dynamic> map) {
    return Cryptocurrency(
        id: map['id'],
        symbol: map['symbol'],
        name: map["name"],
        image: map["image"],
        currentprice: double.parse(map["current_price"].toString()),
        marketcaprank: map["market_cap_rank"],
        marketCap: double.parse(map["market_cap"].toString()),
        high24: double.parse(map["high_24h"].toString()),
        low24: double.parse(map["low_24h"].toString()),
        pricechange24: double.parse(map["price_change_24h"].toString()),
        circulatingsupply: double.parse(map["circulating_supply"].toString()),
        pricechange24percentage: double.parse(map["price_change_percentage_24h"].toString()),
        ath: double.parse(map["ath"].toString()),
        atl: double.parse(map["atl"].toString()),
    );
  }
}
