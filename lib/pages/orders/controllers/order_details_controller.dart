import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platemate_user/api_services/base_api.dart';
import 'package:platemate_user/app_configs/api_routes.dart';
import 'package:platemate_user/app_configs/environment.dart';
import 'package:platemate_user/data_models/order.dart';
import 'package:platemate_user/utils/shared_preference_helper.dart';
import 'package:platemate_user/utils/snackbar_helper.dart';
import 'package:platemate_user/widgets/app_buttons/app_primary_button.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

///
/// Created by Auro on 30/04/23 at 9:15 AM
///

class OrderDetailsController extends GetxController with StateMixin<Order> {
  String? orderId;
  final GlobalKey<AppPrimaryButtonState> buttonKey =
      GlobalKey<AppPrimaryButtonState>();
  late Razorpay _razorPay;
  String? tableId, restaurantId;
  String? transactionId;
  double price = 0;

  @override
  void onInit() {
    super.onInit();
    _razorPay = Razorpay();
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    Map<String, dynamic> args = Get.arguments ?? {};
    tableId = args["tableId"];
    restaurantId = args["restaurantId"];
  }

  @override
  void dispose() {
    super.dispose();
    _razorPay.clear();
  }

  saveTotalPrice(double r) {
    price = r;
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    handleOrderConfirmation(response.paymentId!);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    buttonKey.currentState!.hideLoader();
  }

  initData(String c) {
    orderId = c;
  }

  getOrderDetails() async {
    try {
      change(null, status: RxStatus.loading());
      final result = await ApiCall.get(
        ApiRoutes.order,
        id: '$orderId',
        query: {
          '\$populate': ["orderedItems.menuItem", "restaurantDetails"],
        },
      );

      final response = Order.fromJson(result.data);

      change(response, status: RxStatus.success());
    } catch (e, s) {
      log("$e ::: $s");
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  createTransaction() async {
    try {
      // create transaction
      buttonKey.currentState!.showLoader();
      final result = await ApiCall.post(ApiRoutes.transaction, body: {
        "entityType": "order",
        "entityId": "$orderId",
        "price": state!.price.finalPrice,
      });
      transactionId = result.data['_id'];
      handleOnlinePayment(state!.price.finalPrice);
    } catch (err, s) {
      log("ERROR : $err: $s");
      buttonKey.currentState!.hideLoader();
      SnackBarHelper.show("$err");
    }
  }

  void handleOnlinePayment(double totalPrice) {
    try {
      String name = SharedPreferenceHelper.user!.user!.name!;
      String phone = SharedPreferenceHelper.user!.user!.phone!;
      var options = {
        'key': Environment.razorPayKey,
        'name': Environment.razorPayName,
        'amount': totalPrice * 100,
        'orderId': transactionId,
        'prefill': {
          'contact': phone,
          'email': SharedPreferenceHelper.user!.user!.email,
        },
        'notes': {
          'name': name,
          'phone': phone,
          'paymentId': transactionId,
        }
      };
      _razorPay.open(options);
    } catch (err) {
      buttonKey.currentState!.hideLoader();
      //SnackBarHelper.show('', err.toString());
    }
  }

  void handleOrderConfirmation([String paymentId = '']) async {
    Map<String, dynamic> body = {
      "status": 2,
      if (paymentId.isNotEmpty) "paymentId": paymentId,
    };
    try {
      await ApiCall.patch(ApiRoutes.transaction,
          body: body, id: transactionId!);
      buttonKey.currentState!.hideLoader();
      final temp = state!;
      temp.paymentStatus = 1;
      change(temp, status: RxStatus.success());
      SnackBarHelper.show("Paid successfully");
    } catch (err) {
      buttonKey.currentState!.hideLoader();
      SnackBarHelper.show(err.toString());
    }
  }

  proceedPayment() {
    try {
      //
    } catch (err, s) {
      //
      log("ERROR : $err: $s");
      buttonKey.currentState!.hideLoader();
      SnackBarHelper.show("$err");
    }
  }
}
