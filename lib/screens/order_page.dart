import 'package:catalog/utils/state.dart';
import 'package:catalog/widgets/desktop_top_bar.dart';
import 'package:catalog/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:gluestack_ui/gluestack_ui.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;

    final bool isDesktop = sw > 550;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 243, 255),
      appBar: isDesktop
          ? desktopTopBar(context)
          : AppBar(
              backgroundColor: $GSColors.primary400,
              centerTitle: false,
              automaticallyImplyLeading: false,
              title: GSText(
                text: 'My Orders',
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
      body: GSCenter(
        child: GSBox(
          style: isDesktop
              ? GSStyle(
                  width: sw / 1.3,
                  margin: const EdgeInsets.only(
                      top: 32, bottom: 32, left: 16, right: 16),
                )
              : null,
          child: GSScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                                    padding: const EdgeInsets.only(left: 5)),
                                child: const GSIcon(
                                  icon: Icons.arrow_back,
                                )),
                          ),
                          GSText(
                            text: 'My Orders',
                            style: GSStyle(
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox.shrink(),
              GSBox(
                style: isDesktop
                    ? GSStyle(
                        bg: $GSColors.white,
                        width: double.infinity,
                        borderWidth: 4,
                        padding: EdgeInsets.symmetric(
                          horizontal: sw / 14,
                          vertical: 10,
                        ),
                      )
                    : null,
                child: ListenableBuilder(
                  listenable: orderStateNotifier,
                  builder: (context, child) {
                    if (orderStateNotifier.orders.isEmpty) {
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
                              text:
                                  'No orders found!\nOrder items to get started...',
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    }
                    return GSVStack(
                      children: [
                        for (int i = 0;
                            i < orderStateNotifier.orderListLength;
                            i++)
                          OrderCard(order: orderStateNotifier.orders[i]),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
