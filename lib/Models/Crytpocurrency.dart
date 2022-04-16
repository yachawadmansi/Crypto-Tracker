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
        currentprice: map["current_price"],
        marketcaprank: map["market_cap_rank"],
        marketCap: map["market_cap"],
        high24: map["high_24h"],
        low24: map["low_24h"],
        pricechange24: map["price_change_24h"],
        circulatingsupply: map["circulating_supply"],
        pricechange24percentage: map["price_change_percentage_24h"],
        ath: map["ath"],
        atl: map["atl"]);
  }
}
