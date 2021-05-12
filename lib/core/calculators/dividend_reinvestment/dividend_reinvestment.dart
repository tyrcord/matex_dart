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

  Decimal get dTaxRate => toPercentageDecimal(state.taxRate ?? 0);

  Decimal get dDividendYield => toPercentageDecimal(state.dividendYield!);

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

  Decimal get dStartingPrincipal {
    return toDecimal(state.numberOfShares ?? 0) *
        toDecimal(state.sharePrice ?? 0);
  }

  Decimal get dTotalContribution {
    return toDecimal(state.annualContribution ?? 0) *
        toDecimal(state.yearsToGrow ?? 0);
  }

  Decimal _computeTotalReturn(double endingBalance) {
    return (toDecimal(endingBalance) /
            (dTotalContribution + dStartingPrincipal) *
            MatexDecimal.hundred) -
        MatexDecimal.hundred;
  }

  @override
  MatexDividendReinvestmentResult value() {
    if (result != null) return result!;

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
        totalReturn: _computeTotalReturn(lastReport!.endingBalance).toDouble(),
        grossDividendPaid: lastReport.cumulativeGrossAmount,
        netDividendPaid: lastReport.cumulativeNetAmount,
        totalContribution: dTotalContribution.toDouble(),
        startingBalance: dStartingPrincipal.toDouble(),
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
    var dividendAmount = dDividendAmountPerShare / dDividendPaymentFrequency;
    var payoutReports = <MatexDividendReinvestementPayoutReport>[];
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

    var dSharePriceIncreaseAmount = Decimal.zero;
    var dCurrentSharePrice = dSharePrice;

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

      if (state.drip!) {
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

      if (i + 1 == dDividendPaymentFrequency.toInt()) {
        dAdditionalShareFromAnnualContribution =
            _computeAdditionalShareFromAnnualContribution(
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

  Decimal _computeAdditionalShareFromAnnualContribution(
    Decimal dCurrentSharePrice,
  ) {
    final dAnnualContribution = toDecimal(state.annualContribution ?? 0);

    if (dAnnualContribution > Decimal.zero) {
      return _computeAdditionalShare(
        dAnnualContribution,
        dCurrentSharePrice,
      );
    }

    return Decimal.zero;
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
