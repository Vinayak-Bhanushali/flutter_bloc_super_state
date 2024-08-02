import 'package:crypto_wallet/core/network/result.dart';

class Crypto {
  final String cryptoCurrency;
  final double totalQuantity;
  final double purchasePriceUsd;
  Result<num> currentPrice;

  Crypto({
    required this.cryptoCurrency,
    required this.totalQuantity,
    required this.purchasePriceUsd,
    this.currentPrice = const Result.inital(),
  });
}
