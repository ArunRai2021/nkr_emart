import 'package:flutter/gestures.dart';
import 'package:nkr_e_mart/comoonWidgets/home_button.dart';
import 'package:nkr_e_mart/const/const_list.dart';
import 'package:nkr_e_mart/view/HomeScreen/components/features_button.dart';

import '../../const/consts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(12),
        color: lightGrey,
        width: context.width,
        height: context.height,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                height: 60,
                color: lightGrey,
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: whiteColor,
                      hintText: searchAnything,
                      hintStyle: TextStyle(
                        color: textFeildGrey,
                      )),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 130,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: slidersList.length,
                            dragStartBehavior: DragStartBehavior.start,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                height: 220,
                                width: 260,
                                child: ClipRRect(
                                  clipBehavior: Clip.antiAlias,
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    slidersList[index],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            }),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                              2,
                              (index) => homeButton(
                                  width: context.width / 2.5,
                                  height: context.height * 0.15,
                                  icon: index == 0 ? icTodaysDeal : icFlashDeal,
                                  title: index == 0 ? todayDeal : flashSale))),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 130,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: secondSliderList.length,
                            dragStartBehavior: DragStartBehavior.start,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                height: 220,
                                width: 260,
                                child: ClipRRect(
                                  clipBehavior: Clip.antiAlias,
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    secondSliderList[index],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            }),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                              3,
                              (index) => homeButton(
                                  width: context.width / 3.5,
                                  height: context.height * 0.15,
                                  icon: index == 0
                                      ? icTopCategories
                                      : index == 1
                                          ? icBrands
                                          : icTopSeller,
                                  title: index == 0
                                      ? topCategories
                                      : index == 1
                                          ? brand
                                          : topSellers))),
                      const SizedBox(height: 20),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          featuredCategories,
                          style: TextStyle(
                              color: darkFontGrey,
                              fontSize: 18,
                              fontFamily: semibold),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                            children: List.generate(
                                3,
                                (index) => Column(
                                      children: [
                                        featuredButton(
                                            icon: featuredImages1[index],
                                            title: featuredTitles1[index]),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        featuredButton(
                                            icon: featuredImages2[index],
                                            title: featuredTitles2[index])
                                      ],
                                    )).toList()),
                      ),

                      // featured Product
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.all(12),
                        width: context.width,
                        decoration: const BoxDecoration(color: redColor),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              featuredProduct,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: bold,
                              ),
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
                      // third Swiper
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 130,
                        child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: secondSliderList.length,
                            dragStartBehavior: DragStartBehavior.start,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                height: 220,
                                width: 260,
                                child: ClipRRect(
                                  clipBehavior: Clip.antiAlias,
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    secondSliderList[index],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              );
                            }),
                      ),

                      // all Products Section
                      const SizedBox(
                        height: 20,
                      ),
                      GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 6,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  mainAxisExtent: 300),
                          itemBuilder: (BuildContext, index) {
                            return Container(
                              padding: const EdgeInsets.all(12),
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    imgP5,
                                    width: 200,
                                    height: 200,
                                    fit: BoxFit.cover,
                                  ),
                                  const Spacer(),
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
                            );
                          })
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
