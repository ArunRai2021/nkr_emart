import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nkr_e_mart/comoonWidgets/loading_indicator.dart';
import 'package:nkr_e_mart/comoonWidgets/our_button.dart';
import 'package:nkr_e_mart/controller/cart_controller.dart';
import 'package:nkr_e_mart/services/fire_store_services.dart';

import '../../const/consts.dart';

class CartScreen extends StatelessWidget {
  CartScreen({Key? key}) : super(key: key);
  CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            "Shopping Cart",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: StreamBuilder(
          stream: FirestoreServices.getCart(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: loadingIndicator());
            } else if (snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("Cart is Empty"));
            } else {
              var data = snapshot.data!.docs;
              cartController.calculate(data);
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, index) {
                            return ListTile(
                              leading: Image.network("${data[index]['img']}"),
                              title: Text(
                                  "${data[index]['title']} (x${data[index]['qty']})"),
                              subtitle: Text("${data[index]['tPrice']}"),
                              trailing: GestureDetector(
                                onTap: () {
                                  FirestoreServices.deleteDocuments(
                                      data[index].id);
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 60,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: lightGolden,
                          borderRadius: BorderRadius.circular(12)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Price",
                            style: TextStyle(
                              color: darkFontGrey,
                              fontFamily: semibold,
                            ),
                          ),
                          Obx(
                            () => Text(
                              "${cartController.totalP}",
                              style: const TextStyle(
                                  fontFamily: semibold, color: darkFontGrey),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 60,
                      child: ourButton(
                          color: redColor,
                          onPress: () {},
                          textColor: whiteColor,
                          title: "Proceed to Shipping"),
                    )
                  ],
                ),
              );
            }
          },
        ));
  }
}
