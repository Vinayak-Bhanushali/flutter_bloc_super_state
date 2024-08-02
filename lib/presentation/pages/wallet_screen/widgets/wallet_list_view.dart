import 'package:crypto_wallet/core/network/result.dart';
import 'package:crypto_wallet/domain/entities/crypto.dart';
import 'package:crypto_wallet/domain/entities/user.dart';
import 'package:crypto_wallet/presentation/pages/wallet_screen/bloc/wallet_bloc.dart';
import 'package:crypto_wallet/presentation/pages/wallet_screen/widgets/profit_loss_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class WalletListView extends StatelessWidget {
  const WalletListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WalletBloc, WalletState>(
      buildWhen: (previous, current) {
        return (current is HoldingsLoadingState ||
            current is HoldingsFailureState ||
            current is HoldingsSuccessState);
      },
      builder: (context, state) {
        if (state is HoldingsLoadingState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Shimmer.fromColors(
                baseColor: Colors.grey[700]!,
                highlightColor: Colors.grey[500]!,
                child: const Icon(
                  Icons.currency_bitcoin,
                  size: 100,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Fetching your holdings"),
            ],
          );
        } else if (state is HoldingsFailureState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Failed to fetch your holdings"),
              const SizedBox(
                height: 20,
              ),
              const Icon(
                Icons.error_outline,
                size: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<WalletBloc>().add(
                        FetchHoldingsEvent(
                          userId: (state.user as Success<User>).data.userId,
                        ),
                      );
                },
                child: const Text("Retry"),
              )
            ],
          );
        } else if (state is HoldingsSuccessState) {
          final holdings =
              (state.holdings as Success<Map<String, Crypto>>).data;
          final keys = holdings.keys.toList();
          return ListView.builder(
            itemCount: keys.length,
            itemBuilder: (context, index) {
              final symbol = keys[index];
              final crypto = holdings[symbol]!;
              return CryptoListTile(crypto: crypto);
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}

class CryptoListTile extends StatelessWidget {
  const CryptoListTile({
    super.key,
    required this.crypto,
  });

  final Crypto crypto;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 20,
            child: Image.network(
              "https://raw.githubusercontent.com/ErikThiart/cryptocurrency-icons/master/16/${crypto.cryptoCurrency}.png",
            ),
          ),
          const SizedBox(width: 4),
          Text(crypto.cryptoCurrency.toUpperCase()),
          const SizedBox(width: 4),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: BlocBuilder<WalletBloc, WalletState>(
                buildWhen: (previous, current) =>
                    current is CurrentCryptoUpdateState &&
                    current.symbol == crypto.cryptoCurrency,
                builder: (context, state) {
                  final currentPrice = crypto.currentPrice;
                  if (crypto.currentPrice is Initial) {
                    context.read<WalletBloc>().add(
                          FetchCurrentCryptoDataEvent(crypto.cryptoCurrency),
                        );
                  }
                  if (currentPrice is Initial || currentPrice is Loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (currentPrice is Fail) {
                    return IconButton(
                      icon: const Icon(Icons.replay),
                      onPressed: () {
                        context.read<WalletBloc>().add(
                              FetchCurrentCryptoDataEvent(
                                  crypto.cryptoCurrency),
                            );
                      },
                    );
                  } else if (currentPrice is Success<num>) {
                    return ProfitLoss(
                      viewModel: ProfitLossViewModel.fromCrypto(crypto),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
