import 'package:green_cycle_fyp/model/api_model/awareness/awareness_model.dart';
import 'package:green_cycle_fyp/repository/awareness_repository.dart';
import 'package:green_cycle_fyp/viewmodel/base_view_model.dart';

class AwarenessViewModel extends BaseViewModel {
  AwarenessViewModel({required this.awarenessRepository});
  final AwarenessRepository awarenessRepository;

  AwarenessModel? awarenessDetails;

  Future<List<AwarenessModel>> getAwarenessList() async {
    final response = await awarenessRepository.getAllAwareness();

    if (response.data is List<AwarenessModel>) {
      final awarenessList = response.data as List<AwarenessModel>;
      return awarenessList;
    }

    checkError(response);
    return [];
  }

  Future<AwarenessModel> getAwarenessDetails({required int awarenessID}) async {
    final response = await awarenessRepository.getAwarenessDetails(
      awarenessID: awarenessID,
    );
    if (response.data is AwarenessModel) {
      return response.data;
    }

    checkError(response);
    return AwarenessModel();
  }

  // Future<bool> addAwareness({
  //   required String awarenessTitle,
  //   required String awarenessContent,
  // }) async {
  //   notify(MyResponse.loading());

  //   try {
  //     //upload image to firebase then get image url first

  //     final response = await _awarenessRepository.insertAwareness(
  //       awarenessModel: AwarenessModel(
  //         awarenessImageURL: '',
  //         awarenessTitle: awarenessTitle,
  //         awarenessContent: awarenessContent,
  //         createdDate: DateTime.now(),
  //       ),
  //     );

  //     if (response.data is AwarenessModel) {
  //       notify(MyResponse.complete(response.data));
  //       return true;
  //     } else if (response.status == ResponseStatus.error) {
  //       notify(MyResponse.error(response.error));
  //       return false;
  //     }
  //   } catch (e) {
  //     debugPrint('error: $e');
  //     notify(MyResponse.error(e.toString()));
  //     return false;
  //   }

  //   return false;
  // }
}
