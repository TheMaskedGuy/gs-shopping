import 'package:catalog/utils/state.dart';
import 'package:catalog/widgets/desktop_top_bar.dart';
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
          ? desktopTopBar(context)
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
            return SafeArea(
              child: GSCenter(
                child: GSBox(
                  style: isDesktop
                      ? GSStyle(
                          width: sw / 1.3,
                          margin: const EdgeInsets.only(
                              top: 32, bottom: 32, left: 16, right: 16),
                          borderRadius: 4,
                        )
                      : null,
                  child: GSScrollView(
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
                                            padding:
                                                const EdgeInsets.only(left: 5)),
                                        child: const GSIcon(
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
                                          textStyle: const TextStyle(
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
                      if (wishlistStateNotifier.wishlistProducts.isEmpty)
                        GSCenter(
                          style: GSStyle(
                              height: MediaQuery.of(context).size.height / 1.5),
                          child: GSBox(
                            style: isDesktop
                                ? GSStyle(
                                    bg: $GSColors.white,
                                    width: double.infinity,
                                  )
                                : null,
                            child: const GSVStack(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GSIcon(
                                  icon: Icons.warning_rounded,
                                  size: GSIconSizes.$xl,
                                ),
                                GSText(
                                  text:
                                      'Wishlist is empty\n❤️ items to continue!',
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        )
                      else
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
                                productModel: wishlistStateNotifier
                                    .wishlistProducts[index],
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
