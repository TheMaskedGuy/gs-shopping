import 'package:catalog/utils/state.dart';
import 'package:catalog/widgets/wishlist_card.dart';
import 'package:flutter/material.dart';
import 'package:gluestack_ui/gluestack_ui.dart';

class WishListPage extends StatelessWidget {
  const WishListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    final bool isDesktop = sw > 550;

    // print(sw);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 243, 255),
      appBar: isDesktop
          ? PreferredSize(
              preferredSize: const Size(24, 50),
              child: GSBox(
                style: GSStyle(
                    bg: $GSColors.white,
                    padding: const EdgeInsets.symmetric(
                        vertical: 8, horizontal: 32)),
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
                            )),
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
          : AppBar(
              backgroundColor: $GSColors.primary400,
              centerTitle: false,
              automaticallyImplyLeading: false,
              title: GSVStack(
                children: [
                  GSText(
                    text: 'Wishlist',
                    style:
                        GSStyle(textStyle: TextStyle(color: $GSColors.white)),
                  ),
                  ListenableBuilder(
                      listenable: wishlistStateNotifier,
                      builder: (context, child) {
                        return GSText(
                          text: '${wishlistStateNotifier.wishListLength} items',
                          style: GSStyle(
                              textStyle: TextStyle(color: $GSColors.white)),
                        );
                      }),
                ],
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
      body: ListenableBuilder(
          listenable: wishlistStateNotifier,
          builder: (context, child) {
            if (wishlistStateNotifier.wishlistProducts.isEmpty) {
              return GSCenter(
                style:
                    GSStyle(height: MediaQuery.of(context).size.height / 1.5),
                child: const GSVStack(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GSIcon(
                      icon: Icons.warning_rounded,
                      size: GSIconSizes.$xl,
                    ),
                    GSText(
                      text: 'Wishlist is empty\n❤️ items to continue!',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }
            return SafeArea(
              child: GSCenter(
                child: GSBox(
                  style: isDesktop
                      ? GSStyle(
                          width: sw / 1.3,
                          margin: EdgeInsets.only(
                              top: 32, bottom: 32, left: 16, right: 16),
                        )
                      : null,
                  child: GSScrollView(
                    children: [
                      isDesktop
                          ? GSBox(
                              style: GSStyle(
                                padding: EdgeInsets.only(bottom: 8),
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
                                            padding:
                                                const EdgeInsets.only(left: 5)),
                                        child: GSIcon(
                                          icon: Icons.arrow_back,
                                        )),
                                  ),
                                  GSVStack(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GSText(
                                        text: 'Wishlist',
                                        style: GSStyle(
                                          textStyle: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      ListenableBuilder(
                                        listenable: wishlistStateNotifier,
                                        builder: (context, child) {
                                          return GSText(
                                            text:
                                                '${wishlistStateNotifier.wishListLength} items',
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : const SizedBox.shrink(),
                      GSBox(
                        style: isDesktop
                            ? GSStyle(
                                borderRadius: 4,
                                bg: Colors.white,
                              )
                            : null,
                        child: GridView.builder(
                          shrinkWrap: true,
                          padding: isDesktop
                              ? const EdgeInsets.all(40)
                              : const EdgeInsets.all(8),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
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
                                  smValue: 0.55,
                                  lgValue: 0.65,
                                  xlValue: 0.6,
                                ) ??
                                0.65,
                          ),
                          itemCount: wishlistStateNotifier.wishListLength,
                          itemBuilder: (context, index) {
                            return WishListCard(
                              productModel:
                                  wishlistStateNotifier.wishlistProducts[index],
                              removeFunction: () {
                                wishlistStateNotifier.removeFromWishList(
                                    wishlistStateNotifier
                                        .wishlistProducts[index]);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }
}
