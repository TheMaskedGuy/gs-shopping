import 'package:catalog/models/product_model.dart';
import 'package:catalog/models/user_model.dart';
import 'package:catalog/utils/state.dart';
import 'package:flutter/material.dart';
import 'package:gluestack_ui/gluestack_ui.dart';
import 'package:intl/intl.dart';

enum Reasons { one, two, three, four, five, six }

const reasons = [
  'I want to change my phone number',
  'I have changed my mind',
  'I have purchased the product elsewhere',
  'Expected delivery time is very long',
  'I want to change address for the order',
  'I want to cancel due to product quality issues'
];

class TrackOrderPage extends StatelessWidget {
  final OrderModel order;
  const TrackOrderPage({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'HI');
    final ProductModel prod = getProductFromId(order.productId!)!;
    GSBox orderCard = GSBox(
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
        space: GSHstackSpaces.$lg,
        children: [
          //Image -------------------------
          GSImage(
              borderRadius: GSImageRadius.$sm,
              style: GSStyle(width: 80, height: 96),
              fit: BoxFit.cover,
              path: prod.imageUrl ?? 'https://placehold.co/250x250?text=Error',
              imageType: GSImageType.network),
          // Prod Text Descr----------------------
          GSVStack(
            space: GSVstackSpaces.$xs,
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
              GSText(
                size: GSSizes.$xs,
                bold: true,
                text: '${formatCurrency.format(prod.price)}',
              ),
            ],
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: $GSColors.primary400,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: GSText(
          text: 'Track Order',
          style: GSStyle(textStyle: TextStyle(color: $GSColors.white)),
        ),
        leading: GSCenter(
          child: GsGestureDetector(
            onPressed: () {
              Navigator.pop(context);
            },
            child: GSBox(
              style: GSStyle(
                padding: const EdgeInsets.only(left: 5),
              ),
              child: GSIcon(
                icon: Icons.arrow_back,
                style:
                    GSStyle(color: $GSColors.white, iconColor: $GSColors.white),
              ),
            ),
          ),
        ),
        leadingWidth: 20,
      ),
      body: GSScrollView(
        physics: const BouncingScrollPhysics(),
        children: [
          GSBox(
            style: GSStyle(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            ),
            child: GSVStack(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              space: GSVstackSpaces.$xl,
              children: [
                //Top card 1st card-----------------
                orderCard,
                IntrinsicHeight(
                  child: GSHStack(
                    children: [
                      GSBox(
                        style: GSStyle(
                          margin: const EdgeInsets.only(right: 14),
                          width: 3,
                          bg: $GSColors.primary200,
                        ),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: GSBox(
                            style: GSStyle(bg: $GSColors.primary0, height: 115),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: GSVStack(
                          space: GSVstackSpaces.$xl,
                          children: [
                            TextContent(
                              title: 'Order Placed',
                              time: '5:38 pm',
                              body: 'We have recieved your order.',
                            ),
                            TextContent(
                              title: 'Order Packed',
                              time: '5:38 pm',
                              body:
                                  'Seller has processed your order. Our delivery partner has picked your order.',
                            ),
                            Opacity(
                              opacity: 0.4,
                              child: TextContent(
                                title: 'Shipped',
                                body: 'Your order has been shipped.',
                              ),
                            ),
                            Opacity(
                              opacity: 0.4,
                              child: TextContent(
                                title: 'Out for Delivery',
                                body: 'Your order is out for delivery!',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TextContent extends StatelessWidget {
  final String title;
  final String body;
  final String? time;
  const TextContent(
      {super.key, required this.title, required this.body, this.time});

  @override
  Widget build(BuildContext context) {
    return GSVStack(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GSText(
          text: title,
          size: GSSizes.$md,
          style: GSStyle(
            textStyle: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        GSBox(
          style: GSStyle(height: 8),
        ),
        GSText(
          text: body,
          size: GSSizes.$xs,
          style: GSStyle(
            textStyle: TextStyle(color: $GSColors.blueGray500),
          ),
        ),
        time != null
            ? GSText(
                text: time!,
                size: GSSizes.$xs,
                style: GSStyle(
                  textStyle: TextStyle(color: $GSColors.blueGray400),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
