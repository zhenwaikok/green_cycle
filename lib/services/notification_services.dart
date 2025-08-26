import 'package:flutter/services.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/model/notification_model/notification_request_model/notification_request_model.dart';
import 'package:green_cycle_fyp/services/api_base_services.dart';

class NotificationServices extends BaseServices {
  Future<AccessCredentials> getAccessToken() async {
    final serviceAccountPath = EnvValues.fcmKeyFilePath;

    String serviceAccountJson = await rootBundle.loadString(serviceAccountPath);

    final serviceAccount = ServiceAccountCredentials.fromJson(
      serviceAccountJson,
    );

    final scopes = [EnvValues.fcmScope];

    final client = await clientViaServiceAccount(serviceAccount, scopes);

    return client.credentials;
  }

  Future<MyResponse> sendPushNotification({
    required NotificationRequestModel notificationRequestModel,
  }) async {
    final projectID = EnvValues.projectID;
    final credential = await getAccessToken();
    final accessToken = credential.accessToken.data;
    final notificationAuth = 'Bearer $accessToken';

    String path = '${fcmUrl()}/projects/$projectID/messages:send';

    print('fcm path: $path');

    return callAPI(
      httpMethod: HttpMethod.post,
      path: path,
      postBody: notificationRequestModel.toJson(),
      isNotification: true,
      notificationAuth: notificationAuth,
    );
  }
}
