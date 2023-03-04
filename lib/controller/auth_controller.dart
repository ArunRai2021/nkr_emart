import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nkr_e_mart/const/consts.dart';

class AuthController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false.obs;

  // login method
  Future<UserCredential?> loginMethod() async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      );
    }
    return userCredential;
  }

  // signup Method

  Future<UserCredential?> signupMethod(email, password) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      );
    }
    return userCredential;
  }

  // stroring data method

  storeUserData({name, password, email}) async {
    DocumentReference store =
        fireStore.collection(userCollection).doc(currentUser!.uid);
    store.set({
      'name': name,
      'password': password,
      'email': email,
      'imagurl': " ",
      'id': currentUser!.uid,
      "cart_count": "00",
      "order_count": "00",
      "wishList_count": "00",
    });
  }

  // signOut method

  signOutMethod() async {
    try {
      await auth.signOut();
    } catch (e) {
      SnackBar(
        content: Text(e.toString()),
        backgroundColor: Colors.red,
      );
    }
  }
}
