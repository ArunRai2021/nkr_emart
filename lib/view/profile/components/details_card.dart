import '../../../const/consts.dart';

Widget detailsCard({required String count, required String title}) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: Colors.white),
    child: Column(
      children: [
        Text(
          count,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        )
      ],
    ),
  );
}
