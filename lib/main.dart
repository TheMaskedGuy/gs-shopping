import 'package:catalog/screens/old_cart_page.dart';
import 'package:catalog/screens/products_landing_page.dart';
import 'package:flutter/material.dart';
import 'package:gluestack_ui/gluestack_ui.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GluestackProvider(
      gluestackCustomConfig: GluestackCustomConfig(
        button: {
          '_text': {
            'fontWeight': '\$normal',
          },
        },
      ),
      gluestackTokenConfig: GluestackTokenConfig(
        gsColorsToken: const GSColorsToken(
          primaryColorsFromBase: Color.fromARGB(255, 124, 58, 237),
          backgroundLight50:
              Color.fromARGB(55, 76, 29, 149) //for outline button hover
          ,
        ),
      ),
      child: const GSApp(
        debugShowCheckedModeBanner: false,
        //TODO: Get the latest gluestack (with gs app fix), then remove!
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: ProductsLandingPage(),
      ),
    );
  }
}
