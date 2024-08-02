// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class CryptoHolding {
  List<CryptoModel> holdings;
  CryptoHolding({
    required this.holdings,
  });

  CryptoHolding copyWith({
    List<CryptoModel>? holdings,
  }) {
    return CryptoHolding(
      holdings: holdings ?? this.holdings,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'holdings': holdings.map((x) => x.toMap()).toList(),
    };
  }

  factory CryptoHolding.fromList(List list) {
    return CryptoHolding(
      holdings: List<CryptoModel>.from(
        (list).map<CryptoModel>(
          (x) => CryptoModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  factory CryptoHolding.fromMap(Map<String, dynamic> map) {
    return CryptoHolding(
      holdings: List<CryptoModel>.from(
        (map['holdings'] as List<int>).map<CryptoModel>(
          (x) => CryptoModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CryptoHolding.fromJson(String source) =>
      CryptoHolding.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'CryptoHolding(holdings: $holdings)';

  @override
  bool operator ==(covariant CryptoHolding other) {
    if (identical(this, other)) return true;

    return listEquals(other.holdings, holdings);
  }

  @override
  int get hashCode => holdings.hashCode;
}

class CryptoModel {
  String cryptoCurrency;
  double totalQuantity;
  double purchasePriceUsd;

  CryptoModel({
    required this.cryptoCurrency,
    required this.totalQuantity,
    required this.purchasePriceUsd,
  });

  CryptoModel copyWith({
    String? cryptoCurrency,
    double? totalQuantity,
    double? purchasePriceUsd,
  }) {
    return CryptoModel(
      cryptoCurrency: cryptoCurrency ?? this.cryptoCurrency,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      purchasePriceUsd: purchasePriceUsd ?? this.purchasePriceUsd,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cryptoCurrency': cryptoCurrency,
      'totalQuantity': totalQuantity,
      'purchasePriceUsd': purchasePriceUsd,
    };
  }

  factory CryptoModel.fromMap(Map<String, dynamic> map) {
    return CryptoModel(
      cryptoCurrency: map['crypto_currency'] as String,
      totalQuantity: map['total_quantity'] as double,
      purchasePriceUsd: map['purchase_price_usd'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory CryptoModel.fromJson(String source) =>
      CryptoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'CryptoModel(cryptoCurrency: $cryptoCurrency, totalQuantity: $totalQuantity, purchasePriceUsd: $purchasePriceUsd)';

  @override
  bool operator ==(covariant CryptoModel other) {
    if (identical(this, other)) return true;

    return other.cryptoCurrency == cryptoCurrency &&
        other.totalQuantity == totalQuantity &&
        other.purchasePriceUsd == purchasePriceUsd;
  }

  @override
  int get hashCode =>
      cryptoCurrency.hashCode ^
      totalQuantity.hashCode ^
      purchasePriceUsd.hashCode;
}
