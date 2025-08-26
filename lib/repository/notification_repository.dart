import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/model/notification_model/notification_request_model/notification_request_model.dart';
import 'package:green_cycle_fyp/model/notification_model/notification_response_model/notification_response_model.dart';
import 'package:green_cycle_fyp/services/notification_services.dart';

class NotificationRepository {
  NotificationServices get _notificationServices => NotificationServices();

  Future<MyResponse> sendPushNotification({
    required NotificationRequestModel notificationRequestModel,
  }) async {
    final response = await _notificationServices.sendPushNotification(
      notificationRequestModel: notificationRequestModel,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = NotificationResponseModel.fromJson(response.data);
      return MyResponse.complete(resultModel);
    }

    return response;
  }
}
