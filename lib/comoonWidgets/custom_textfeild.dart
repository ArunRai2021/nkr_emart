import '../const/consts.dart';

Widget customTextField({String? title, String? hint, controller,isPass}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title!,
        style: const TextStyle(
            color: redColor, fontFamily: semibold, fontSize: 16),
      ),
      const SizedBox(
        height: 5,
      ),
      TextFormField(
        obscureText: isPass,
        controller: controller,
        decoration: InputDecoration(
            hintStyle: const TextStyle(fontFamily: semibold, color: fontGrey),
            hintText: hint,
            isDense: true,
            fillColor: lightGrey,
            filled: true,
            border: InputBorder.none,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red))),
      )
    ],
  );
}
