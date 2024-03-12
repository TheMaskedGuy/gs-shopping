import 'package:catalog/data/products.dart';
import 'package:catalog/screens/cart_page.dart';
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

    final sw = MediaQuery.of(context).size.width;
    final bool isDesktop = sw > 550;

    // print(sw);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 243, 255),
      extendBody: isDesktop ? false : true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: isDesktop
          ? PreferredSize(
              preferredSize: const Size(24, 50),
              child: GSBox(
                style: GSStyle(
                  bg: $GSColors.white,
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                ),
                child: GSHStack(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GSHStack(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      space: GSHstackSpaces.$sm,
                      children: [
                        const GSIcon(
                          icon: Icons.menu,
                          size: GSIconSizes.$xl,
                        ),
                        GSBox(
                          style:
                              GSStyle(bg: $GSColors.blue600, borderRadius: 2),
                          child: GSIcon(
                            icon: Icons.keyboard_double_arrow_up_outlined,
                            style: GSStyle(color: $GSColors.white),
                          ),
                        ),
                        GSBox(
                          style: GSStyle(
                            padding: const EdgeInsets.only(bottom: 2),
                          ),
                          child: const GSText(
                            text: 'gluestack-ui',
                            bold: true,
                          ),
                        ),
                        GSBadge(
                          text: GSBadgeText(
                            ' pro ',
                            style: GSStyle(
                              color: $GSColors.white,
                            ),
                          ),
                          variant: GSBadgeVariants.solid,
                          borderRadius: GSBadgeRadius.$xl,
                          style: GSStyle(bg: $GSColors.black),
                        )
                      ],
                    ),
                    const GSHStack(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      space: GSHstackSpaces.$sm,
                      children: [
                        GSIcon(
                          icon: Icons.search,
                          size: GSIconSizes.$xl,
                        ),
                        GSAvatar(
                          size: GSAvatarSizes.$sm,
                          avatarImage: GSImage(
                            imageType: GSImageType.network,
                            fit: BoxFit.contain,
                            path:
                                'https://rukminim2.flixcart.com/image/850/1000/kufuikw0/poster/q/k/i/small-gojo-satoru-wall-poster-asstore-red77-original-imag7k3egcpcrsvm.jpeg?q=20&crop=false',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          : null,
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
                    margin: EdgeInsets.only(top: 32, bottom: 32),
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
