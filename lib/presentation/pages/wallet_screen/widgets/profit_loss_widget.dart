import 'package:crypto_wallet/core/network/result.dart';
import 'package:crypto_wallet/core/utils/extensions/currency_extension.dart';
import 'package:crypto_wallet/domain/entities/crypto.dart';
import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class ProfitLossViewModel {
  final String cryptoCurrency;
  final num totalQuantity;
  final num purchasePriceUsd;
  final num currentPrice;

  ProfitLossViewModel({
    required this.cryptoCurrency,
    required this.totalQuantity,
    required this.purchasePriceUsd,
    required this.currentPrice,
  });

  factory ProfitLossViewModel.fromCrypto(Crypto crypto) => ProfitLossViewModel(
        cryptoCurrency: crypto.cryptoCurrency,
        totalQuantity: crypto.totalQuantity,
        purchasePriceUsd: crypto.purchasePriceUsd,
        currentPrice: (crypto.currentPrice as Success<num>).data,
      );

  num get currentValue => totalQuantity * currentPrice;
  String get currentValueFormatted => currentValue.dollarFormat();

  num get totalInvested => purchasePriceUsd * totalQuantity;
  String get totalInvestedFormatted => totalInvested.dollarFormat();

  num get percentageChange =>
      ((currentValue - totalInvested) * 100) / totalInvested;
  String get percentageChangeFormatted {
    return "${percentageChange.toStringAsFixed(2)}%";
  }

  Color formattingColor() {
    if (percentageChange > 0) return Colors.green;
    if (percentageChange < 0) {
      return Colors.red;
    } else {
      return Colors.black;
    }
  }
}

class ProfitLoss extends StatelessWidget {
  final ProfitLossViewModel viewModel;
  const ProfitLoss({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final color = viewModel.formattingColor();
    final textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          viewModel.currentValueFormatted,
          style:
              Theme.of(context).textTheme.titleMedium?.copyWith(color: color),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "Invested: ${viewModel.totalInvestedFormatted}",
              style: textTheme.bodySmall,
            ),
            const SizedBox(width: 4),
            Text(
              viewModel.percentageChangeFormatted,
              style: textTheme.titleSmall?.copyWith(color: color),
            )
          ],
        )
      ],
    );
  }
}

@widgetbook.UseCase(
  name: 'ProfiLossWidgetUserCae',
  type: Container,
)
Widget profiLossWIdgetUserCase(BuildContext context) {
  return ProfitLoss(
    viewModel: ProfitLossViewModel(
      cryptoCurrency: context.knobs.string(
        label: "cryptoCurrency",
        initialValue: 'cryptoCurrency',
      ),
      totalQuantity: context.knobs.double.slider(
        label: "totalQuantity",
        initialValue: 10,
      ),
      purchasePriceUsd: context.knobs.double.input(
        label: "purchasePriceUsd",
        initialValue: 0,
      ),
      currentPrice: context.knobs.double.input(
        label: "currentPrice",
        initialValue: 0,
      ),
    ),
  );
}
