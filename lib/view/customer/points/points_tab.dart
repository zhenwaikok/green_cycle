import 'package:flutter/material.dart';
import 'package:green_cycle_fyp/model/api_model/points/points_model.dart';
import 'package:green_cycle_fyp/utils/util.dart';
import 'package:green_cycle_fyp/widget/points_transaction_card.dart';

class PointsTab extends StatefulWidget {
  const PointsTab({
    super.key,
    required this.pointTransactionDetails,
    required this.isLoading,
  });
  final PointsModel pointTransactionDetails;
  final bool isLoading;

  @override
  State<PointsTab> createState() => _PointsTabState();
}

class _PointsTabState extends State<PointsTab> {
  @override
  Widget build(BuildContext context) {
    return getPointTranscationCard(
      pointTransactionDetails: widget.pointTransactionDetails,
    );
  }
}

// * ------------------------ WidgetFactories ------------------------
extension _WidgetFactories on _PointsTabState {
  Widget getPointTranscationCard({
    required PointsModel pointTransactionDetails,
  }) {
    final isEarned = pointTransactionDetails.type == 'earn';

    return PointsTransactionCard(
      transactionName: pointTransactionDetails.description ?? '',
      transactionDate: WidgetUtil.dateTimeFormatter(
        pointTransactionDetails.createdAt ?? DateTime.now(),
      ),
      points: isEarned
          ? '+${pointTransactionDetails.point}'
          : '-${pointTransactionDetails.point}',
      isEarned: isEarned,
      isLoading: widget.isLoading,
    );
  }
}
