import 'package:decimal/decimal.dart';
import 'package:matex_dart/matex_dart.dart';

class MatexDividendReinvestmentCalculatorCore extends MatexBaseCalculator<
        MatexDividendReinvestmentCalculatorCore,
        MatexDividendReinvestmentResult>
    with
        MatexDividendReinvestmentCoreMixin<
            MatexDividendReinvestmentCalculatorCore,
            MatexDividendReinvestmentResult> {
  MatexDividendReinvestmentCalculatorCore({
    MatexBaseCoreState? defaultState,
    List<MatexStateValidator>? validators,
  }) : super(
          defaultState: defaultState,
          validators: validators ?? dividendReinvestmentValidators,
        );

  @override
  MatexBaseCoreState get defaultCalculatorState =>
      kDefaultDividendReinvestmentState;

  Decimal get dTaxRate {
    return toPercentageDecimal(state.taxRate ?? 0);
  }

  Decimal get dDividendYield {
    return toPercentageDecimal(state.dividendYield!);
  }

  Decimal get dDividendPaymentFrequency {
    return toDecimal(_getDividendPaymentFrequency(
      state.dividendPaymentFrequency!,
    ));
  }

  Decimal get dAnnualDividendIncrease {
    return toPercentageDecimal(state.annualDividendIncrease ?? 0);
  }

  Decimal get dAnnualSharePriceIncrease {
    return toPercentageDecimal(state.annualSharePriceIncrease ?? 0);
  }

  @override
  // ignore: code-metrics
  MatexDividendReinvestmentResult value() {
    if (result != null) {
      return result!;
    }

    if (isValid) {
      final reports = <MatexDividendReinvestementYearlyPayoutReport>[];
      MatexDividendReinvestementYearlyPayoutReport? lastReport;
      var dividendAmountPerShare =
          toDecimal(state.sharePrice!) * dDividendYield;

      for (var i = 0; i < state.yearsToGrow!; i++) {
        if (lastReport != null) {
          dividendAmountPerShare =
              toDecimal(lastReport.dividendAmountPerShare) *
                  (Decimal.one + dAnnualDividendIncrease);
        }

        lastReport = _makeYearlyReport(lastReport, dividendAmountPerShare);
        reports.add(lastReport);
      }

      return MatexDividendReinvestmentResult(
        cumulativeGrossAmount: lastReport!.cumulativeGrossAmount,
        cumulativeNetAmount: lastReport.cumulativeNetAmount,
        numberOfShares: lastReport.numberOfShares,
        endingBalance: lastReport.endingBalance,
        yearlyReports: reports,
      );
    }

    return const MatexDividendReinvestmentResult();
  }

  MatexDividendReinvestementYearlyPayoutReport _makeYearlyReport(
    MatexDividendReinvestementYearlyPayoutReport? lastReport,
    Decimal dDividendAmountPerShare,
  ) {
    final dAnnualContribution = toDecimal(state.annualContribution ?? 0);
    var dividendAmount = dDividendAmountPerShare / dDividendPaymentFrequency;
    var payoutReports = <MatexDividendReinvestementPayoutReport>[];
    var drip = state.drip!;

    var dCumulativeShares = toDecimal(
      lastReport?.numberOfShares ?? state.numberOfShares!,
    );
    var dSharePrice = toDecimal(lastReport?.sharePrice ?? state.sharePrice!);
    var dCumulativeGrossAmount = toDecimal(
      lastReport?.cumulativeGrossAmount ?? 0,
    );
    var dCumulativeNetAmount = toDecimal(lastReport?.cumulativeNetAmount ?? 0);
    var dEndingBalance = _computeEndingBalance(
      lastReport,
      dSharePrice,
      dCumulativeShares,
    );
    var dCurrentSharePrice = dSharePrice;

    var dSharePriceIncreaseAmount = Decimal.zero;

    if (dAnnualSharePriceIncrease > Decimal.zero) {
      dSharePriceIncreaseAmount =
          dSharePrice * (dAnnualSharePriceIncrease / dDividendPaymentFrequency);
    }

    for (var i = 0; i < dDividendPaymentFrequency.toInt(); i++) {
      final dividendPayout = _computeDividendPayout(
        MatexDividendReinvestementRecord(
          numberOfshares: dCumulativeShares.toDouble(),
          dividendAmount: dividendAmount.toDouble(),
        ),
      );

      final dNetDividendPayout = toDecimal(dividendPayout.netDividendPayout);
      final dGrossDividendPayout = toDecimal(
        dividendPayout.grossDividendPayout,
      );

      var dAdditionalShareFromAnnualContribution = Decimal.zero;
      var dAdditionalSharesFromDrip = Decimal.zero;

      dCurrentSharePrice += dSharePriceIncreaseAmount;
      dEndingBalance += dCumulativeShares * dSharePriceIncreaseAmount;

      if (drip) {
        dAdditionalSharesFromDrip = _computeAdditionalShare(
          dNetDividendPayout,
          dCurrentSharePrice,
        );

        dCumulativeShares += dAdditionalSharesFromDrip;
        dEndingBalance += dAdditionalSharesFromDrip * dCurrentSharePrice;
      } else {
        dEndingBalance += dNetDividendPayout;
      }

      dCumulativeGrossAmount += dGrossDividendPayout;
      dCumulativeNetAmount += dNetDividendPayout;

      if (dAnnualContribution > Decimal.zero &&
          i + 1 == dDividendPaymentFrequency.toInt()) {
        dAdditionalShareFromAnnualContribution = _computeAdditionalShare(
          dAnnualContribution,
          dCurrentSharePrice,
        );

        dCumulativeShares += dAdditionalShareFromAnnualContribution;
        dEndingBalance +=
            dAdditionalShareFromAnnualContribution * dCurrentSharePrice;
      }

      payoutReports.add(
        MatexDividendReinvestementPayoutReport(
          additionalSharesFromAnnualContribution:
              dAdditionalShareFromAnnualContribution.toDouble(),
          sharePrice: dCurrentSharePrice.toDouble(),
          grossDividendPayout: dividendPayout.grossDividendPayout,
          netDividendPayout: dividendPayout.netDividendPayout,
          cumulativeGrossAmount: dCumulativeGrossAmount.toDouble(),
          cumulativeNetAmount: dCumulativeNetAmount.toDouble(),
          additionalSharesFromDrip: dAdditionalSharesFromDrip.toDouble(),
          endingBalance: dEndingBalance.toDouble(),
          numberOfShares: dCumulativeShares.toDouble(),
        ),
      );
    }

    return MatexDividendReinvestementYearlyPayoutReport(
      dividendAmountPerShare: dDividendAmountPerShare.toDouble(),
      cumulativeGrossAmount: dCumulativeGrossAmount.toDouble(),
      cumulativeNetAmount: dCumulativeNetAmount.toDouble(),
      numberOfShares: dCumulativeShares.toDouble(),
      sharePrice: dCurrentSharePrice.toDouble(),
      endingBalance: dEndingBalance.toDouble(),
      payouts: payoutReports,
    );
  }

  Decimal _computeEndingBalance(
    MatexDividendReinvestementYearlyPayoutReport? lastReport,
    Decimal sharePrice,
    Decimal shares,
  ) {
    if (lastReport != null) {
      return toDecimal(lastReport.endingBalance);
    }

    return sharePrice * shares;
  }

  MatexDividendReinvestementPayout _computeDividendPayout(
    MatexDividendReinvestementRecord record,
  ) {
    final dDividendAmount = toDecimal(record.dividendAmount);
    final dShares = toDecimal(record.numberOfshares);
    final dGrossAmount = dShares * dDividendAmount;
    final netAmount = dGrossAmount * (Decimal.one - dTaxRate);

    return MatexDividendReinvestementPayout(
      grossDividendPayout: dGrossAmount.toDouble(),
      netDividendPayout: netAmount.toDouble(),
    );
  }

  Decimal _computeAdditionalShare(Decimal amount, Decimal sharePrice) {
    return amount / sharePrice;
  }

  int _getDividendPaymentFrequency(MatexFrequency frequency) {
    if (frequency == MatexFrequency.semiAnnually) {
      return 2;
    } else if (frequency == MatexFrequency.quarterly) {
      return 4;
    } else if (frequency == MatexFrequency.monthly) {
      return 12;
    }

    return 1;
  }
}

MatexDividendReinvestmentCalculatorCore dividendReinvestment({
  MatexBaseCoreState? defaultState,
  List<MatexStateValidator>? validators,
}) =>
    MatexDividendReinvestmentCalculatorCore(
      defaultState: defaultState,
      validators: validators,
    );
