import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:nkr_e_mart/comoonWidgets/our_button.dart';
import 'package:nkr_e_mart/const/const_list.dart';
import 'package:nkr_e_mart/controller/product_controller.dart';
import 'package:nkr_e_mart/view/chatScreen/chat_screen.dart';
import '../../const/consts.dart';
import 'dart:math' as math;

class ItemDetail extends StatelessWidget {
  String title;
  final dynamic data;

  ItemDetail({Key? key, required this.title, this.data}) : super(key: key);
  ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        productController.resetValue();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              productController.resetValue();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(
            title,
            style: const TextStyle(color: darkFontGrey, fontFamily: bold),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.share),
            ),
            Obx(
              () => IconButton(
                onPressed: () {
                  if (productController.isFav.value) {
                    productController.removeFromWishList(data.id);
                    productController.isFav.value = false;
                  } else {
                    productController.addToWishList(data.id);
                    productController.isFav.value = true;
                  }
                },
                icon: Icon(
                  Icons.favorite_outlined,
                  color:
                      productController.isFav.value ? redColor : darkFontGrey,
                ),
              ),
            )
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                          addAutomaticKeepAlives: true,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: data["p_images"].length,
                          itemBuilder: (context, index) {
                            return AspectRatio(
                              aspectRatio: 8 / 8,
                              child: Image.network(
                                data['p_images'][index],
                                fit: BoxFit.cover,
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 16,
                          color: darkFontGrey,
                          fontFamily: semibold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RatingBar(
                        glowRadius: 3,
                        minRating: 1,
                        maxRating: 5,
                        initialRating: 3,
                        allowHalfRating: true,
                        ratingWidget: RatingWidget(
                            full: const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 12,
                            ),
                            empty: const Icon(
                              Icons.star,
                              color: Colors.grey,
                              size: 12,
                            ),
                            half: const Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 12,
                            )),
                        onRatingUpdate: (value) {}),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${data["p_price"]}",
                      style: TextStyle(color: redColor, fontFamily: semibold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      height: 60,
                      decoration: const BoxDecoration(color: textFeildGrey),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Seller",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: semibold),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  "${data["p_seller"]}",
                                  style: const TextStyle(
                                      color: darkFontGrey,
                                      fontFamily: semibold),
                                )
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(() => ChatScreen(), arguments: [
                                data['p_seller'],
                                data['vendor_id']
                              ]);
                            },
                            child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.message_rounded,
                                color: darkFontGrey,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(boxShadow: [
                        BoxShadow(
                            color: Colors.white60,
                            offset: Offset.zero,
                            blurRadius: 2.0,
                            spreadRadius: 2.0,
                            blurStyle: BlurStyle.inner)
                      ]),
                      child: Obx(
                        () => Column(
                          children: [
                            Row(
                              children: [
                                const SizedBox(
                                  width: 100,
                                  child: Text(
                                    "Color :",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Row(
                                    children: List.generate(
                                        data['p_colors'].length,
                                        (index) => Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    productController
                                                        .changeColorIndex(
                                                            index);
                                                  },
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 4),
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20),
                                                        color: Color(
                                                            data['p_colors']
                                                                [index])),
                                                    height: 40,
                                                    width: 40,
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: index ==
                                                      productController
                                                          .colorIndex.value,
                                                  child: const Icon(Icons.check,
                                                      color: Colors.white),
                                                )
                                              ],
                                            ))),
                              ],
                            ),

                            // quantity Row
                            Row(
                              children: [
                                const SizedBox(
                                  width: 100,
                                  child: Text(
                                    "Quantity :",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          productController.decreaseQuantity();
                                          productController.calculateTotalPrice(
                                              int.parse(data['p_price']));
                                        },
                                        icon: const Icon(Icons.remove)),
                                    Text(
                                      productController.quantityIndex.value
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: darkFontGrey,
                                          fontFamily: bold),
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          productController.increaseQuantity(
                                              int.parse(data['p_quantity']));
                                          productController.calculateTotalPrice(
                                              int.parse(data['p_price']));
                                        },
                                        icon: const Icon(Icons.add)),
                                    Text(
                                      "(${data['p_quantity']} avalaible)",
                                      style: TextStyle(color: textFeildGrey),
                                    )
                                  ],
                                )
                              ],
                            ),
                            //total Row
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: 100,
                                    child: Text(
                                      "Total :",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  Text(
                                    "${productController.totalPrice.value}",
                                    style: const TextStyle(
                                        color: redColor,
                                        fontSize: 16,
                                        fontFamily: bold),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    //description section
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Description",
                      style:
                          TextStyle(color: darkFontGrey, fontFamily: semibold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "${data['p_discription']}",
                      style: TextStyle(color: darkFontGrey),
                    ),
                    //
                    // buttons section
                    const SizedBox(
                      height: 10,
                    ),
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                          itemDetailButtonList.length,
                          (index) => ListTile(
                                title: Text(
                                  itemDetailButtonList[index],
                                  style: const TextStyle(
                                      fontFamily: semibold,
                                      color: darkFontGrey),
                                ),
                                trailing: const Icon(Icons.arrow_forward),
                              )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // products you may like section
                    const Text(
                      productsYouMayLike,
                      style: TextStyle(
                          fontSize: 16, fontFamily: bold, color: darkFontGrey),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: List.generate(
                              6,
                              (index) => Container(
                                    margin: const EdgeInsets.all(8),
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          imgP1,
                                          width: 150,
                                          fit: BoxFit.cover,
                                        ),
                                        const Text(
                                          "Laptop 4GB/64GB",
                                          style: TextStyle(
                                              color: darkFontGrey,
                                              fontFamily: semibold),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "\$600",
                                          style: TextStyle(
                                              color: redColor,
                                              fontFamily: bold,
                                              fontSize: 16),
                                        )
                                      ],
                                    ),
                                  ))),
                    )
                  ],
                ),
              ),
            )),

            // here Deatils page UI completed
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButton(
                  title: "Add to Cart",
                  color: redColor,
                  onPress: () {
                    productController.addToCart(
                        color: data["p_colors"]
                            [productController.colorIndex.value],
                        img: data['p_images'][0],
                        qty: productController.quantityIndex.value,
                        sellerName: data['p_name'],
                        tPrice: productController.totalPrice.value,
                        title: data['p_name']);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Added To cart")));
                  },
                  textColor: whiteColor),
            )
          ],
        ),
      ),
    );
  }
}
