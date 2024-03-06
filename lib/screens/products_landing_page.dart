import 'package:catalog/data/products.dart';
import 'package:catalog/models/product_model.dart';
import 'package:catalog/screens/old_cart_page.dart';
import 'package:catalog/screens/wishlist_page.dart';
import 'package:catalog/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:gluestack_ui/gluestack_ui.dart';

class ProductsLandingPage extends StatelessWidget {
  const ProductsLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    print(sw);
    List<ProductModel> products = List.generate(productsData.length,
        (index) => ProductModel.fromJson(productsData[index]));
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GSBox(
        style: GSStyle(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          bg: $GSColors.white,
          borderRadius: 23,
        ),
        child: const GSHStack(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NavButton(icon: Icons.person, landingPage: CartLandingPage()),
            NavButton(
              icon: Icons.favorite,
              landingPage: WishListPage(),
            ),
            NavButton(
              icon: Icons.shopping_cart,
              landingPage: CartLandingPage(),
            ),
          ],
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.55,
        ),
        itemCount: productsData.length,
        itemBuilder: (context, index) {
          return ProductCard(
            productModel: products[index],
          );
        },
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final IconData icon;
  final Widget landingPage;
  const NavButton({super.key, required this.icon, required this.landingPage});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GsGestureDetector(
        child: GSIcon(icon: icon),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => landingPage));
        },
      ),
    );
  }
}
