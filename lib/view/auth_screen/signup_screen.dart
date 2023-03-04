import 'package:nkr_e_mart/controller/auth_controller.dart';
import 'package:nkr_e_mart/view/HomeScreen/home.dart';
import '../../comoonWidgets/applogo_widgets.dart';
import '../../comoonWidgets/bg_widget.dart';
import '../../comoonWidgets/custom_textfeild.dart';
import '../../comoonWidgets/our_button.dart';
import '../../const/consts.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _isCheck = false;
  AuthController authController = Get.put(AuthController());
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

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
              "Join the $appname",
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
                        title: name,
                        hint: nameHint,
                        controller: nameController,
                        isPass: false),
                    const SizedBox(
                      height: 5,
                    ),
                    customTextField(
                        title: email,
                        hint: emailHint,
                        controller: emailController,
                        isPass: false),
                    const SizedBox(
                      height: 5,
                    ),
                    customTextField(
                        title: password,
                        hint: passwordHint,
                        controller: passwordController,
                        isPass: true),
                    const SizedBox(
                      height: 5,
                    ),
                    customTextField(
                        title: reTypePassword,
                        hint: passwordHint,
                        controller: passwordRetypeController,
                        isPass: true),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            forgetpass,
                            style: TextStyle(),
                          )),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          activeColor: redColor,
                          checkColor: whiteColor,
                          value: _isCheck,
                          onChanged: (newValue) {
                            setState(() {
                              _isCheck = newValue!;
                            });
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: RichText(
                              text: const TextSpan(children: [
                            TextSpan(
                                text: "I agree to the ",
                                style: TextStyle(
                                    fontFamily: regular, color: fontGrey)),
                            TextSpan(
                                text: termAndCond,
                                style: TextStyle(
                                    fontFamily: regular, color: redColor)),
                            TextSpan(
                                text: " & ",
                                style: TextStyle(
                                    fontFamily: regular, color: redColor)),
                            TextSpan(
                                text: privacyPolicy,
                                style: TextStyle(
                                    fontFamily: regular, color: redColor))
                          ])),
                        )
                      ],
                    ),
                    SizedBox(
                        width: context.width - 50,
                        child: authController.isLoading.value
                            ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(redColor),
                        )
                            : ourButton(
                                title: signup,
                                textColor: Colors.white,
                                color: _isCheck == true
                                    ? Colors.red
                                    : Colors.white,
                                onPress: () async {
                                  authController.isLoading.value = true;
                                  if (_isCheck == true) {
                                    try {
                                      await authController
                                          .signupMethod(emailController.text,
                                              passwordController.text)
                                          .then((value) {
                                        return authController.storeUserData(
                                            email: emailController.text,
                                            password: passwordController.text,
                                            name: nameController.text);
                                      }).then((value) {
                                        const SnackBar(
                                          content: Text(loggedIn),
                                          backgroundColor: Colors.green,
                                        );
                                        Get.offAll(Home());
                                      });
                                    } catch (e) {
                                      auth.signOut();
                                      SnackBar(
                                        content: Text(e.toString()),
                                      );
                                      authController.isLoading.value = false;
                                    }
                                  }
                                })),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          alreadyHaveAccount,
                          style: TextStyle(color: fontGrey, fontFamily: bold),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Text(
                            login,
                            style: TextStyle(color: redColor, fontFamily: bold),
                          ),
                        )
                      ],
                    )
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
