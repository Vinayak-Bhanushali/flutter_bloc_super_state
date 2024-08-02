import 'package:crypto_wallet/injection.dart';
import 'package:crypto_wallet/presentation/pages/wallet_screen/wallet_screen.dart';
import 'package:flutter/material.dart';

void main() {
  init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WalletScreen(),
    );
  }
}
