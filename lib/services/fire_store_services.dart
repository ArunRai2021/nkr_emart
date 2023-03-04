import 'package:nkr_e_mart/const/consts.dart';

class FirestoreServices {
  // get User Data
  static getUser(uid) {
    return fireStore
        .collection(userCollection)
        .where('id', isEqualTo: uid)
        .snapshots();
  }

// get Product according to Category
  static getProduct(category) {
    return fireStore
        .collection(productCollection)
        .where("p_category", isEqualTo: category)
        .snapshots();
  }

  // get Cart
  static getCart(uid) {
    return fireStore
        .collection(cartCollection)
        .where("added_by", isEqualTo: uid)
        .snapshots();
  }

  // delete document
  static deleteDocuments(docId) {
    return fireStore.collection(cartCollection).doc(docId).delete();
  }

  // get all chat messages
  static getChatMessages(docId) {
    return fireStore
        .collection(chatsCollection)
        .doc(docId)
        .collection(messagesCollection)
        .orderBy('created_on', descending: false)
        .snapshots();
  }
}
