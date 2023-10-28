
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platemate_user/data_models/restaurant.dart';
import 'package:platemate_user/pages/restaurant_menu/controllers/menu_customisation_controller.dart';
import 'package:platemate_user/pages/restaurant_menu/widgets/customisation_input_box.dart';
import 'package:platemate_user/widgets/app_buttons/app_primary_button.dart';

///
/// Created by Auro on 26/04/23 at 9:53 PM
///

class MenuItemCustomisationSheet extends StatefulWidget {
  final MenuItem datum;

  const MenuItemCustomisationSheet(this.datum, {Key? key}) : super(key: key);

  @override
  State<MenuItemCustomisationSheet> createState() =>
      _MenuItemCustomisationSheetState();
}

class _MenuItemCustomisationSheetState
    extends State<MenuItemCustomisationSheet> {
  late MenuCustomisationController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered()
        ? Get.find<MenuCustomisationController>()
        : Get.put(MenuCustomisationController());
    controller.saveId(widget.datum.id);
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Customization",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
          Expanded(
            child: ListView(
              physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              children: [
                if (widget.datum.variants.length > 1)
                  const SizedBox(height: 16),
                if (widget.datum.variants.length > 1)
                  GetBuilder(
                    init: controller,
                    builder: (c) => VariantsInputBox(
                      onChanged: (c) {
                        List<Variant> variants = widget.datum.variants
                            .where((e) => c == e.title)
                            .toList();
                        if (variants.isNotEmpty) {
                          controller.selectVariant(variants.first);
                        }
                      },
                      displayData: widget.datum.variants
                          .map((e) =>
                              e.title +
                              "   ( Rs. ${e.price.toStringAsFixed(0)} )")
                          .toList(),
                      data: widget.datum.variants.map((e) => e.title).toList(),
                      selectedValue: controller.selectedVariant == null
                          ? null
                          : controller.selectedVariant!.title,
                      title: "Variants",
                    ),
                  ),
                const SizedBox(height: 16),
                controller.obx((state) {
                  if (state != null) {
                    return ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (c, i) => CustomisationInputBox(
                        onChanged: (c) =>
                            controller.selectCustomisationValue(i, c),
                        data: state[i]
                            .customisation
                            .options!
                            .map((e) => e)
                            .toList(),
                        selectedValue: state[i].customisation.value,
                        title: state[i].customisation.title,
                      ),
                      separatorBuilder: (c, i) => const SizedBox(height: 16),
                      itemCount: state.length,
                    );
                  }
                  return SizedBox();
                }),
                const SizedBox(height: 20),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: AppPrimaryButton(
              child: Text("Add to cart"),
              onPressed: () {
                Get.back(result: {
                  "variant": controller.selectedVariant == null
                      ? widget.datum.variants.first
                      : controller.selectedVariant,
                  "customisations": controller.state!
                      .where((element) => element.customisation.value != null)
                      .toList()
                      .map((e) => e.customisation)
                      .toList(),
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
