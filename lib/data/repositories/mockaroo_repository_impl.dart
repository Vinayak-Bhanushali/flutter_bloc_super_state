import 'package:crypto_wallet/core/network/result.dart';

import 'package:crypto_wallet/domain/entities/crypto.dart';

import 'package:crypto_wallet/domain/entities/user.dart';
import 'package:dio/dio.dart';

import '../../domain/repositories/mockaroo_repository.dart';
import '../datasources/remote/mockaroo_remote_client.dart';

class MockarooRepositoryImpl implements MockarooRepository {
  final MockarooRemoteClient _mockarooRemoteClient;

  MockarooRepositoryImpl({required MockarooRemoteClient mockarooRemoteClient})
      : _mockarooRemoteClient = mockarooRemoteClient;

  @override
  Future<Result<User>> getUserDetails() async {
    try {
      final res = await _mockarooRemoteClient.getUserDetails();
      return Result.success(
        User(
          userId: res.userId,
          firstName: res.firstName,
          lastName: res.lastName,
          email: res.email,
          avatar: res.avatar,
        ),
      );
    } on DioError catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(e.toString());
    }
  }

  @override
  Future<Result<List<Crypto>>> getHoldings(String userId) async {
    try {
      final res = await _mockarooRemoteClient.getHoldings(userId);
      return Result.success(List<Crypto>.from(
        res.holdings.map(
          (e) => Crypto(
            cryptoCurrency: e.cryptoCurrency,
            totalQuantity: e.totalQuantity,
            purchasePriceUsd: e.purchasePriceUsd,
          ),
        ),
      ));
    } on DioError catch (e) {
      return Result.error(e.message);
    } catch (e) {
      return Result.error(e.toString());
    }
  }
}
