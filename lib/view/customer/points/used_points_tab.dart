import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/view/base_stateful_page.dart';
import 'package:green_cycle_fyp/widget/points_transaction_card.dart';

class UsedPointsTab extends BaseStatefulPage {
  const UsedPointsTab({super.key});

  @override
  State<UsedPointsTab> createState() => _UsedPointsTabState();
}

class _UsedPointsTabState extends BaseStatefulState<UsedPointsTab> {
  @override
  EdgeInsets defaultPadding() {
    return EdgeInsets.zero;
  }

  @override
  EdgeInsets bottomNavigationBarPadding() {
    return EdgeInsets.zero;
  }

  @override
  Widget body() {
    return getUsedPointsList();
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _UsedPointsTabState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _UsedPointsTabState {
  Widget getUsedPointsList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return PointsTransactionCard(
          transactionName: 'Transaction Name',
          transactionDate: '27/2/2025, 12.35AM',
          points: '-60',
          isEarned: false,
        );
      },
    );
  }
}
