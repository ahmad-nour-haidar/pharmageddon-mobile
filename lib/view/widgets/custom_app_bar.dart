import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/constant/app_color.dart';
import 'package:pharmageddon_mobile/core/constant/app_strings.dart';
import 'package:pharmageddon_mobile/core/constant/app_svg.dart';
import 'package:pharmageddon_mobile/core/functions/functions.dart';
import 'package:pharmageddon_mobile/core/functions/navigator.dart';
import 'package:pharmageddon_mobile/core/resources/app_text_theme.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/data/remote/auth_data.dart';
import 'package:pharmageddon_mobile/routes.dart';
import 'package:pharmageddon_mobile/view/widgets/svg_image.dart';

import 'custom_popup_menu_button.dart';

class CustomAppBar {
  const CustomAppBar({
    this.title = '',
    this.showArrowBack = true,
    this.showOptions = false,
    this.showSearch = false,
    this.showLogout = false,
    this.showCart = false,
    this.showOrders = false,
    this.showFavorites = false,
    this.showReports = false,
  });

  final String title;
  final bool showArrowBack;
  final bool showOptions;
  final bool showSearch;
  final bool showCart;
  final bool showOrders;
  final bool showFavorites;
  final bool showReports;
  final bool showLogout;

  AppBar build() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColor.transparent,
      centerTitle: true,
      leading: showArrowBack
          ? Builder(builder: (context) {
              return IconButton(
                onPressed: () => Navigator.pop(context),
                icon: SvgPicture.asset(
                    isEnglish() ? AppSvg.arrowLeft : AppSvg.arrowRight),
              );
            })
          : null,
      title: AutoSizeText(
        title,
        style: AppTextTheme.f20w600black,
        maxLines: 1,
      ),
      actions: [
        if (showSearch)
          Builder(builder: (context) {
            return IconButton(
              onPressed: () => pushNamed(AppRoute.search, context),
              icon: SvgPicture.asset(AppSvg.search),
            );
          }),
        if (showLogout)
          Builder(builder: (context) {
            return IconButton(
              onPressed: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.error,
                  title: AppStrings.logOut.tr,
                  desc: AppStrings.doYouWantToLogOut.tr,
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {
                    AppInjection.getIt<AuthRemoteData>().logout();
                    pushNamedAndRemoveUntil(AppRoute.login, context);
                  },
                ).show();
              },
              icon: const SvgImage(
                path: AppSvg.exit,
                color: AppColor.black,
                size: 20,
              ),
            );
          }),
        if (showOptions)
          CustomPopupMenuButton(
            showCart: showCart,
            showOrders: showOrders,
            showFavorites: showFavorites,
            showReports: showReports,
            showLogout: showLogout,
          ),
      ],
    );
  }
}
