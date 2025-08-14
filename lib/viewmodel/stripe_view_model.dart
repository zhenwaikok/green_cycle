import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:green_cycle_fyp/constant/color_manager.dart';
import 'package:green_cycle_fyp/constant/constants.dart';
import 'package:green_cycle_fyp/model/stripe_model/stripe_request_model/stripe_request_model.dart';
import 'package:green_cycle_fyp/repository/stripe_repository.dart';
import 'package:green_cycle_fyp/viewmodel/base_view_model.dart';

class StripeViewModel extends BaseViewModel {
  StripeViewModel({required this.stripeRepository});

  final StripeRepository stripeRepository;

  Future<String> createPaymentIntent({required double amount}) async {
    StripeRequestModel stripeRequestModel = StripeRequestModel(
      amount: convertToInteger(amount: amount),
      currency: 'myr',
    );

    final response = await stripeRepository.createPaymentIntent(
      stripeRequestModel: stripeRequestModel,
    );

    checkError(response);
    return response.data;
  }

  Future<PaymentStatus> makePayment({
    required String paymentIntentClientSecret,
  }) async {
    Stripe.publishableKey = EnvValues.stripePublishableKey;
    final stripeInstance = Stripe.instance;

    try {
      await stripeInstance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: 'Green Cycle FYP',
          appearance: PaymentSheetAppearance(
            primaryButton: PaymentSheetPrimaryButtonAppearance(
              colors: PaymentSheetPrimaryButtonTheme(
                light: PaymentSheetPrimaryButtonThemeColors(
                  background: ColorManager.primary,
                ),
              ),
            ),
          ),
          billingDetails: BillingDetails(
            address: Address(
              country: 'MY',
              line1: null,
              line2: null,
              postalCode: null,
              state: null,
              city: null,
            ),
          ),
        ),
      );

      await stripeInstance.presentPaymentSheet();
      return PaymentStatus.success;
    } on StripeException catch (e) {
      if (e.error.code == FailureCode.Canceled) {
        return PaymentStatus.cancelled;
      } else {
        return PaymentStatus.failed;
      }
    } catch (_) {
      return PaymentStatus.failed;
    }
  }

  int convertToInteger({required double amount}) {
    return (amount * 100).toInt();
  }
}
