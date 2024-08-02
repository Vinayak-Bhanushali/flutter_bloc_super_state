// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CurrentCryptoData {
  String? id;
  String? symbol;
  String? currencySymbol;
  String? type;
  String rateUsd;

  CurrentCryptoData({
    required this.id,
    required this.symbol,
    required this.currencySymbol,
    required this.type,
    required this.rateUsd,
  });

  CurrentCryptoData copyWith({
    String? id,
    String? symbol,
    String? currencySymbol,
    String? type,
    String? rateUsd,
  }) {
    return CurrentCryptoData(
      id: id ?? this.id,
      symbol: symbol ?? this.symbol,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      type: type ?? this.type,
      rateUsd: rateUsd ?? this.rateUsd,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'symbol': symbol,
      'currencySymbol': currencySymbol,
      'type': type,
      'rateUsd': rateUsd,
    };
  }

  factory CurrentCryptoData.fromMap(Map<String, dynamic> map) {
    return CurrentCryptoData(
      id: map['id'] as String?,
      symbol: map['symbol'] as String?,
      currencySymbol: map['currency_symbol'] as String?,
      type: map['type'] as String?,
      rateUsd: map['rateUsd'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CurrentCryptoData.fromJson(String source) =>
      CurrentCryptoData.fromMap(
        (json.decode(source) as Map<String, dynamic>)['data'],
      );

  @override
  String toString() {
    return 'CurrentCryptoData(id: $id, symbol: $symbol, currencySymbol: $currencySymbol, type: $type, rateUsd: $rateUsd)';
  }

  @override
  bool operator ==(covariant CurrentCryptoData other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.symbol == symbol &&
        other.currencySymbol == currencySymbol &&
        other.type == type &&
        other.rateUsd == rateUsd;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        symbol.hashCode ^
        currencySymbol.hashCode ^
        type.hashCode ^
        rateUsd.hashCode;
  }
}
