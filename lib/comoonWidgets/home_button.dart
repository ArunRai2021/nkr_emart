import '../const/consts.dart';

Widget homeButton({width, height, icon, String? title, onPress}) {
  return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      height: height,
      width: width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            width: 26,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            title!,
            style: const TextStyle(color: darkFontGrey, fontFamily: semibold),
          )
        ],
      ));
}
