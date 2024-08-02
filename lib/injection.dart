import 'package:crypto_wallet/core/network/dio_service/dio_builder.dart';
import 'package:crypto_wallet/core/network/endpoints.dart';
import 'package:crypto_wallet/data/datasources/remote/coincap_remote_client.dart';
import 'package:crypto_wallet/data/datasources/remote/mockaroo_remote_client.dart';
import 'package:crypto_wallet/data/repositories/coincap_repository_impl.dart';
import 'package:crypto_wallet/data/repositories/mockaroo_repository_impl.dart';
import 'package:crypto_wallet/domain/repositories/coincap_repository.dart';
import 'package:crypto_wallet/domain/repositories/mockaroo_repository.dart';
import 'package:crypto_wallet/domain/usecases/wallet_usecase.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void init() {
  registerDataSources();
  registerRepositories();
  registerUseCases();
}

void registerDataSources() {
  locator.registerLazySingleton<MockarooRemoteClient>(
    () => MockarooRemoteClientImpl(
      mockarooDio: DioBuilder().buildNonCachedDio(
        baseUrl: mockArooBaseUrl,
        apiKey: '8ff386d0',
      ),
    ),
  );
  locator.registerLazySingleton<CoinCapRemoteClient>(
    () => CoinCapRemoteClientImpl(
      coinCapDio: DioBuilder().buildNonCachedDio(
        baseUrl: coinCapBaseUrl,
      ),
    ),
  );
}

void registerRepositories() {
  locator.registerLazySingleton<MockarooRepository>(
    () => MockarooRepositoryImpl(
      mockarooRemoteClient: locator(),
    ),
  );
  locator.registerLazySingleton<CoincapRepository>(
    () => CoincapRepositoryImpl(
      coinCapRemoteClient: locator(),
    ),
  );
}

void registerUseCases() {
  locator.registerLazySingleton(
    () => WalletUseCase(
      mockarooRepository: locator(),
      coincapRepository: locator(),
    ),
  );
}
