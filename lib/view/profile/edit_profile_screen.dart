import 'dart:io';

import 'package:nkr_e_mart/comoonWidgets/bg_widget.dart';
import 'package:nkr_e_mart/comoonWidgets/custom_textfeild.dart';
import 'package:nkr_e_mart/comoonWidgets/our_button.dart';
import 'package:nkr_e_mart/controller/profile_controller.dart';
import '../../const/consts.dart';

class EditProfileScreen extends StatelessWidget {
  ProfileController profileController = Get.find();
  final dynamic data;

  EditProfileScreen({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Container(
        // height: MediaQuery.of(context).size.height / 1.8,
        margin: const EdgeInsets.only(top: 50, left: 12, right: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
                blurRadius: 1.0, blurStyle: BlurStyle.inner, spreadRadius: 1.0),
          ],
        ),
        child: Center(
          child: Obx(
            () => Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40,
                  child: ClipOval(
                      child:
                          // if data image url and controller path is empty
                          data['imagurl'] == " " &&
                                  profileController.profileImgPath.isEmpty
                              ? Image.asset(
                                  imgProfile2,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                              // if data is not empty but controller path is empty
                              : data['imagurl'] != " " &&
                                      profileController.profileImgPath.isEmpty
                                  ? Image.network(
                                      data['imagurl'],
                                      width: 100,
                                      fit: BoxFit.cover,
                                    )
                                  // if both are empty
                                  : Image.file(
                                      File(profileController
                                          .profileImgPath.value),
                                      width: 100,
                                      fit: BoxFit.cover,
                                    )),
                ),
                const SizedBox(
                  height: 10,
                ),
                ourButton(
                    color: redColor,
                    onPress: () {
                      profileController.changeImage();
                    },
                    textColor: whiteColor,
                    title: "Change"),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                customTextField(
                    controller: profileController.nameController,
                    hint: nameHint,
                    title: name,
                    isPass: false),
                const SizedBox(height: 10),
                customTextField(
                    controller: profileController.oldPassController,
                    hint: passwordHint,
                    title: oldPass,
                    isPass: true),
                const SizedBox(
                  height: 10,
                ),
                customTextField(
                    controller: profileController.newPassController,
                    hint: passwordHint,
                    title: newPass,
                    isPass: true),
                const SizedBox(
                  height: 20,
                ),
                profileController.isLoading.value
                    ? const CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(redColor),
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width - 60,
                        child: ourButton(
                            color: redColor,
                            onPress: () async {
                              profileController.isLoading.value = true;
                              // if image is not selected
                              if (profileController
                                  .profileImgPath.value.isNotEmpty) {
                                await profileController.uploadProfileImage();
                              } else {
                                profileController.profileImageLink =
                                    data['imagurl'];
                              }
                              // if old password matches with database
                              if (data['password'] ==
                                  profileController.oldPassController.text) {
                                await profileController.changeAuthPassword(
                                    email: data['email'],
                                    password: profileController
                                        .oldPassController.text,
                                    newPassword: profileController
                                        .newPassController.text);
                                await profileController.updateProfile(
                                    name: profileController.nameController.text,
                                    password: profileController
                                        .newPassController.text,
                                    imgUrl: profileController.profileImageLink);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: Colors.green,
                                        content: Text("Profile Updated")));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text("Wrong Old password")));
                                profileController.isLoading.value = false;
                              }
                            },
                            textColor: whiteColor,
                            title: "save"),
                      )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
