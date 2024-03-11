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

class CancelOrderPage extends StatefulWidget {
  final OrderModel order;
  const CancelOrderPage({super.key, required this.order});

  @override
  State<CancelOrderPage> createState() => _CancelOrderPageState();
}

class _CancelOrderPageState extends State<CancelOrderPage> {
  Reasons selectedCancelReasonValue = Reasons.one;
  bool prodSelectValue = false;

  @override
  Widget build(BuildContext context) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'HI');
    final ProductModel prod = getProductFromId(widget.order.productId!)!;
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
      backgroundColor: const Color.fromARGB(255, 245, 243, 255),
      bottomNavigationBar: GSBox(
        style: GSStyle(
          padding: const EdgeInsets.all(8),
        ),
        child: GSButton(
          onPressed: () {
            if (prodSelectValue) {
              cancelOrder(context);
            } else {
              cancelOrder(context, showError: true);
            }
          },
          child: const GSButtonText(
            text: 'SUBMIT',
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: $GSColors.primary400,
        centerTitle: false,
        automaticallyImplyLeading: false,
        title: GSText(
          text: 'Request Cancellation',
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
                  style: GSStyle(
                      color: $GSColors.white, iconColor: $GSColors.white),
                )),
          ),
        ),
        leadingWidth: 20,
      ),
      body: GSScrollView(
        physics: const BouncingScrollPhysics(),
        children: [
          GSVStack(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            space: GSVstackSpaces.$xl,
            children: [
              //Top card 1st card-----------------
              GSBox(
                style: GSStyle(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  width: double.infinity,
                  bg: $GSColors.white,
                ),
                child: GSHStack(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GSCheckBox(
                      icon: GSCheckBoxIndicator(
                        style: GSStyle(
                            margin: EdgeInsets.only(right: $GSSpace.$2)),
                        child: const GSCheckBoxIcon(),
                      ),
                      value: "value 1",
                      // label: orderCard, //Can do this too
                      onChanged: (value) {
                        if (value != null) {
                          prodSelectValue = value;
                        }
                      },
                      size: GSCheckBoxSizes.$md,
                    ),
                    Expanded(child: orderCard),
                  ],
                ),
              ),
              GSBox(
                style: GSStyle(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  width: double.infinity,
                  bg: $GSColors.white,
                ),
                child: GSVStack(
                  space: GSVstackSpaces.$lg,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const GSText(
                      text: 'Reason for Cancellation',
                      size: GSSizes.$md,
                    ),

                    //Reasons radio---------------
                    GSRadio<Reasons>(
                      value: Reasons.one,
                      groupValue: selectedCancelReasonValue,
                      onChanged: (p0) {
                        setState(() {
                          selectedCancelReasonValue = p0!;
                        });
                      },
                      icon: const GSRadioIcon<Reasons>(size: GSSizes.$xs),
                      label: Expanded(
                        child: GSRadioText<Reasons>(
                            text: reasons[Reasons.one.index]),
                      ),
                      style: GSStyle(
                        margin: EdgeInsets.only(right: $GSSpace.$2),
                      ),
                    ),
                    GSRadio<Reasons>(
                      value: Reasons.two,
                      groupValue: selectedCancelReasonValue,
                      onChanged: (p0) {
                        setState(() {
                          selectedCancelReasonValue = p0!;
                        });
                      },
                      icon: const GSRadioIcon<Reasons>(),
                      label: Expanded(
                        child: GSRadioText<Reasons>(
                            text: reasons[Reasons.two.index]),
                      ),
                      style: GSStyle(
                        margin: EdgeInsets.only(right: $GSSpace.$2),
                      ),
                    ),
                    GSRadio<Reasons>(
                      value: Reasons.three,
                      groupValue: selectedCancelReasonValue,
                      onChanged: (p0) {
                        setState(() {
                          selectedCancelReasonValue = p0!;
                        });
                      },
                      icon: const GSRadioIcon<Reasons>(),
                      label: Expanded(
                        child: GSRadioText<Reasons>(
                            text: reasons[Reasons.three.index]),
                      ),
                      style: GSStyle(
                        margin: EdgeInsets.only(right: $GSSpace.$2),
                      ),
                    ),
                    GSRadio<Reasons>(
                      value: Reasons.four,
                      groupValue: selectedCancelReasonValue,
                      onChanged: (p0) {
                        setState(() {
                          selectedCancelReasonValue = p0!;
                        });
                      },
                      icon: const GSRadioIcon<Reasons>(),
                      label: Expanded(
                        child: GSRadioText<Reasons>(
                            text: reasons[Reasons.four.index]),
                      ),
                      style: GSStyle(
                        margin: EdgeInsets.only(right: $GSSpace.$2),
                      ),
                    ),
                    GSRadio<Reasons>(
                      value: Reasons.five,
                      groupValue: selectedCancelReasonValue,
                      onChanged: (p0) {
                        setState(() {
                          selectedCancelReasonValue = p0!;
                        });
                      },
                      icon: const GSRadioIcon<Reasons>(),
                      label: Expanded(
                        child: GSRadioText<Reasons>(
                            text: reasons[Reasons.five.index]),
                      ),
                      style: GSStyle(
                        margin: EdgeInsets.only(right: $GSSpace.$2),
                      ),
                    ),
                    GSRadio<Reasons>(
                      value: Reasons.six,
                      groupValue: selectedCancelReasonValue,
                      onChanged: (p0) {
                        setState(() {
                          selectedCancelReasonValue = p0!;
                        });
                      },
                      icon: const GSRadioIcon<Reasons>(),
                      label: Expanded(
                        child: GSRadioText<Reasons>(
                          text: reasons[Reasons.six.index],
                        ),
                      ),
                      style: GSStyle(
                        margin: EdgeInsets.only(right: $GSSpace.$2),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void cancelOrder(BuildContext context, {bool showError = false}) {
    GSAlertDialog.show(
      context,
      size: GSAlertDialogSizes.$md,
      content: GSAlertDialogContent(
        header: GSAlertDialogHeader(
          style: GSStyle(
            bg: showError ? $GSColors.amber400 : $GSColors.primary700,
          ),
          child: GSText(
            text: showError ? 'Warning' : "Cancel Order?",
            bold: true,
            style: GSStyle(textStyle: TextStyle(color: $GSColors.white)),
          ),
        ),
        body: GSAlertDialogBody(
          style: GSStyle(
            bg: $GSColors.white,
          ),
          child: GSText(
              text: showError
                  ? "Please select the product you want to cancel"
                  : "Are you sure you want to cancel this order?"),
        ),
        footer: GSAlertDialogFooter(
          style: GSStyle(bg: $GSColors.backgroundDark0),
          child: showError
              ? GSButton(
                  action: GSButtonActions.primary,
                  style: GSStyle(
                    bg: $GSColors.amber400,
                  ),
                  child: const Text("Okay"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )
              : GSButtonGroup(
                  buttons: [
                    GSButton(
                      action: GSButtonActions.primary,
                      child: const Text("Yes"),
                      onPressed: () {
                        orderStateNotifier.removeOrder(widget.order);
                        Navigator.pop(context);
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
