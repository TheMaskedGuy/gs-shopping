import 'package:catalog/data/products.dart';
import 'package:catalog/screens/cart_page.dart';
import 'package:catalog/screens/profile_page.dart';
import 'package:catalog/screens/wishlist_page.dart';
import 'package:catalog/utils/state.dart';
import 'package:catalog/widgets/desktop_top_bar.dart';
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

    final sw = MediaQuery.of(context).size.width;
    final bool isDesktop = sw > 550;

    // print(sw);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 243, 255),
      extendBody: isDesktop ? false : true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: isDesktop ? desktopTopBar(context) : null,
      floatingActionButton: isDesktop
          ? null
          : GSBox(
              style: GSStyle(
                margin:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                bg: $GSColors.primary0.withBlue(230).withOpacity(0.9),
                borderRadius: 23,
              ),
              child: GSHStack(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  navButton(
                      icon: Icons.person, landingPage: const ProfilePage()),
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
        child: GSCenter(
          child: GSBox(
            style: isDesktop
                ? GSStyle(
                    borderRadius: 4,
                    width: isDesktop ? sw / 1.3 : null,
                    bg: Colors.white,
                    margin: const EdgeInsets.only(top: 32, bottom: 32),
                  )
                : null,
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              padding: isDesktop
                  ? const EdgeInsets.all(40)
                  : const EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: getRespValue<int>(
                      buildContext: context,
                      xsValue: 1,
                      xsUpperBound: 355,
                      smValue: 2,
                      mdValue: 2,
                      lgValue: 3,
                      xlValue: 5,
                    ) ??
                    4,
                childAspectRatio: getRespValue<double>(
                      buildContext: context,
                      xsValue: 0.6,
                      smValue: 0.65,
                      lgValue: 0.75,
                      xlValue: 0.7,
                    ) ??
                    0.65,
              ),
              itemCount: productsData.length,
              itemBuilder: (context, index) {
                return ProductCard(
                  productModel: productsDB[index],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
