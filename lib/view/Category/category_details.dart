import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nkr_e_mart/comoonWidgets/bg_widget.dart';
import 'package:nkr_e_mart/controller/product_controller.dart';
import 'package:nkr_e_mart/services/fire_store_services.dart';
import 'package:nkr_e_mart/view/Category/item_details.dart';
import '../../comoonWidgets/loading_indicator.dart';
import '../../const/consts.dart';

class CategoryDetail extends StatelessWidget {
  String title;

  CategoryDetail({Key? key, required this.title}) : super(key: key);
  ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              title: Text(
                title,
                style: const TextStyle(color: Colors.white, fontFamily: bold),
              ),
            ),
            body: StreamBuilder(
              stream: FirestoreServices.getProduct(title),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: loadingIndicator());
                } else if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text(
                      "not data Found",
                      style: TextStyle(color: fontGrey, fontSize: 24),
                    ),
                  );
                } else {
                  var data = snapshot.data!.docs;
                  return Container(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                                productController.subCat.length,
                                (index) => Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 14),
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6)),
                                    child: Text(
                                      productController.subCat[index]
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily: semibold,
                                          color: darkFontGrey),
                                    ))),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Expanded(
                            child: GridView.builder(
                                physics: const BouncingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: data.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisExtent: 250,
                                        mainAxisSpacing: 8,
                                        crossAxisSpacing: 8),
                                itemBuilder: (BuildContext, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      productController.checkIfFav(data[index]);
                                      Get.to(() => ItemDetail(
                                            title: "${data[index]["p_name"]}",
                                            data: data[index],
                                          ));
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(12),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            data[index]['p_images'][0],
                                            width: 200,
                                            height: 150,
                                            fit: BoxFit.cover,
                                          ),
                                          const Spacer(),
                                          Text(
                                            "${data[index]["p_name"]}",
                                            style: const TextStyle(
                                                color: darkFontGrey,
                                                fontFamily: semibold),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "${data[index]['p_price']}",
                                            style: const TextStyle(
                                                color: redColor,
                                                fontFamily: bold,
                                                fontSize: 16),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }))
                      ],
                    ),
                  );
                }
              },
            )));
  }
}
