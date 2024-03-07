import 'package:catalog/data/products.dart';
import 'package:catalog/models/product_model.dart';
import 'package:catalog/screens/cart_page.dart';
import 'package:catalog/screens/old_cart_page.dart';
import 'package:catalog/screens/profile_page.dart';
import 'package:catalog/screens/wishlist_page.dart';
import 'package:catalog/utils/state.dart';
import 'package:catalog/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:gluestack_ui/gluestack_ui.dart';

class ProductsLandingPage extends StatelessWidget {
  const ProductsLandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget navButton({required IconData icon, required Widget landingPage}) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GsGestureDetector(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: GSIcon(icon: icon),
          ),
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => landingPage));
          },
        ),
      );
    }

    // final sw = MediaQuery.of(context).size.width;
    // print(sw);

    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: GSBox(
        style: GSStyle(
          margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          bg: $GSColors.primary0.withBlue(230).withOpacity(0.9),
          borderRadius: 23,
        ),
        child: GSHStack(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            navButton(icon: Icons.person, landingPage: const ProfilePage()),
            navButton(
              icon: Icons.favorite,
              landingPage: const WishListPage(),
            ),
            navButton(
              icon: Icons.shopping_cart,
              landingPage: const CartPage(),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(8),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.55,
          ),
          itemCount: productsData.length,
          itemBuilder: (context, index) {
            return ProductCard(
              productModel: productsDB[index],
            );
          },
        ),
      ),
    );
  }
}
