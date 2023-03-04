import 'package:nkr_e_mart/comoonWidgets/applogo_widgets.dart';
import 'package:nkr_e_mart/comoonWidgets/bg_widget.dart';
import 'package:nkr_e_mart/comoonWidgets/custom_textfeild.dart';
import 'package:nkr_e_mart/comoonWidgets/our_button.dart';
import 'package:nkr_e_mart/const/const_list.dart';
import 'package:nkr_e_mart/controller/auth_controller.dart';
import 'package:nkr_e_mart/view/HomeScreen/home.dart';
import 'package:nkr_e_mart/view/auth_screen/signup_screen.dart';
import '../../const/consts.dart';

class LoginScreen extends StatelessWidget {
  AuthController authController = Get.put(AuthController());

  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: context.height * 0.1,
            ),
            appLogoWidget(),
            const SizedBox(
              height: 10,
            ),
            const Text(
              "Log in to $appname",
              style: TextStyle(
                  fontFamily: bold, color: Colors.white, fontSize: 18),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: context.width - 70,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(blurRadius: 1, offset: Offset(1, 1))
                  ]),
              child: Obx(
                () => Column(
                  children: [
                    customTextField(
                        title: email,
                        hint: emailHint,
                        isPass: false,
                        controller: authController.emailController),
                    const SizedBox(
                      height: 5,
                    ),
                    customTextField(
                        title: password,
                        hint: passwordHint,
                        isPass: true,
                        controller: authController.passwordController),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            forgetpass,
                            style: TextStyle(),
                          )),
                    ),
                    authController.isLoading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(redColor),
                          )
                        : SizedBox(
                            width: context.width - 50,
                            child: ourButton(
                                title: login,
                                textColor: Colors.white,
                                color: redColor,
                                onPress: () async {
                                  authController.isLoading.value = true;
                                  await authController
                                      .loginMethod()
                                      .then((value) {
                                    if (value != null) {
                                      const SnackBar(
                                        content: Text(loggedIn),
                                      );
                                      Get.offAll(() => Home());
                                    } else {
                                      authController.isLoading.value = false;
                                    }
                                  });
                                })),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      createNewAccount,
                      style: TextStyle(color: fontGrey),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: context.width - 50,
                      child: ourButton(
                          title: signup,
                          color: lightGolden,
                          textColor: redColor,
                          onPress: () {
                            Get.to(() => const SignupScreen());
                          }),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      loginWith,
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            socialIconList.length,
                            (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    backgroundColor: lightGrey,
                                    radius: 25,
                                    child: Image.asset(
                                      socialIconList[index],
                                      width: 30,
                                    ),
                                  ),
                                )))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
