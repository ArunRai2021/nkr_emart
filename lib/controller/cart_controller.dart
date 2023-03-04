import 'package:nkr_e_mart/const/consts.dart';

class CartController extends GetxController {
  var totalP = 0.obs;

  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tPrice'].toString());
    }
  }
}
