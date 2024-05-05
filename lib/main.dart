import 'dart:developer';

import 'package:flutter_kundol/initial_splash_modal.dart';
import 'package:http/http.dart' as http;
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/auth/auth_bloc.dart';
import 'package:flutter_kundol/blocs/banners/banners_bloc.dart';
import 'package:flutter_kundol/blocs/categories/categories_bloc.dart';
import 'package:flutter_kundol/blocs/currency/currency_bloc.dart';
import 'package:flutter_kundol/blocs/filters/filters_bloc.dart';
import 'package:flutter_kundol/blocs/products/products_bloc.dart';
import 'package:flutter_kundol/blocs/wishlist/wishlist_bloc.dart';
import 'package:flutter_kundol/blocs/wishlist_detail/wishlist_detail_bloc.dart';
import 'package:flutter_kundol/models/language_data.dart';
import 'package:flutter_kundol/repos/auth_repo.dart';
import 'package:flutter_kundol/repos/banners_repo.dart';
import 'package:flutter_kundol/repos/categories_repo.dart';
import 'package:flutter_kundol/repos/filters_repo.dart';
import 'package:flutter_kundol/repos/payment_methods_repo.dart';
import 'package:flutter_kundol/blocs/payment_methods/payment_methods_bloc.dart';
import 'package:flutter_kundol/repos/products_repo.dart';
import 'package:flutter_kundol/repos/profile_repo.dart';
import 'package:flutter_kundol/repos/settings_repo.dart';
import 'package:flutter_kundol/blocs/theme/theme_bloc.dart';
import 'package:flutter_kundol/repos/wishlist_repo.dart';
import 'package:flutter_kundol/ui/screens/splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'blocs/profile/update_profile_bloc.dart';
import 'blocs/server_settings/server_settings_bloc.dart';
import 'constants/app_config.dart';
import 'constants/app_data.dart';
import 'constants/app_styles.dart';
import 'models/currency_date.dart';
import 'tweaks/app_localization.dart';
import 'blocs/language/language_bloc.dart';

void main() async {
  //debugPaintSizeEnabled = true;
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId(AppConfig.ONESIGNAL_APP_ID);

  //The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });

  runApp(RestartWidget(
    child: MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          LanguageData languageData = LanguageData();
          languageData.languageName = "English";
          languageData.id = 1;
          languageData.code = "en";

          return LanguageBloc(languageData)..add(LanguageLoadStarted());
        }),
        BlocProvider(
          create: (context) {
            CurrencyData currencyData = CurrencyData();

            currencyData.title = "USD";
            currencyData.currencyId = 1;
            currencyData.code = "\$";

            return CurrencyBloc(currencyData)..add(CurrencyLoadStarted());
          },
        ),
        BlocProvider(create: (context) => ThemeBloc()..add(ThemeLoadStarted())),
        BlocProvider(create: (context) => BannersBloc(RealBannersRepo())),
        BlocProvider(create: (context) => CategoriesBloc(RealCategoriesRepo())),
        BlocProvider(create: (context) => ProductsBloc(RealProductsRepo())),
        BlocProvider(create: (context) => AuthBloc(RealAuthRepo())),
        BlocProvider(
          create: (context) => WishlistProductsBloc(RealWishlistRepo()),
        ),
        BlocProvider(
          create: (context) => WishlistBloc(RealWishlistRepo(),
              BlocProvider.of<WishlistProductsBloc>(context)),
        ),
        BlocProvider(
          create: (context) => FiltersBloc(RealFiltersRepo()),
        ),
        BlocProvider(create: (context) => ProfileBloc(RealProfileRepo())),
        BlocProvider(
            create: (context) => PaymentMethodsBloc(RealPaymentMethodsRepo())),
      ],
      child: MyApp(),
    ),
  ));
}

class RestartWidget extends StatefulWidget {
  const RestartWidget({required this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>()?.restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CurrencyBloc, CurrencyState>(
      builder: (context, currencyState) {
        AppData.currency = currencyState.currency;
        return BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, languageState) {
            AppData.language = languageState.languageData;
            return BlocBuilder<ThemeBloc, ThemeState>(
              //builder: (context, themeState) {
              builder: (context, themeState) {
                return MaterialApp(
                  locale: Locale(languageState.languageData.code!),
                  debugShowCheckedModeBanner: false,
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    AppLocalizations.delegate,
                  ],
                  theme: themeState.themeData,
                  // theme: ThemeData(
                  //   primaryColor: Theme.of(context).brightness == Brightness.dark ? Theme.of(context).scaffoldBackgroundColor :  AppStyles.BOTTUM_NAVIGATION_COLOR,
                  //
                  // ),
                  supportedLocales: AppData.languages,
                  home: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: const SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      systemNavigationBarColor: Colors.black,
                      statusBarIconBrightness: Brightness.dark,
                      systemNavigationBarIconBrightness: Brightness.dark,
                    ),
                    child: InitialSplash(),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

class InitialSplash extends StatefulWidget {
  const InitialSplash({Key? key}) : super(key: key);

  @override
  State<InitialSplash> createState() => _InitialSplashState();
}

class _InitialSplashState extends State<InitialSplash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration.zero,
      () {
        getSplashScreen(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Colors.black,
        ),
      ),
    );
  }

  void getSplashScreen(BuildContext context) async{
   try{
     var res = await http.get(Uri.parse(AppConfig.SPLASH_SCREEN));
     if(res.statusCode == 200){
      var data = InitialSplashModal.fromJson(res.body);
      try{
        String? splashScreen = data.data?.firstWhere((element) => element.key == "splash_screen").value;

        String? appLogo = data.data?.firstWhere((element) => element.key == "site_logo").value;
        app_logo_backend = appLogo??"";
        splash_backend = splashScreen??"";
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (BuildContext context) => BlocProvider(
                  create: (context) =>
                      ServerSettingsBloc(RealServerSettingsRepo()),
                  child:  SplashScreen(splash: splashScreen??""),
                ),));
      }catch (e){
        showSnackbar(context, "Something Went Wrong...");
      }
      // splash_screen
       //site_logo
     }
     else{
       showSnackbar(context, "Something Went Wrong...");
     }
   } catch(e){
     showSnackbar(context, "Something Went Wrong...");
   }

  }

  void showSnackbar(context, String error) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(
      content: Text(error),
      duration: const Duration(days: 1),
    ))
        .closed
        .then((reason) {
      if (reason == SnackBarClosedReason.swipe) showSnackbar(context, error);
    });
  }


}


String app_logo_backend = "";
String splash_backend = "";