import 'package:catalog/models/product_model.dart';
import 'package:catalog/utils/state.dart';
import 'package:flutter/material.dart';
import 'package:gluestack_ui/gluestack_ui.dart';
import 'package:intl/intl.dart';

class CartProductCard extends StatelessWidget {
  final ProductModel productModel;

  const CartProductCard({
    super.key,
    required this.productModel,
  });

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'HI');

    return GSBox(
      style: GSStyle(
        bg: $GSColors.backgroundDark100,
        borderRadius: 4,
        margin: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
      ),
      child: GSHStack(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Image -------------------------
          GSHStack(
            space: GSHstackSpaces.$lg,
            children: [
              GSImage(
                  borderRadius: GSImageRadius.$sm,
                  style: GSStyle(width: 80, height: 80),
                  fit: BoxFit.cover,
                  path: productModel.imageUrl ??
                      'https://placehold.co/250x250?text=Error',
                  imageType: GSImageType.network),
              // Prod Text Descr----------------------
              GSVStack(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GSText(
                    overflow: TextOverflow.ellipsis,
                    text: productModel.name ?? 'N/A',
                    bold: true,
                  ),
                  GSText(
                    text: 'Size : ${productModel.size ?? 'N/A'}',
                    style: GSStyle(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: $GSColors.textLight500,
                      ),
                    ),
                  ),
                  GSHStack(
                    children: [
                      GSText(
                        size: GSSizes.$xs,
                        bold: true,
                        text: '${formatCurrency.format(productModel.price)}',
                      ),
                      GSText(
                        text: ' (${productModel.discount} OFF)',
                        size: GSSizes.$xs,
                        style: GSStyle(
                          textStyle: TextStyle(
                            color: $GSColors.green600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          // Delete and qty counter----------------------
          GSHStack(
            space: MediaQuery.of(context).size.width > 400
                ? GSHstackSpaces.$md
                : GSHstackSpaces.$sm,
            children: [
              GsGestureDetector(
                onPressed: () {
                  cartStateNotifier.removeFromCart(productModel);
                },
                child: GSBox(
                  style: GSStyle(
                    height: 24,
                    width: 24,
                    borderRadius: 2,
                    bg: $GSColors.primary0.withOpacity(0.7),
                  ),
                  child: const GSIcon(
                    icon: Icons.remove,
                  ),
                ),
              ),
              GSText(text: '${productModel.quantity}'),
              GsGestureDetector(
                onPressed: () {
                  cartStateNotifier.addToCart(productModel);
                },
                child: GSBox(
                  style: GSStyle(
                    height: 24,
                    width: 24,
                    borderRadius: 2,
                    bg: $GSColors.primary0.withOpacity(0.7),
                  ),
                  child: const GSIcon(
                    icon: Icons.add,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
