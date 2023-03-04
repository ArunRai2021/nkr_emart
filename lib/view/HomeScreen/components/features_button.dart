import '../../../const/consts.dart';

Widget featuredButton({String? title, icon}) {
  return Container(
    padding: const EdgeInsets.all(4),
    margin: const EdgeInsets.symmetric(horizontal: 4),
    width: 200,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      children: [
        Image.asset(
          icon,
          width: 60.0,
          height: 40,
          fit: BoxFit.fill,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          title!,
          style: TextStyle(color: darkFontGrey, fontFamily: semibold),
        )
      ],
    ),
  );
}
