// import 'package:catalog/data/products.dart';
// import 'package:catalog/models/product_model.dart';
// import 'package:catalog/widgets/cart_product_card_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:gluestack_ui/gluestack_ui.dart';

// class CartLandingPage extends StatelessWidget {
//   const CartLandingPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // const double hPadding = 400;
//     final double coreCardWidth = MediaQuery.of(context).size.width > 500
//         ? MediaQuery.of(context).size.width / 1.5
//         : MediaQuery.of(context).size.width;
//     print(MediaQuery.of(context).size.width);
//     const double hSpace = 10;

//     return Scaffold(
//       backgroundColor: const Color.fromARGB(255, 245, 243, 255),
//       //Main Center Widget ============================
//       body: GSScrollView(
//         physics: const BouncingScrollPhysics(),
//         padding:
//             EdgeInsets.symmetric(horizontal: coreCardWidth / 4, vertical: 35),
//         children: [
//           GSVStack(
//             space: GSVstackSpaces.$lg,
//             children: [
//               GSHStack(
//                 children: [
//                   GsGestureDetector(
//                       onPressed: () {
//                         print('back to cart!');
//                       },
//                       child: const GSIcon(icon: Icons.arrow_back)),
//                   GSBox(
//                       style: GSStyle(padding: const EdgeInsets.only(left: 7)),
//                       child: const GSText(text: 'My Cart'))
//                 ],
//               ),
//               //Top card ----------------------------------
//               GSBox(
//                 style: GSStyle(
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
//                   sm: GSStyle(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 10, horizontal: 15),
//                   ),
//                   md: GSStyle(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 20, horizontal: 70),
//                   ),
//                   lg: GSStyle(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 20, horizontal: 80),
//                   ),
//                   bg: $GSColors.white,
//                   borderRadius: 6,
//                   width: coreCardWidth,
//                 ),
//                 child: GSVStack(
//                   children: [
//                     for (int i = 0; i < 3; i++)
//                       GSVStack(
//                         children: [
//                           CartProductCard(
//                             productModel: ProductModel.fromJson(
//                               productsData[i],
//                             ),
//                           ),
//                           i != 2 ? const GSDivider() : const SizedBox.shrink(),
//                         ],
//                       ),
//                     const GSHStack(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         GSText(
//                           text: 'Order Details (3 items)',
//                         ),
//                       ],
//                     ),
//                     GSBox(
//                       style: GSStyle(
//                         padding: const EdgeInsets.symmetric(vertical: 20),
//                       ),
//                       child: const GSDivider(),
//                     ),
//                     //----------------- Price Breakup -----------------------------
//                     const GSVStack(
//                       space: GSVstackSpaces.$md,
//                       children: [
//                         GSHStack(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             GSText(text: 'Total MRP'),
//                             GSText(text: '3,561.00'),
//                           ],
//                         ),
//                         GSHStack(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             GSText(text: 'Discount MRP'),
//                             GSText(text: '-214.00'),
//                           ],
//                         ),
//                         GSHStack(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             GSText(text: 'Coupon Discount'),
//                             GSText(text: 'Apply Coupon'),
//                           ],
//                         ),
//                         GSHStack(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             GSText(text: 'Shipping'),
//                             GSText(text: 'Rs. ̶9̶9̶ ̶ Free'),
//                           ],
//                         ),
//                       ],
//                     ),
//                     GSBox(
//                       style: GSStyle(
//                         padding: const EdgeInsets.symmetric(vertical: 20),
//                       ),
//                       child: const GSDivider(),
//                     ),
//                     const GSHStack(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         GSText(
//                           text: 'Total Amount',
//                         ),
//                         GSText(
//                           text: '3433.00',
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               //Spacer
//               // GSBox(
//               //   style: GSStyle(height: 30),
//               // ),
//               //Bottom card --------------------------------
//               GSBox(
//                 style: GSStyle(
//                   width: coreCardWidth,
//                   padding:
//                       const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
//                   sm: GSStyle(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 10, horizontal: 15),
//                   ),
//                   md: GSStyle(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 20, horizontal: 70),
//                   ),
//                   lg: GSStyle(
//                     padding: const EdgeInsets.symmetric(
//                         vertical: 20, horizontal: 80),
//                   ),
//                   bg: $GSColors.white,
//                   borderRadius: 6,
//                 ),
//                 child: GSVStack(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   space: GSVstackSpaces.$md,
//                   children: [
//                     //1st row--------

//                     GSHStack(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const GSText(text: 'Delivery Address'),
//                         GSText(
//                           text: 'Change',
//                           size: GSSizes.$sm,
//                           style: GSStyle(
//                             textStyle: TextStyle(color: $GSColors.primary400),
//                           ),
//                         ),
//                       ],
//                     ),
//                     //2nd row--------
//                     GSVStack(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       space: GSVstackSpaces.$xs,
//                       children: [
//                         GSText(
//                           text: 'Megan Smith',
//                           size: GSSizes.$sm,
//                           bold: true,
//                           style: GSStyle(
//                               textStyle: TextStyle(
//                             color: $GSColors.textLight700,
//                           )),
//                         ),
//                         const GSText(
//                           text: '606-249664 Copper Field,',
//                           size: GSSizes.$sm,
//                         ),
//                         const GSText(
//                           text: 'Street Roseville, NH 349101',
//                           size: GSSizes.$sm,
//                         ),
//                       ],
//                     ),
//                     //3rd Row-------
//                     GSVStack(
//                       //Even box does not work.
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         GSButton(
//                             child: GSButtonText(
//                               text: 'PLACE ORDER',
//                               style: GSStyle(
//                                   textStyle: const TextStyle(
//                                       fontWeight: FontWeight.w300)),
//                             ),
//                             onPressed: () {
//                               print('Placing Order!');
//                             }),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
