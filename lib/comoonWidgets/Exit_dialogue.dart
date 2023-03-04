import 'package:flutter/services.dart';
import 'package:nkr_e_mart/comoonWidgets/our_button.dart';

import '../const/consts.dart';

Widget exitDialog(context) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Confirm",
            style: TextStyle(
                color: darkFontGrey, fontSize: 18, fontFamily: "bold"),
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          const Text(
            "Are You Sure You want to exit",
            style: TextStyle(fontSize: 16, color: darkFontGrey),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ourButton(
                  color: redColor,
                  onPress: () {
                    SystemNavigator.pop();
                  },
                  textColor: whiteColor,
                  title: "yes"),
              ourButton(
                  color: redColor,
                  onPress: () {
                    Navigator.pop(context);
                  },
                  textColor: whiteColor,
                  title: "no")
            ],
          )
        ],
      ),
    ),
  );
}
