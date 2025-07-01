import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/widget/points_transaction_card.dart';

class EarnedPointsTab extends StatefulWidget {
  const EarnedPointsTab({super.key});

  @override
  State<EarnedPointsTab> createState() => _EarnedPointsTabState();
}

class _EarnedPointsTabState extends State<EarnedPointsTab> {
  @override
  Widget build(BuildContext context) {
    return getEarnedPointsList();
  }
}

// * ---------------------------- Actions ----------------------------
extension _Actions on _EarnedPointsTabState {}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _EarnedPointsTabState {
  Widget getEarnedPointsList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return PointsTransactionCard(
          transactionName: 'Transaction Name',
          transactionDate: '27/2/2025, 12.35AM',
          points: '+60',
          isEarned: true,
        );
      },
    );
  }
}
