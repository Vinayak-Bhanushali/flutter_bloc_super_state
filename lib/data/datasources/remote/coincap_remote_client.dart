// import 'dart:math';

import 'package:crypto_wallet/core/network/dio_service/dio_builder.dart';
import 'package:crypto_wallet/data/models/current_crypto_details.dart';

abstract class CoinCapRemoteClient {
  Future<CurrentCryptoData> getPrice(String symbol);
}

class CoinCapRemoteClientImpl implements CoinCapRemoteClient {
  final DioBuilderResponse coinCapDio;

  CoinCapRemoteClientImpl({required this.coinCapDio});

  @override
  Future<CurrentCryptoData> getPrice(String symbol) async {
    // await Future.delayed(Duration(seconds: Random().nextInt(5) + 5));

    final res = await coinCapDio.dio.get("/v2/rates/$symbol");
    return CurrentCryptoData.fromMap(res.data['data']);
  }
}
