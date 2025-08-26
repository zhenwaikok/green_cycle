import 'package:green_cycle_fyp/model/notification_model/notification_request_model/notification_request_model.dart';
import 'package:green_cycle_fyp/repository/notification_repository.dart';
import 'package:green_cycle_fyp/viewmodel/base_view_model.dart';

class NotificationViewModel extends BaseViewModel {
  NotificationViewModel({required this.notificationRepository});

  NotificationRepository notificationRepository;

  Future<void> sendPushNotification({
    required String fcmToken,
    required String title,
    required String body,
    String? deeplink,
  }) async {
    NotificationRequestModel notificationRequestModel =
        NotificationRequestModel(
          message: Message(
            token: fcmToken,
            notification: NotificationContent(title: title, body: body),
            data: {'DeepLink': deeplink ?? ''},
          ),
        );

    final response = await notificationRepository.sendPushNotification(
      notificationRequestModel: notificationRequestModel,
    );

    print('notification response: ${response.data}');

    checkError(response);
  }
}
