import 'dart:convert';

class CoinGeckoResponse {
  final int current_price;
  final int high_24h;
  final int low_24h;

  const CoinGeckoResponse({
    required this.current_price,
    required this.high_24h,
    required this.low_24h,
  });

  factory CoinGeckoResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'current_price': int current_price,
        'high_24h': int high_24h,
        'low_24h': int low_24h,
      } =>
        CoinGeckoResponse(
          current_price: current_price,
          high_24h: high_24h,
          low_24h: low_24h,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
  factory CoinGeckoResponse.fromJson2(Map<String, dynamic> json) => CoinGeckoResponse(
    current_price: json["current_price"],
    high_24h: json["high_24h"],
    low_24h: json["low_24h"],
  );
  Map<String, dynamic> toJson() => {
    "current_price": current_price,
    "high_24h": high_24h,
    "low_24h": low_24h,
  };

  List<CoinGeckoResponse> userFromJson(String str) => List<CoinGeckoResponse>.from(json.decode(str).map((x) => CoinGeckoResponse.fromJson(x)));
  String userToJson(List<CoinGeckoResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
}
