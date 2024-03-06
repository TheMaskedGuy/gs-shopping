import 'package:catalog/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:gluestack_ui/gluestack_ui.dart';

class CartProductCard extends StatelessWidget {
  final ProductModel productModel;
  final VoidCallback? deleteCallback;
  final VoidCallback? addQty;
  final VoidCallback? subQty;
  final int? qty;
  const CartProductCard({
    super.key,
    required this.productModel,
    this.deleteCallback,
    this.addQty,
    this.subQty,
    this.qty = 0,
  });

  @override
  Widget build(BuildContext context) {
    return GSBox(
      style: GSStyle(
          padding: const EdgeInsets.symmetric(
        vertical: 10,
        // horizontal: 10,
      )),
      child: GSHStack(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Image -------------------------
          GSHStack(
            space: GSHstackSpaces.$lg,
            children: [
              GSImage(
                  borderRadius: GSImageRadius.$sm,
                  style: GSStyle(width: 80, height: 100),
                  fit: BoxFit.fill,
                  path: productModel.imageUrl ??
                      'https://placehold.co/250x250?text=Error',
                  imageType: GSImageType.network),
              // Prod Text Descr----------------------
              GSVStack(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GSText(
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
                  GSText(
                    text:
                        'Delivery by Mon ${productModel.deliveryDate?.toLocal().day ?? 'N/A'}',
                    style: GSStyle(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontSize: 13,
                        color: $GSColors.textLight500,
                      ),
                    ),
                  ),
                  GSHStack(
                    children: [
                      GSText(
                        text: 'Rs. ${productModel.price}',
                        style: GSStyle(
                          textStyle: const TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ),
                      GSText(
                        text: '  ${productModel.discount} off',
                        style: GSStyle(
                          textStyle: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
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
          GSVStack(
            space: GSVstackSpaces.$4xl,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              //--- DELETE ----
              GsGestureDetector(
                onPressed: deleteCallback,
                child: const GSIcon(icon: Icons.delete_outline_outlined),
              ),
              //--- QTY COUNTER ----
              GSHStack(
                space: GSHstackSpaces.$md,
                children: [
                  GSIconButton(
                    size: GSIconButtonSizes.$xs,
                    onPressed: subQty ?? () {},
                    style: GSStyle(bg: $GSColors.primary0),
                    icon: const GSIcon(
                      icon: Icons.remove,
                    ),
                  ),
                  GSText(text: '$qty'),
                  GSIconButton(
                    size: GSIconButtonSizes.$xs,
                    onPressed: addQty ?? () {},
                    style: GSStyle(bg: $GSColors.primary0),
                    icon: const GSIcon(
                      icon: Icons.add,
                      // style: GSStyle(color: $GSColors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
