import 'package:crypto_wallet/core/network/result.dart';

import '../entities/crypto.dart';
import '../entities/user.dart';

abstract class MockarooRepository {
  Future<Result<User>> getUserDetails();
  Future<Result<List<Crypto>>> getHoldings(String userId);
}
