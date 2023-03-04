import 'package:nkr_e_mart/const/consts.dart';

class HomeController extends GetxController {
  var navigationIndex = 0.obs;

  var username = "";

  @override
  void onInit() {
    getUsername();
    super.onInit();
  }

  getUsername() async {
    var n = await fireStore
        .collection(userCollection)
        .where("id", isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        return value.docs.single['name'];
      }
    });
    username = n;
  }
}
