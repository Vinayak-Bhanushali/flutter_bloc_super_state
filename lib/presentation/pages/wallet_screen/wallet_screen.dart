import 'package:crypto_wallet/injection.dart';
import 'package:crypto_wallet/presentation/pages/wallet_screen/bloc/wallet_bloc.dart';
import 'package:crypto_wallet/presentation/pages/wallet_screen/widgets/user_app_bar.dart';
import 'package:crypto_wallet/presentation/pages/wallet_screen/widgets/wallet_list_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WalletBloc(locator()),
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(78),
          child: SafeArea(child: UserAppBar()),
        ),
        body: Center(
          child: BlocBuilder<WalletBloc, WalletState>(
            buildWhen: (previous, current) {
              return current is UserDataLoadingState ||
                  current is UserDataFailureState ||
                  current is UserDataSuccessState;
            },
            builder: (context, state) {
              if (state is UserDataLoadingState) {
                return const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(
                      height: 40,
                    ),
                    Text("Fetching user details"),
                  ],
                );
              }
              if (state is UserDataFailureState) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 100,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.read<WalletBloc>().add(FetchUserDataEvent());
                      },
                      child: const Text("Retry"),
                    )
                  ],
                );
              }
              if (state is UserDataSuccessState) {
                return const WalletListView();
              }
              return const Placeholder();
            },
          ),
        ),
      ),
    );
  }
}
