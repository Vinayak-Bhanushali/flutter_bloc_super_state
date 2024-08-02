part of 'wallet_bloc.dart';

@immutable
sealed class WalletEvent {}

final class FetchUserDataEvent extends WalletEvent {}

final class FetchHoldingsEvent extends WalletEvent {
  final String userId;

  FetchHoldingsEvent({required this.userId});
}

final class FetchCurrentCryptoDataEvent extends WalletEvent {
  final String symbol;

  FetchCurrentCryptoDataEvent(this.symbol);
}
