import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/model/stripe_model/stripe_request_model/stripe_request_model.dart';
import 'package:green_cycle_fyp/model/stripe_model/stripe_response_model/stripe_response_model.dart';
import 'package:green_cycle_fyp/services/stripe_services.dart';

class StripeRepository {
  final StripeServices _stripeServices = StripeServices();

  Future<MyResponse> createPaymentIntent({
    required StripeRequestModel stripeRequestModel,
  }) async {
    final response = await _stripeServices.createPaymentIntent(
      stripeRequestModel: stripeRequestModel,
    );

    if (response.data is Map<String, dynamic>) {
      final resultModel = StripeResponseModel.fromJson(response.data);
      final clientSecret = resultModel.clientSecret;
      if (clientSecret != null) {
        return MyResponse.complete(clientSecret);
      }
    }

    return response;
  }
}
