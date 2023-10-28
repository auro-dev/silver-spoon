import 'package:get/get.dart';
import 'package:platemate_user/data_models/order.dart';
import 'package:platemate_user/data_models/restaurant.dart';

///
/// Created by Auro on 02/05/23 at 12:44 AM
///

class CartController extends GetxController with StateMixin<List<OrderedItem>> {

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  handleIncreaseCount(MenuItem value,
      {Variant? variant, List<Customisation>? customisations}) {
    /// ++
    List<OrderedItem> tempList = state ?? [];
    int index =
        tempList.indexWhere((element) => element.menuItem.id == value.id);
    if (index != -1) {
      // already there
      tempList[index].quantity++;
    } else {
      // new one
      tempList.add(
        OrderedItem(
          menuItem: value,
          quantity: 1,
          variant: variant ?? Variant.fromJson({}),
          customisations: customisations ?? [],
          id: 'x',
        ),
      );
    }

    change(tempList, status: RxStatus.success());
  }

  handleDecreaseCount(MenuItem value) {
    /// --
    List<OrderedItem> tempList = state ?? [];
    int index =
        tempList.indexWhere((element) => element.menuItem.id == value.id);
    if (index != -1) {
      // already there
      if (tempList[index].quantity > 0) tempList[index].quantity--;
    }
    change(tempList, status: RxStatus.success());
  }

  clearCartItems() {
    change([], status: RxStatus.empty());
  }
}
