import 'package:catalog/utils/state.dart';
import 'package:catalog/widgets/order_card.dart';
import 'package:flutter/material.dart';
import 'package:gluestack_ui/gluestack_ui.dart';

class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: GSScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        children: [
          ListenableBuilder(
            listenable: orderStateNotifier,
            builder: (context, child) {
              if (orderStateNotifier.orders.isEmpty) {
                return GSCenter(
                  style:
                      GSStyle(height: MediaQuery.of(context).size.height / 1.5),
                  child: const GSVStack(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GSIcon(
                        icon: Icons.warning_rounded,
                        size: GSIconSizes.$xl,
                      ),
                      GSText(
                        text: 'No orders found!\nOrder items to get started...',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              }
              return GSVStack(
                children: [
                  for (int i = 0; i < orderStateNotifier.orderListLength; i++)
                    OrderCard(order: orderStateNotifier.orders[i]),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
