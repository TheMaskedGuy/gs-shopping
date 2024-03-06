import 'package:catalog/utils/state.dart';
import 'package:catalog/widgets/wishlist_card.dart';
import 'package:flutter/material.dart';
import 'package:gluestack_ui/gluestack_ui.dart';

class WishListPage extends StatefulWidget {
  const WishListPage({super.key});

  @override
  State<WishListPage> createState() => _WishListPageState();
}

class _WishListPageState extends State<WishListPage> {
  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    print(sw);
    ;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: GSVStack(
          children: [
            GSText(text: 'Wishlist'),
            GSText(text: '${cartState.length} items'),
          ],
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.55,
        ),
        itemCount: wishListState.length,
        itemBuilder: (context, index) {
          return WishListCard(
            productModel: wishListState[index],
            removeFunction: () {
              setState(() {
                wishListState.remove(wishListState[index]);
              });
            },
          );
        },
      ),
    );
  }
}
