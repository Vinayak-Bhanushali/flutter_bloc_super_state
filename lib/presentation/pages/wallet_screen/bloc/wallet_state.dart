part of 'wallet_bloc.dart';

@immutable
sealed class WalletState {
  final Result<User> user;
  final Result<Map<String, Crypto>> holdings;

  const WalletState({required this.user, required this.holdings});
}

final class WalletInitialState extends WalletState {
  const WalletInitialState({required super.user, required super.holdings});
}

final class UserDataLoadingState extends WalletState {
  const UserDataLoadingState({required super.user, required super.holdings});
}

final class UserDataFailureState extends WalletState {
  const UserDataFailureState({required super.user, required super.holdings});
}

final class UserDataSuccessState extends WalletState {
  const UserDataSuccessState({required super.user, required super.holdings});
}

final class HoldingsLoadingState extends WalletState {
  const HoldingsLoadingState({required super.user, required super.holdings});
}

final class HoldingsFailureState extends WalletState {
  const HoldingsFailureState({required super.user, required super.holdings});
}

final class HoldingsSuccessState extends WalletState {
  const HoldingsSuccessState({required super.user, required super.holdings});
}

final class CurrentCryptoUpdateState extends WalletState {
  final String symbol;
  const CurrentCryptoUpdateState(
      {required this.symbol, required super.user, required super.holdings});
}
