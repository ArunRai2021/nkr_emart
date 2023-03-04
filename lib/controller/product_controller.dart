import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:nkr_e_mart/const/consts.dart';
import 'package:nkr_e_mart/models/category_model.dart';

class ProductController extends GetxController {
  var subCat = [];
  var quantityIndex = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;
  var isFav = false.obs;

  getSubCategories(title) async {
    subCat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();
    for (var e in s[0].subcategory) {
      subCat.add(e);
    }
  }

  void increaseQuantity(quantity) {
    if (quantityIndex < quantity) {
      quantityIndex++;
    }
  }

  void decreaseQuantity() {
    if (quantityIndex > 0) {
      quantityIndex--;
    }
  }

  void changeColorIndex(index) {
    colorIndex.value = index;
  }

  calculateTotalPrice(price) {
    totalPrice.value = price * quantityIndex.value;
  }

  addToCart({title, img, sellerName, color, qty, tPrice}) async {
    await fireStore.collection(cartCollection).doc().set({
      "title": title,
      "img": img,
      "sellerName": sellerName,
      "color": color,
      "qty": qty,
      "tPrice": tPrice,
      "added_by": currentUser!.uid,
    }).catchError((error) {
      error.toString();
    });
  }

  resetValue() {
    quantityIndex.value = 0;
    colorIndex.value = 0;
    totalPrice.value = 0;
  }

  addToWishList(docId) async {
    await fireStore.collection(productCollection).doc(docId).set({
      'p_wishList': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
  }

  removeFromWishList(docId) async {
    await fireStore.collection(productCollection).doc(docId).set({
      'p_wishList': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
  }

  checkIfFav(data) async {
    if (data['p_wishlist'].contains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
