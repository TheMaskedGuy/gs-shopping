import 'package:catalog/data/user.dart';
import 'package:catalog/models/user_model.dart';
import 'package:catalog/screens/cart_page.dart';
import 'package:catalog/screens/order_page.dart';
import 'package:catalog/screens/wishlist_page.dart';
import 'package:catalog/widgets/desktop_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:gluestack_ui/gluestack_ui.dart';

final user = UserModel.fromJson(userData);

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final bool isDesktop = sw > 550;
    Widget profileMenuTile(
        {required String text,
        required IconData icon,
        Widget? landingPage,
        bool logout = false}) {
      return GsGestureDetector(
        onPressed: () {
          if (logout) {
            showToast(context,
                child: const GSToast(
                  variant: GSToastVariants.solid,
                  action: GSToastActions.info,
                  child: GSVStack(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GSToastTitle(
                        title: "Info",
                      ),
                      GSToastDescription(
                        description: "Logout feature's not implemented yet!",
                      ),
                    ],
                  ),
                ));
            return;
          }
          if (landingPage != null) {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => landingPage));
          }
        },
        child: GSHStack(
          space: GSHstackSpaces.$xl,
          children: [
            GSIcon(icon: icon),
            GSText(text: text),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: isDesktop
          ? desktopTopBar(context)
          : AppBar(
              backgroundColor: $GSColors.primary400,
              centerTitle: false,
              automaticallyImplyLeading: false,
              title: GSText(
                text: 'My Profile',
                style: GSStyle(textStyle: TextStyle(color: $GSColors.white)),
              ),
              leading: GSCenter(
                child: GsGestureDetector(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: GSBox(
                      style: GSStyle(padding: const EdgeInsets.only(left: 5)),
                      child: GSIcon(
                        icon: Icons.arrow_back,
                        style: GSStyle(
                            color: $GSColors.white, iconColor: $GSColors.white),
                      )),
                ),
              ),
              leadingWidth: 20,
            ),
      body: GSCenter(
        child: GSBox(
          style: isDesktop
              ? GSStyle(
                  width: sw / 1.3,
                  margin:
                      const EdgeInsets.only(top: 32, bottom: 32, left: 16, right: 16),
                )
              : null,
          child: GSScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            children: [
              isDesktop
                  ? GSBox(
                      style: GSStyle(
                        padding: const EdgeInsets.only(bottom: 8),
                      ),
                      child: GSHStack(
                        space: GSHstackSpaces.$sm,
                        children: [
                          GsGestureDetector(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: GSBox(
                                style: GSStyle(
                                    padding: const EdgeInsets.only(left: 5)),
                                child: const GSIcon(
                                  icon: Icons.arrow_back,
                                )),
                          ),
                          GSText(
                            text: 'My Profile',
                            style: GSStyle(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              GSBox(
                style: GSStyle(
                    bg: $GSColors.white,
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 15)),
                child: GSVStack(
                  space: GSVstackSpaces.$3xl,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GSAvatar(
                      size: GSAvatarSizes.$2xl,
                      avatarImage: GSImage(
                          path: user.url!, imageType: GSImageType.network),
                      fallBackText: GSAvatarFallBackText(user.name ?? 'N/A'),
                      avatarBadge: const GSAvatarBadge(),
                    ),
                    GSVStack(
                      children: [
                        GSHStack(
                          mainAxisAlignment: MainAxisAlignment.center,
                          space: GSHstackSpaces.$sm,
                          children: [
                            GSText(
                              text: user.name ?? 'N/A',
                              size: GSSizes.$2xl,
                              bold: true,
                            ),
                            GSIcon(
                              icon: Icons.mode_edit_outlined,
                              style: GSStyle(
                                color: $GSColors.blueGray500,
                              ),
                            ),
                          ],
                        ),
                        const GSText(
                          text: 'gojo@jjk.society' ?? 'N/A',
                          size: GSSizes.$md,
                        ),
                      ],
                    ),
                    GSBox(
                      style: GSStyle(
                          bg: !isDesktop
                              ? $GSColors.primary0.withOpacity(0.15)
                              : null,
                          borderRadius: 8,
                          padding: const EdgeInsets.all(10)),
                      child: GSBox(
                        style: GSStyle(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                        ),
                        child: GSVStack(
                          space: GSVstackSpaces.$lg,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            profileMenuTile(
                                text: 'Orders',
                                icon: Icons.shopping_bag_rounded,
                                landingPage: const OrderPage()),
                            const GSDivider(),
                            profileMenuTile(
                                text: 'Wishlist',
                                icon: Icons.favorite,
                                landingPage: const WishListPage()),
                            const GSDivider(),
                            profileMenuTile(
                                text: 'Cart',
                                icon: Icons.shopping_cart,
                                landingPage: const CartPage()),
                            const GSDivider(),
                            profileMenuTile(
                              text: 'Logout',
                              icon: Icons.logout_rounded,
                              logout: true,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
