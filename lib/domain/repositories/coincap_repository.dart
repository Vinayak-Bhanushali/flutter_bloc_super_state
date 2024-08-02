import 'package:crypto_wallet/core/network/result.dart';

abstract class CoincapRepository {
  Future<Result<String>> getPrice(String symbol);
}
