import 'package:nkr_e_mart/const/consts.dart';

Widget appLogoWidget() {
  return Container(
    height: 77,
    width: 77,
    padding: const EdgeInsets.all(8),
    decoration: const BoxDecoration(
      color: Colors.white,
    ),
    child: Image.asset(
      icAppLogo,
    ),
  );
}
