import 'package:catalog/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:gluestack_ui/gluestack_ui.dart';
import 'package:intl/intl.dart';

class WishListCard extends StatelessWidget {
  final ProductModel productModel;
  final VoidCallback removeFunction;
  const WishListCard(
      {super.key, required this.productModel, required this.removeFunction});

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'HI');

    return GSBox(
      style: GSStyle(
        margin: const EdgeInsets.all(4),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        borderRadius: 4,
        bg: $GSColors.primary0.withAlpha(70),
        sm: GSStyle(bg: $GSColors.primary0.withOpacity(0.08)),
      ),
      child: GSVStack(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
// ---- 1st main child ---------

          //-----  Images ---------
          Expanded(
            child: GSImage(
              borderRadius: GSImageRadius.$md,
              // size: GSImageSizes.$xl,
              style: GSStyle(height: 160, width: 179),
              fit: BoxFit.cover,
              imageType: GSImageType.network,
              path: productModel.imageUrl!,
            ),
          ),
// ---- 2nd main child ---------
          GSVStack(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //----- Rating Stuff ---------
              GSHStack(
                space: GSHstackSpaces.$xs,
                children: [
                  GSIcon(
                    icon: Icons.star_outline,
                    style: GSStyle(color: $GSColors.amber500),
                  ),
                  GSHStack(
                    space: GSHstackSpaces.$xs,
                    children: [
                      GSText(text: '${productModel.rating}'),
                      GSText(text: '(${productModel.ratedBy})'),
                    ],
                  )
                ],
              ),
              //----- Title ---------
              GSText(text: '${productModel.name}'),
              //----- Meta Descr Category --------
              GSText(text: '${productModel.meta}'),
            ],
          ),
          //----- Price and Wishlist--------
          GSHStack(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GSText(text: formatCurrency.format(productModel.price)),
              //TODO: Get icon button fix (GS) and resolve with that in future
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GsGestureDetector(
                  onPressed: removeFunction,
                  child: GSIcon(
                    icon: Icons.favorite,
                    style: GSStyle(color: $GSColors.primary400),
                  ),
                ),
              )
            ],
          ),
          // ---- 3rd main child ---------
          GSCenter(
            child: GSBox(
              style: GSStyle(
                padding: const EdgeInsets.only(top: 6),
                // width: double.infinity, //TODO: FIx this after button bug fix
              ),
              child: GSButton(
                  variant: GSButtonVariants.outline,
                  child: const GSButtonText(text: '+ Add to cart'),
                  onPressed: () {
                    // cartStateNotifier.addToCart(productModel);
                  }),
            ),
          )
        ],
      ),
    );
  }
}
