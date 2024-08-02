import 'package:crypto_wallet/core/network/result.dart';
import 'package:crypto_wallet/data/datasources/remote/coincap_remote_client.dart';
import 'package:crypto_wallet/domain/repositories/coincap_repository.dart';
import 'package:dio/dio.dart';

class CoincapRepositoryImpl implements CoincapRepository {
  final CoinCapRemoteClient _coinCapRemoteClient;

  CoincapRepositoryImpl({required CoinCapRemoteClient coinCapRemoteClient})
      : _coinCapRemoteClient = coinCapRemoteClient;

  @override
  Future<Result<String>> getPrice(String symbol) async {
    try {
      final res = await _coinCapRemoteClient.getPrice(symbol);
      return Result.success(res.rateUsd);
    } on DioError catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
