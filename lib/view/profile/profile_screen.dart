import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nkr_e_mart/comoonWidgets/bg_widget.dart';
import 'package:nkr_e_mart/const/const_list.dart';
import 'package:nkr_e_mart/controller/auth_controller.dart';
import 'package:nkr_e_mart/controller/profile_controller.dart';
import 'package:nkr_e_mart/services/fire_store_services.dart';
import 'package:nkr_e_mart/view/auth_screen/login_screen.dart';
import 'package:nkr_e_mart/view/profile/components/details_card.dart';
import 'package:nkr_e_mart/view/profile/edit_profile_screen.dart';
import '../../const/consts.dart';

class ProfileScreen extends StatelessWidget {
  AuthController authController = Get.put(AuthController());
  ProfileController profileController = Get.put(ProfileController());

  ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            body: StreamBuilder(
      stream: FirestoreServices.getUser(currentUser!.uid),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(redColor),
            ),
          );
        } else {
          var data = snapshot.data!.docs[0];
          return SafeArea(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  // edit profile Button
                  GestureDetector(
                    onTap: () {
                      profileController.nameController.text = data['name'];
                      // profileController.passController.text = data['password'];
                      Get.to(() => EditProfileScreen(
                            data: data,
                          ));
                    },
                    child: const Align(
                      alignment: Alignment.topRight,
                      child: Icon(
                        Icons.edit,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: data['imagurl'] == " "
                              ? Image.asset(
                                  imgProfile2,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  data["imagurl"],
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              data['name'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: semibold,
                              ),
                            ),
                            Text(
                              data['email'],
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: whiteColor)),
                          onPressed: () async {
                            await authController.signOutMethod();
                            Get.offAll(() => LoginScreen());
                          },
                          child: const Text(
                            "Log Out",
                            style: TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      detailsCard(
                          count: data['cart_count'], title: "In your Count"),
                      detailsCard(
                          count: data['wishList_count'],
                          title: "In your WishList"),
                      detailsCard(
                          count: data['order_count'], title: "In your Order"),
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 1.0,
                            blurStyle: BlurStyle.inner,
                          ),
                        ],
                        gradient: const LinearGradient(
                            colors: [Colors.grey, Colors.red])),
                    child: ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            leading: Image.asset(
                              profileButtonIcon[index],
                              height: 20,
                              width: 20,
                            ),
                            title: Text(profileButtonList[index]),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            thickness: 1.0,
                            color: Colors.grey,
                          );
                        },
                        itemCount: profileButtonList.length),
                  )
                ],
              ),
            ),
          );
        }
      },
    )));
  }
}
