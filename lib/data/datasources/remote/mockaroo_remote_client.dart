import 'package:crypto_wallet/core/network/dio_service/dio_builder.dart';
import 'package:crypto_wallet/data/models/crypto_holdings.dart';
import 'package:crypto_wallet/data/models/user_model.dart';

abstract class MockarooRemoteClient {
  Future<UserModel> getUserDetails();
  Future<CryptoHolding> getHoldings(String userId);
}

class MockarooRemoteClientImpl implements MockarooRemoteClient {
  final DioBuilderResponse mockarooDio;

  MockarooRemoteClientImpl({required this.mockarooDio});

  @override
  Future<UserModel> getUserDetails() async {
    // await Future.delayed(Duration(seconds: 6));
    final res = await mockarooDio.dio.get("/user-info");
    return UserModel.fromMap(res.data);
  }

  @override
  Future<CryptoHolding> getHoldings(String userId) async {
    // await Future.delayed(Duration(seconds: 10));

    final res = await mockarooDio.dio.get("/holdings/$userId");
    return CryptoHolding.fromList(res.data);
  }
}
