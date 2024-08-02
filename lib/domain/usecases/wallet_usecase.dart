import '../../core/network/result.dart';
import '../entities/crypto.dart';
import '../entities/user.dart';
import '../repositories/coincap_repository.dart';
import '../repositories/mockaroo_repository.dart';

class WalletUseCase {
  final MockarooRepository _mockarooRepository;
  final CoincapRepository _coincapRepository;

  WalletUseCase(
      {required MockarooRepository mockarooRepository,
      required CoincapRepository coincapRepository})
      : _mockarooRepository = mockarooRepository,
        _coincapRepository = coincapRepository;

  Future<Result<User>> getUserDetails() {
    return _mockarooRepository.getUserDetails();
  }

  Future<Result<List<Crypto>>> getHoldings(String userId) {
    return _mockarooRepository.getHoldings(userId);
  }

  Future<Result<String>> getPrice(String symbol) {
    return _coincapRepository.getPrice(symbol);
  }
}
