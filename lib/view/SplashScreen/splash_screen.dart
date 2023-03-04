import 'package:firebase_auth/firebase_auth.dart';
import 'package:nkr_e_mart/comoonWidgets/applogo_widgets.dart';
import 'package:nkr_e_mart/const/consts.dart';
import 'package:nkr_e_mart/view/auth_screen/login_screen.dart';

import '../HomeScreen/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      // Get.to(() =>  LoginScreen());

      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(() => LoginScreen());
        } else {
          Get.to(Home());
        }
      });
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  icSplashBg,
                  width: 300,
                )),
            appLogoWidget(),
            const SizedBox(
              height: 10,
            ),
            const Text(
              appname,
              style: TextStyle(
                  fontFamily: bold, fontSize: 22, color: Colors.white),
            ),
            const SizedBox(
              height: 5,
            ),
            const Text(
              appversion,
              style: TextStyle(color: Colors.white),
            ),
            const Spacer(),
            const Text(
              credits,
              style: TextStyle(color: Colors.white, fontFamily: semibold),
            ),
            const SizedBox(
              height: 30,
            )
            // splash screen UI is   completed
          ],
        ),
      ),
    );
  }
}
