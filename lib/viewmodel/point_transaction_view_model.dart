import 'package:green_cycle_fyp/model/api_model/points/points_model.dart';
import 'package:green_cycle_fyp/repository/point_transaction_repository.dart';
import 'package:green_cycle_fyp/viewmodel/base_view_model.dart';

class PointTransactionViewModel extends BaseViewModel {
  PointTransactionViewModel({required this.pointTransactionRepository});

  final PointTransactionRepository pointTransactionRepository;

  List<PointsModel> _pointTransactionList = [];
  List<PointsModel> get pointTransactionList => _pointTransactionList;

  Future<void> getPointTransactionsWithUserID({required String userID}) async {
    final response = await pointTransactionRepository
        .getPointTransactionsWithUserID(userID: userID);

    if (response.data is List<PointsModel>) {
      _pointTransactionList = response.data;
      notifyListeners();
    }

    checkError(response);
  }

  Future<bool> insertPointTransaction({
    required String userID,
    required int point,
    required String type,
    required String description,
    required DateTime createdAt,
  }) async {
    PointsModel pointsModel = PointsModel(
      userID: userID,
      point: point,
      type: type,
      description: description,
      createdAt: createdAt,
    );

    final response = await pointTransactionRepository.insertPointTransaction(
      pointsModel: pointsModel,
    );

    checkError(response);
    return response.data is PointsModel;
  }
}
