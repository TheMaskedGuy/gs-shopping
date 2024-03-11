import 'package:catalog/models/product_model.dart';
import 'package:catalog/models/user_model.dart';
import 'package:catalog/screens/cancel_order_page.dart';
import 'package:catalog/screens/track_order_page.dart';
import 'package:catalog/utils/state.dart';
import 'package:flutter/material.dart';
import 'package:gluestack_ui/gluestack_ui.dart';
import 'package:intl/intl.dart';

class OrderCard extends StatelessWidget {
  final OrderModel order;
  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'HI');
    final ProductModel prod = getProductFromId(order.productId!)!;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Image -------------------------
          GSVStack(
            space: GSVstackSpaces.$md,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GSText(
                text: 'Order : #${order.id}',
                size: GSSizes.$sm,
              ),
              GSHStack(
                space: GSHstackSpaces.$lg,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GSImage(
                      borderRadius: GSImageRadius.$sm,
                      style: GSStyle(width: 80, height: 96),
                      fit: BoxFit.cover,
                      path: prod.imageUrl ??
                          'https://placehold.co/250x250?text=Error',
                      imageType: GSImageType.network),
                  // Prod Text Descr----------------------
                  GSVStack(
                    space: GSVstackSpaces.$xs, //TODO: Make do without this
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GSText(
                        overflow: TextOverflow.ellipsis,
                        text: prod.name ?? 'N/A',
                        bold: true,
                      ),
                      GSText(
                        text: '${prod.meta ?? 'N/A'}',
                        style: GSStyle(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 13,
                            color: $GSColors.textLight500,
                          ),
                        ),
                      ),
                      GSText(
                        text: 'Size : ${prod.size ?? 'N/A'}',
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
                            text: '${formatCurrency.format(prod.price)}',
                          ),
                          GSText(
                            text: ' (${prod.discount} OFF)',
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
              GSHStack(
                space: GSHstackSpaces.$md,
                children: [
                  GSButton(
                    size: GSButtonSizes.$xs,
                    child: const GSButtonText(text: 'TRACK ORDER'),
                    onPressed: () {
                      //TODO: Implement this
                      print('Going to track page (TODO)');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TrackOrderPage(order: order)));
                    },
                  ),
                  GSButton(
                    size: GSButtonSizes.$xs,
                    variant: GSButtonVariants.outline,
                    child: const GSButtonText(text: 'CANCEL ORDER'),
                    onPressed: () {
                      // cancelOrder(context);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => CancelOrderPage(order: order),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          // Transit Order status----------------------
          GSText(
            text: order.status ?? 'N/A',
            size: GSSizes.$sm,
            style: GSStyle(
              textStyle: TextStyle(
                  color: order.status!.toLowerCase().contains('deli')
                      ? $GSColors.success400
                      : $GSColors.amber400),
            ),
          ),
        ],
      ),
    );
  }

  void cancelOrder(BuildContext context) {
    GSAlertDialog.show(
      context,
      size: GSAlertDialogSizes.$md,
      content: GSAlertDialogContent(
        header: GSAlertDialogHeader(
          style: GSStyle(
            bg: $GSColors.primary700,
          ),
          child: GSText(
            text: "Cancel Order?",
            bold: true,
            style: GSStyle(textStyle: TextStyle(color: $GSColors.white)),
          ),
        ),
        body: GSAlertDialogBody(
          style: GSStyle(
            bg: $GSColors.white,
          ),
          child:
              const GSText(text: "Are you sure you want to cancel this order?"),
        ),
        footer: GSAlertDialogFooter(
          style: GSStyle(bg: $GSColors.backgroundDark0),
          child: GSButtonGroup(
            buttons: [
              GSButton(
                action: GSButtonActions.primary,
                child: const Text("Yes"),
                onPressed: () {
                  orderStateNotifier.removeOrder(order);
                  Navigator.pop(context);
                },
              ),
              GSButton(
                action: GSButtonActions.secondary,
                child: const Text("No"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
