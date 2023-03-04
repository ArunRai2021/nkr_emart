import 'package:nkr_e_mart/comoonWidgets/bg_widget.dart';
import 'package:nkr_e_mart/const/const_list.dart';
import 'package:nkr_e_mart/controller/product_controller.dart';
import 'package:nkr_e_mart/view/Category/category_details.dart';
import '../../const/consts.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({Key? key}) : super(key: key);
  ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          "Categories",
          style: TextStyle(color: Colors.white, fontFamily: bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
            scrollDirection: Axis.vertical,
            itemCount: categoryImages.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                mainAxisExtent: 200),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  productController.getSubCategories(categoriesList[index]);
                  Get.to(() => CategoryDetail(title: categoriesList[index]));
                },
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(blurRadius: 1.0, blurStyle: BlurStyle.inner)
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        categoryImages[index],
                        height: 120,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        categoriesList[index],
                        style: const TextStyle(color: darkFontGrey),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    ));
  }
}
