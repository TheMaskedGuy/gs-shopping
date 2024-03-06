import 'package:catalog/utils/state.dart';
import 'package:catalog/widgets/wishlist_card.dart';
import 'package:flutter/material.dart';
import 'package:gluestack_ui/gluestack_ui.dart';

class WishListPage extends StatelessWidget {
  const WishListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: $GSColors.primary400,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: GSVStack(
          children: [
            GSText(
              text: 'Wishlist',
              style: GSStyle(textStyle: TextStyle(color: $GSColors.white)),
            ),
            ListenableBuilder(
                listenable: wishlistStateNotifier,
                builder: (context, child) {
                  return GSText(
                    text: '${wishlistStateNotifier.wishListLength} items',
                    style:
                        GSStyle(textStyle: TextStyle(color: $GSColors.white)),
                  );
                }),
          ],
        ),
        leading: GSCenter(
          child: GsGestureDetector(
            onPressed: () {
              Navigator.pop(context);
            },
            child: GSBox(
                style: GSStyle(padding: EdgeInsets.only(left: 5)),
                child: GSIcon(
                  icon: Icons.arrow_back,
                  style: GSStyle(
                      color: $GSColors.white, iconColor: $GSColors.white),
                )),
          ),
        ),
        leadingWidth: 20,
      ),
      body: ListenableBuilder(
          listenable: wishlistStateNotifier,
          builder: (context, child) {
            return GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.55,
              ),
              itemCount: wishlistStateNotifier.wishListLength,
              itemBuilder: (context, index) {
                return WishListCard(
                  productModel: wishlistStateNotifier.wishlistProducts[index],
                  removeFunction: () {
                    wishlistStateNotifier.removeFromWishList(
                        wishlistStateNotifier.wishlistProducts[index]);
                  },
                );
              },
            );
          }),
    );
  }
}
