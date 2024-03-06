import 'package:catalog/data/products.dart';
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
    // const double hPadding = 400;
    // final double coreCardWidth = MediaQuery.of(context).size.width > 500
    //     ? MediaQuery.of(context).size.width / 1.5
    //     : MediaQuery.of(context).size.width;
    // print(MediaQuery.of(context).size.width);
    // const double hSpace = 10;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 243, 255),
      appBar: AppBar(
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
      body: GSScrollView(
        physics: const BouncingScrollPhysics(),
        // padding:
        //     EdgeInsets.symmetric(horizontal: coreCardWidth / 4, vertical: 35),
        children: [
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
                  space: GSVstackSpaces.$lg,
                  children: [
                    //Top card ----------------------------------
                    GSBox(
                      style: GSStyle(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        sm: GSStyle(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                        ),
                        md: GSStyle(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 70),
                        ),
                        lg: GSStyle(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 80),
                        ),
                        bg: $GSColors.white,
                        borderRadius: 6,
                        // width: coreCardWidth,
                      ),
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

                    //2nd Card--------------------------------
                    GSBox(
                      style: GSStyle(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        sm: GSStyle(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                        ),
                        md: GSStyle(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 70),
                        ),
                        lg: GSStyle(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 80),
                        ),
                        bg: $GSColors.white,
                        borderRadius: 6,
                        // width: coreCardWidth,
                      ),
                      child: GSVStack(
                          space: GSVstackSpaces.$xl,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            GSBox(
                              style: GSStyle(
                                  padding: const EdgeInsets.only(top: 13)),
                              child: GSText(
                                text:
                                    'Order Details (${cartStateNotifier.cartProducts.length} items)',
                                style: GSStyle(
                                    textStyle: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                )),
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
                                      text:
                                          '${formatCurrency.format(cartStateNotifier.cartPrice)}',
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
                                    GSText(
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GSText(
                                  text: 'Total Amount',
                                  style: GSStyle(
                                      textStyle: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  )),
                                ),
                                GSText(
                                  text:
                                      '${formatCurrency.format(cartStateNotifier.cartPrice)}',
                                ),
                              ],
                            ),
                          ]),
                    ),
                    //Spacer
                    // GSBox(
                    //   style: GSStyle(height: 30),
                    // ),
                    //Bottom card --------------------------------
                    GSBox(
                      style: GSStyle(
                        // width: coreCardWidth,
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        sm: GSStyle(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                        ),
                        md: GSStyle(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 70),
                        ),
                        lg: GSStyle(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20, horizontal: 80),
                        ),
                        bg: $GSColors.white,
                        borderRadius: 6,
                      ),
                      child: GSVStack(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        space: GSVstackSpaces.$md,
                        children: [
                          //1st row--------

                          GSHStack(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  textStyle:
                                      TextStyle(color: $GSColors.primary400),
                                ),
                              ),
                            ],
                          ),
                          //2nd row--------
                          GSVStack(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                    print('Placing Order!');
                                  }),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }),
        ],
      ),
    );
  }
}
