import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/model/network/my_response.dart';
import 'package:green_cycle_fyp/model/stripe_model/stripe_request_model/stripe_request_model.dart';
import 'package:green_cycle_fyp/services/api_base_services.dart';

class StripeServices extends BaseServices {
  Future<MyResponse> createPaymentIntent({
    required StripeRequestModel stripeRequestModel,
  }) async {
    String path = '${stripeUrl()}/payment_intents';

    return callAPI(
      httpMethod: HttpMethod.post,
      path: path,
      postBody: stripeRequestModel.toJson(),
      isStripe: true,
    );
  }
}
