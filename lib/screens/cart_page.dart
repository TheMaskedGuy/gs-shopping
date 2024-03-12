import 'package:catalog/models/product_model.dart';
import 'package:catalog/utils/state.dart';
import 'package:catalog/widgets/cart_product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:gluestack_ui/gluestack_ui.dart';
import 'package:intl/intl.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'HI');
    final sw = MediaQuery.of(context).size.width;
    final mw = sw > 550 ? sw * 0.7 : null;
    final bool isDesktop = sw > 550;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 243, 255),
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
              title: GSText(
                text: 'My Cart',
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
      //Main Center Widget ============================
      body: SafeArea(
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
              physics: const BouncingScrollPhysics(),
              // padding:
              //     EdgeInsets.symmetric(horizontal: coreCardWidth / 4, vertical: 35),
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
                                      padding: const EdgeInsets.only(left: 5)),
                                  child: GSIcon(
                                    icon: Icons.arrow_back,
                                  )),
                            ),
                            GSText(
                              text: 'My Cart',
                              style: GSStyle(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
                ListenableBuilder(
                    listenable: cartStateNotifier,
                    builder: (context, child) {
                      if (cartStateNotifier.cartProducts.isEmpty) {
                        return GSCenter(
                          style: GSStyle(
                              height: MediaQuery.of(context).size.height / 1.5),
                          child: const GSVStack(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              GSIcon(
                                icon: Icons.warning_rounded,
                                size: GSIconSizes.$xl,
                              ),
                              GSText(
                                text: 'Cart is empty\nAdd items to continue!',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      }
                      return GSVStack(
                        // crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,
                        space: GSVstackSpaces.$lg,
                        children: [
                          //Top card 1st card----------------------------------
                          GSBox(
                            style: GSStyle(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              bg: $GSColors.white,
                              borderRadius: 6,
                              width: double.infinity,
                              // width: coreCardWidth,
                            ),
                            child: GSCenter(
                              child: GSBox(
                                style: GSStyle(width: mw),
                                child: GSVStack(
                                  children: [
                                    for (ProductModel prod
                                        in cartStateNotifier.cartProducts)
                                      CartProductCard(
                                        productModel: prod,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          //2nd Card--------------------------------
                          GSBox(
                            style: GSStyle(
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              bg: $GSColors.white,
                              borderRadius: 6,
                              // width: coreCardWidth,
                            ),
                            child: GSCenter(
                              child: SizedBox(
                                width: mw,
                                child: GSVStack(
                                    space: GSVstackSpaces.$xl,
                                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: GSBox(
                                          style: GSStyle(
                                            padding:
                                                const EdgeInsets.only(top: 13),
                                          ),
                                          child: GSText(
                                            text:
                                                'Order Details (${cartStateNotifier.cartProductsCount} items)',
                                            style: GSStyle(
                                                textStyle: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                            )),
                                          ),
                                        ),
                                      ),

                                      //----------------- Price Breakup -----------------------------
                                      GSVStack(
                                        space: GSVstackSpaces.$md,
                                        children: [
                                          GSHStack(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const GSText(
                                                text: 'Total MRP',
                                                size: GSSizes.$sm,
                                              ),
                                              GSText(
                                                size: GSSizes.$sm,
                                                text: formatCurrency.format(
                                                    cartStateNotifier
                                                        .cartPrice),
                                              ),
                                            ],
                                          ),
                                          const GSHStack(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GSText(
                                                text: 'Discount MRP',
                                                size: GSSizes.$sm,
                                              ),
                                              GSText(
                                                text: '0.00',
                                                size: GSSizes.$sm,
                                              ),
                                            ],
                                          ),
                                          GSHStack(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const GSText(
                                                text: 'Coupon Discount',
                                                size: GSSizes.$sm,
                                              ),
                                              GSText(
                                                text: 'Apply Coupon',
                                                size: GSSizes.$sm,
                                                style: GSStyle(
                                                    textStyle: TextStyle(
                                                  color: $GSColors.primary400,
                                                )),
                                              ),
                                            ],
                                          ),
                                          const GSHStack(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GSText(
                                                text: 'Shipping',
                                                size: GSSizes.$sm,
                                              ),
                                              GSText(
                                                text: 'Free',
                                                size: GSSizes.$sm,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const GSDivider(),
                                      GSHStack(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GSText(
                                            text: 'Total Amount',
                                            style: GSStyle(
                                                textStyle: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                            )),
                                          ),
                                          GSText(
                                            text: formatCurrency.format(
                                                cartStateNotifier.cartPrice),
                                          ),
                                        ],
                                      ),
                                    ]),
                              ),
                            ),
                          ),
                          //Spacer
                          // GSBox(
                          //   style: GSStyle(height: 30),
                          // ),
                          //Bottom card 3rd card --------------------------------
                          GSBox(
                            style: GSStyle(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              bg: $GSColors.white,
                              width: double.infinity,
                              borderRadius: 6,
                            ),
                            child: GSCenter(
                              child: GSBox(
                                style: GSStyle(
                                  width: mw,
                                ),
                                child: GSVStack(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  space: GSVstackSpaces.$md,
                                  children: [
                                    //1st row--------

                                    GSHStack(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GSText(
                                          text: 'Select Delivery Address',
                                          style: GSStyle(
                                              textStyle: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                          )),
                                        ),
                                        GSText(
                                          text: 'Change',
                                          size: GSSizes.$sm,
                                          style: GSStyle(
                                            textStyle: TextStyle(
                                                color: $GSColors.primary400),
                                          ),
                                        ),
                                      ],
                                    ),
                                    //2nd row--------
                                    GSVStack(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      space: GSVstackSpaces.$xs,
                                      children: [
                                        GSText(
                                          text: 'Megan Smith',
                                          size: GSSizes.$xs,
                                          bold: true,
                                          style: GSStyle(
                                              textStyle: TextStyle(
                                            color: $GSColors.textLight700,
                                          )),
                                        ),
                                        const GSText(
                                          text: '606-249664 Copper Field,',
                                          size: GSSizes.$sm,
                                        ),
                                        const GSText(
                                          text: 'Roseville NH 11532..',
                                          size: GSSizes.$sm,
                                        ),
                                      ],
                                    ),
                                    //3rd Row-------
                                    GSVStack(
                                      //Even box does not work.
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        GSButton(
                                            child: GSButtonText(
                                              text: 'PLACE ORDER',
                                              style: GSStyle(
                                                  textStyle: const TextStyle(
                                                fontWeight: FontWeight.w300,
                                              )),
                                            ),
                                            onPressed: () {
                                              // print('Placing Order!');
                                              orderStateNotifier.addOrder(
                                                  cartStateNotifier
                                                      .cartProducts);

                                              Navigator.pop(context);
                                              showToast(context,
                                                  child: const GSToast(
                                                    action: GSToastActions
                                                        .attention,
                                                    variant:
                                                        GSToastVariants.solid,
                                                    child: GSText(
                                                        text: 'Order Placed ✅'),
                                                  ));
                                            }),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
