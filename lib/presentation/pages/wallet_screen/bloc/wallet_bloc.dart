import 'package:crypto_wallet/core/network/result.dart';
import 'package:crypto_wallet/domain/entities/crypto.dart';
import 'package:crypto_wallet/domain/entities/user.dart';
import 'package:crypto_wallet/domain/usecases/wallet_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletUseCase _walletUseCase;
  WalletBloc(this._walletUseCase)
      : super(
          const WalletInitialState(
            user: Result.inital(),
            holdings: Result.inital(),
          ),
        ) {
    on<WalletEvent>((event, emit) async {
      if (event is FetchUserDataEvent) {
        await handleFetchUserDataEvent(emit);
      } else if (event is FetchHoldingsEvent) {
        await handleFetchHoldingsEvent(event.userId, emit);
      } else if (event is FetchCurrentCryptoDataEvent) {
        await handleFetchCurrentCryptoDataEvent(event.symbol, emit);
      }
    });
    add(FetchUserDataEvent());
  }

  handleFetchUserDataEvent(Emitter<WalletState> emit) async {
    emit(
      UserDataLoadingState(
        user: const Result.loading(),
        holdings: state.holdings,
      ),
    );
    final res = await _walletUseCase.getUserDetails();
    if (res is Success<User>) {
      emit(UserDataSuccessState(user: res, holdings: state.holdings));
      add(FetchHoldingsEvent(userId: res.data.userId));
    } else if (res is Fail<User>) {
      emit(UserDataFailureState(user: res, holdings: state.holdings));
    }
  }

  handleFetchHoldingsEvent(String userId, Emitter<WalletState> emit) async {
    emit(
      HoldingsLoadingState(
        user: state.user,
        holdings: const Result.loading(),
      ),
    );
    final res = await _walletUseCase.getHoldings(userId);
    if (res is Success<List<Crypto>>) {
      emit(
        HoldingsSuccessState(
          user: state.user,
          holdings: Result.success(
            {
              for (var item in res.data) item.cryptoCurrency: item,
            },
          ),
        ),
      );
    } else if (res is Fail<List<Crypto>>) {
      emit(
        HoldingsFailureState(
          user: state.user,
          holdings: Result.error(res.error),
        ),
      );
    }
  }

  handleFetchCurrentCryptoDataEvent(
      String symbol, Emitter<WalletState> emit) async {
    final holdings = state.holdings as Success<Map<String, Crypto>>;
    holdings.data[symbol]!.currentPrice = const Result.loading();

    emit(
      CurrentCryptoUpdateState(
        symbol: symbol,
        user: state.user,
        holdings: holdings,
      ),
    );

    final res = await _walletUseCase.getPrice(symbol);
    if (res is Success<String>) {
      final data = num.tryParse(res.data);
      if (data != null) {
        holdings.data[symbol]!.currentPrice = Result.success(data);
      } else {
        holdings.data[symbol]!.currentPrice =
            Result.error("Failed to convert the price for $symbol");
      }
    } else if (res is Fail<String>) {
      holdings.data[symbol]!.currentPrice = Result.error(res.error);
    }

    emit(
      CurrentCryptoUpdateState(
        symbol: symbol,
        user: state.user,
        holdings: holdings,
      ),
    );
  }
}
