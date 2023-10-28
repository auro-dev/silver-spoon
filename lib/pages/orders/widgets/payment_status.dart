///
/// Created by Auro on 30/04/23 at 2:44 PM
///

import 'package:flutter/material.dart';

///
/// Created by Auro (auro@smarttersstudio.com) on 21/01/22 at 5:37 pm
///

class PaymentStatus extends StatelessWidget {
  final String title;

  const PaymentStatus(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              "${title.toUpperCase()}",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          // Container(
          //   padding: const EdgeInsets.all(16),
          //   child: Row(
          //     children: [
          //       Text(
          //         "Pay online: ",
          //         style: TextStyle(
          //           fontSize: 12,
          //           color: Colors.white,
          //         ),
          //       ),
          //       Text(
          //         "₹60",
          //         style: TextStyle(
          //           fontWeight: FontWeight.w700,
          //           color: Colors.white,
          //         ),
          //       ),
          //     ],
          //   ),
          //   decoration: BoxDecoration(
          //     color: Color(0xff599BF5),
          //     borderRadius: BorderRadius.circular(7),
          //   ),
          // )
        ],
      ),
      decoration: BoxDecoration(
        color: Color(0xffEBECF2),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
