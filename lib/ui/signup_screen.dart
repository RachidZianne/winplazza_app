// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_kundol/blocs/auth/auth_bloc.dart';
import 'package:flutter_kundol/constants/app_data.dart';
import 'package:flutter_kundol/constants/app_styles.dart';
import 'package:flutter_kundol/tweaks/shared_pref_service.dart';
import 'package:flutter_kundol/ui/forgot_screen.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../constants/app_config.dart';
import '../tweaks/app_localization.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final FocusNode focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    TextEditingController signUpFirstNameController = TextEditingController();
    TextEditingController signUpLastNameController = TextEditingController();
    TextEditingController signUpEmailController = TextEditingController();
    TextEditingController signUpPasswordController = TextEditingController();
    TextEditingController signUpConfirmPasswordController =
        TextEditingController();

    return Scaffold(
        body: SafeArea(
      child: BlocConsumer<AuthBloc, AuthState>(
        builder: (context, state) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
                vertical: AppStyles.SCREEN_MARGIN_VERTICAL,
                horizontal: AppStyles.SCREEN_MARGIN_HORIZONTAL),
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(

                children: [

                  const SizedBox(
                    height: 200,
                  ),
                  SizedBox(
                    height: 45,
                    child: TextField(
                      cursorColor: Theme.of(context).brightness == Brightness.dark
                          ? AppStyles.COLOR_GREY_DARK
                          : AppStyles.COLOR_BLACK,
                      style: TextStyle(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppStyles.COLOR_GREY_DARK
                              : AppStyles.COLOR_BLACK,
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          height: 1),
                      autofocus: false,
                      controller: signUpFirstNameController,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color:
                            Theme.of(context).brightness == Brightness.dark
                                ? AppStyles.COLOR_GREY_DARK
                                : AppStyles.COLOR_GREY_LIGHT,
                          ), // Change the color here
                        ),
                        fillColor:
                        Theme.of(context).brightness == Brightness.dark
                            ? AppStyles.COLOR_LITE_GREY_DARK
                            : AppStyles.COLOR_LITE_GREY_LIGHT,
                        labelText: "First Name",
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? AppStyles.COLOR_GREY_DARK
                              : AppStyles.COLOR_BLACK,
                          fontSize: 16,
                        ),
                        hintText: AppLocalizations.of(context)!
                            .translate("First Name"),
                        hintStyle: TextStyle(
                          color: Theme.of(context).brightness ==
                              Brightness.dark
                              ? AppStyles.COLOR_GREY_DARK
                              : AppStyles.COLOR_GREY_LIGHT,
                          fontSize: 14,
                        ),
                        contentPadding: const EdgeInsets.only(top: 3.0),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Icon(
                            Icons.person_outline,
                            color: Theme.of(context).brightness ==
                                Brightness.dark
                                ? AppStyles.COLOR_GREY_DARK
                                : AppStyles.COLOR_BLACK,
                          ),
                        ),

                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  SizedBox(
                    height: 45,
                    child: TextField(

                      cursorColor: Theme.of(context).brightness == Brightness.dark
                          ? AppStyles.COLOR_GREY_DARK
                          : AppStyles.COLOR_BLACK,
                      autofocus: false,
                      controller: signUpLastNameController,
                      decoration: InputDecoration(
                          focusedBorder:  UnderlineInputBorder(
                            borderSide: BorderSide(
                              color:  Theme.of(context).brightness == Brightness.dark
                                  ? AppStyles.COLOR_GREY_DARK
                                  : AppStyles.COLOR_GREY_LIGHT,
                            ), // Change the color here
                          ),

                          // contentPadding: const EdgeInsets.symmetric(
                          //     vertical: 0, horizontal: 0),
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(40),
                          //   borderSide: const BorderSide(
                          //     width: 0,
                          //     style: BorderStyle.none,
                          //   ),
                          // ),
                          fillColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? AppStyles.COLOR_LITE_GREY_DARK
                              : AppStyles.COLOR_LITE_GREY_LIGHT,
                          // filled: true,
                          // border: InputBorder.none,
                          hintText: AppLocalizations.of(context)!
                              .translate("Last Name"),
                          labelText: "Last Name",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? AppStyles.COLOR_GREY_DARK
                                : AppStyles.COLOR_BLACK,
                            fontSize: 16,

                          ),
                          hintStyle: TextStyle(
                            color: Theme.of(context).brightness ==
                                Brightness.dark
                                ? AppStyles.COLOR_GREY_DARK
                                : AppStyles.COLOR_GREY_LIGHT,
                            fontSize: 14,

                            // fontWeight: FontWeight.bold,
                          ),
                          contentPadding: const EdgeInsets.only(top: 3.0),

                          prefixIcon:  Icon(
                            Icons.person_outline,
                            color: Theme.of(context).brightness ==
                                Brightness.dark
                                ? AppStyles.COLOR_GREY_DARK
                                : AppStyles.COLOR_BLACK,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  SizedBox(
                    height: 45,
                    child: TextField(
                        autofocus: false,
                        cursorColor: Theme.of(context).brightness == Brightness.dark
                            ? AppStyles.COLOR_GREY_DARK
                            : AppStyles.COLOR_BLACK,
                        controller: signUpEmailController,
                        decoration: InputDecoration(
                          focusedBorder:  UnderlineInputBorder(
                            borderSide: BorderSide(
                              color:  Theme.of(context).brightness == Brightness.dark
                                  ? AppStyles.COLOR_GREY_DARK
                                  : AppStyles.COLOR_GREY_LIGHT,
                            ), // Change the color here
                          ),
                          // contentPadding: const EdgeInsets.symmetric(
                          //     vertical: 0, horizontal: 0),
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(40),
                          //   borderSide: const BorderSide(
                          //     width: 0,
                          //     style: BorderStyle.none,
                          //   ),
                          // ),
                          fillColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? AppStyles.COLOR_LITE_GREY_DARK
                              : AppStyles.COLOR_LITE_GREY_LIGHT,
                          // filled: true,
                          // border: InputBorder.none,
                          labelText: "Email",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? AppStyles.COLOR_GREY_DARK
                                : AppStyles.COLOR_BLACK,
                            fontSize: 16,
                          ),
                          hintText:
                          AppLocalizations.of(context)!.translate("Email"),
                          hintStyle: TextStyle(
                              color:
                              Theme.of(context).brightness == Brightness.dark
                                  ? AppStyles.COLOR_GREY_DARK
                                  : AppStyles.COLOR_GREY_LIGHT,
                              fontSize: 14),
                          contentPadding: const EdgeInsets.only(top: 3.0),
                          prefixIcon:  Icon(
                            Icons.email_outlined,
                            color: Theme.of(context).brightness ==
                                Brightness.dark
                                ? AppStyles.COLOR_GREY_DARK
                                : AppStyles.COLOR_BLACK,
                          ),
                        )),
                  ),

                  const SizedBox(
                    height: 15.0,
                  ),
                  SizedBox(
                    height: 45,
                    child: TextField(
                        obscureText: true,
                        autofocus: false,
                        cursorColor: Theme.of(context).brightness == Brightness.dark
                            ? AppStyles.COLOR_GREY_DARK
                            : AppStyles.COLOR_BLACK,
                        controller: signUpPasswordController,
                        decoration: InputDecoration(
                          focusedBorder:  UnderlineInputBorder(
                            borderSide: BorderSide(
                              color:  Theme.of(context).brightness == Brightness.dark
                                  ? AppStyles.COLOR_GREY_DARK
                                  : AppStyles.COLOR_GREY_LIGHT,
                            ), // Change the color here
                          ),
                          // contentPadding: const EdgeInsets.symmetric(
                          //     vertical: 0, horizontal: 0),
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(40),
                          //   borderSide: const BorderSide(
                          //     width: 0,
                          //     style: BorderStyle.none,
                          //   ),
                          // ),
                          fillColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? AppStyles.COLOR_LITE_GREY_DARK
                              : AppStyles.COLOR_LITE_GREY_LIGHT,
                          // filled: true,
                          // border: InputBorder.none,
                          labelText: "Password",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? AppStyles.COLOR_GREY_DARK
                                : AppStyles.COLOR_BLACK,
                            fontSize: 16,
                          ),
                          hintText:
                          AppLocalizations.of(context)!.translate("Password"),
                          hintStyle: TextStyle(
                              color:
                              Theme.of(context).brightness == Brightness.dark
                                  ? AppStyles.COLOR_GREY_DARK
                                  : AppStyles.COLOR_GREY_LIGHT,
                              fontSize: 14),

                          contentPadding: const EdgeInsets.only(top: 3.0),
                          prefixIcon:  Icon(
                            Icons.lock_outline,
                            color: Theme.of(context).brightness ==
                                Brightness.dark
                                ? AppStyles.COLOR_GREY_DARK
                                : AppStyles.COLOR_BLACK,
                          ),
                        )),
                  ),

                  const SizedBox(
                    height: 15.0,
                  ),
                  SizedBox(
                    height: 45,
                    child: TextField(
                        cursorColor: Theme.of(context).brightness == Brightness.dark
                            ? AppStyles.COLOR_GREY_DARK
                            : AppStyles.COLOR_BLACK,
                        obscureText: true,
                        autofocus: false,
                        controller: signUpConfirmPasswordController,
                        decoration: InputDecoration(
                          focusedBorder:  UnderlineInputBorder(
                            borderSide: BorderSide(
                              color:  Theme.of(context).brightness == Brightness.dark
                                  ? AppStyles.COLOR_GREY_DARK
                                  : AppStyles.COLOR_GREY_LIGHT,
                            ), // Change the color here
                          ),
                          // contentPadding: const EdgeInsets.symmetric(
                          //     vertical: 0, horizontal: 0),
                          // border: OutlineInputBorder(
                          //   borderRadius: BorderRadius.circular(40),
                          //   borderSide: const BorderSide(
                          //     width: 0,
                          //     style: BorderStyle.none,
                          //   ),
                          // ),
                          fillColor:
                          Theme.of(context).brightness == Brightness.dark
                              ? AppStyles.COLOR_LITE_GREY_DARK
                              : AppStyles.COLOR_LITE_GREY_LIGHT,
                          // filled: true,
                          // border: InputBorder.none,
                          labelText: "First Name",
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? AppStyles.COLOR_GREY_DARK
                                : AppStyles.COLOR_BLACK,
                            fontSize: 16,
                          ),
                          hintText: AppLocalizations.of(context)!
                              .translate("Confirm Password"),
                          hintStyle: TextStyle(
                              color:
                              Theme.of(context).brightness == Brightness.dark
                                  ? AppStyles.COLOR_GREY_DARK
                                  : AppStyles.COLOR_GREY_LIGHT,
                              fontSize: 14),
                          contentPadding: const EdgeInsets.only(top: 3.0),
                          prefixIcon:  Icon(
                            Icons.lock_outline,
                            color: Theme.of(context).brightness ==
                                Brightness.dark
                                ? AppStyles.COLOR_GREY_DARK
                                : AppStyles.COLOR_BLACK,
                          ),
                        )),
                  ),

                  const SizedBox(
                    height: 40.0,
                  ),
                  SizedBox(
                    height: 50.0,
                    width: double.maxFinite,
                    child: ElevatedButton(
                        style: AppConfig.APP_BAR_COLOR == 2
                            ? ButtonStyle(
                          //  backgroundColor: MaterialStateProperty.all(Theme.of(context).primaryColor),
                          //color:Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).brightness == Brightness.dark
                                ? Theme.of(context).primaryColorLight
                                : Colors.black,
                          ),
                          elevation: MaterialStateProperty.all(0),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        )
                            : AppConfig.APP_BAR_COLOR == 1
                            ? ButtonStyle(
                          //  backgroundColor: MaterialStateProperty.all(Theme.of(context).brightness == Brightness.dark ? Colors.black : Colors.black,),
                          //color:Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,
                          //  backgroundColor: MaterialStateProperty.all<Color>(Theme.of(context).brightness == Brightness.dark ? Theme.of(context).primaryColorLight : Theme.of(context).primaryColor,),
                          backgroundColor:
                          MaterialStateProperty.all<Color>(
                            Theme.of(context).brightness ==
                                Brightness.dark
                                ? Theme.of(context).primaryColorLight
                                : Colors.black,
                          ),

                          elevation: MaterialStateProperty.all(0),
                          shape: MaterialStateProperty.all<
                              RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                          ),
                        )
                            : null,
                        onPressed: () {
                          BlocProvider.of<AuthBloc>(context).add(PerformRegister(
                              signUpFirstNameController.text,
                              signUpLastNameController.text,
                              signUpEmailController.text,
                              signUpPasswordController.text,
                              signUpConfirmPasswordController.text));
                        },
                        child: Text(
                          AppLocalizations.of(context)!.translate("Sign Up")!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
        listener: (context, state) async {
          if (state is Authenticated) {
            AppData.user = state.user;
            AppData.accessToken = state.user?.token;
            //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Welcome " + state.user.firstName)));

            final sharedPrefService = await SharedPreferencesService.instance;
            await sharedPrefService.setUserID(state.user!.id!);
            await sharedPrefService.setUserFirstName(state.user!.firstName!);
            await sharedPrefService.setUserLastName(state.user!.lastName!);
            await sharedPrefService.setUserEmail(state.user!.email!);
            await sharedPrefService.setUserToken(state.user!.token!);

            Navigator.pop(context);
          } else if (state is UnAuthenticated) {
            AppData.user = null;
            AppData.accessToken = null;
            Navigator.pop(context);
          } else if (state is EmailSent) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message!)));
          } else if (state is AuthFailed) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.message!)));
          }
        },
      ),

    ));
  }

  // void doGoogleLogin(BuildContext context) {
  //   final FirebaseAuth auth = FirebaseAuth.instance;
  //   final GoogleSignIn googleSignIn = GoogleSignIn();
  //   try {
  //     signInWithGoogle(context, googleSignIn, auth);
  //   } on Exception catch (error) {
  //     print(error);
  //   }
  // }

  // void signInWithGoogle(BuildContext context, GoogleSignIn googleSignIn,
  //     FirebaseAuth auth) async {
  //   final GoogleSignInAccount? googleSignInAccount =
  //       await googleSignIn.signIn();
  //   final GoogleSignInAuthentication googleSignInAuthentication =
  //       await googleSignInAccount!.authentication;
  //   String? accessToken = googleSignInAuthentication.accessToken;
  //
  //   print("Google AccessToken :  $accessToken");
  //
  //   BlocProvider.of<AuthBloc>(context).add(PerformGoogleLogin(accessToken!));
  //
  //   /*final credential = GoogleAuthProvider.credential(
  //     accessToken: googleSignInAuthentication.accessToken,
  //     idToken: googleSignInAuthentication.idToken,
  //   );
  //
  //   UserCredential authResult = await _auth.signInWithCredential(credential);
  //
  //   var _user = authResult.user;
  //   assert(!_user.isAnonymous);
  //   assert(await _user.getIdToken() != null);
  //   User currentUser = _auth.currentUser;
  //   assert(_user.uid == currentUser.uid);
  //   //model.state =ViewState.Idle;
  //   print("User Name: ${_user.displayName}");
  //   print("User Email ${_user.email}");
  //
  //   return await FirebaseAuth.instance.signInWithCredential(credential);*/
  // }

  void signInFB(BuildContext context) async {
    final fb = FacebookLogin();
    final res = await fb.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);
    switch (res.status) {
      case FacebookLoginStatus.success:
        final FacebookAccessToken? accessToken = res.accessToken;
        print('Access token: ${accessToken?.token}');
        final profile = await fb.getUserProfile();
        print('Hello, ${profile?.name}! You ID: ${profile?.userId}');
        final imageUrl = await fb.getProfileImageUrl(width: 100);
        print('Your profile image: $imageUrl');
        final email = await fb.getUserEmail();
        if (email != null) print('And your email is $email');

        BlocProvider.of<AuthBloc>(context)
            .add(PerformFacebookLogin(accessToken!.token));

        print("ACCESS TOKEN = ${accessToken.token}");

        break;
      case FacebookLoginStatus.cancel:
        break;
      case FacebookLoginStatus.error:
        print('Error while log in: ${res.error}');
        break;
    }
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => 35.0;

  @override
  double get maxExtent => 35.0;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
