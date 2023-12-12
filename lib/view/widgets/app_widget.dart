import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pharmageddon_mobile/core/constant/app_size.dart';
import 'package:pharmageddon_mobile/view/widgets/svg_image.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/app_lottie.dart';
import '../../core/constant/app_svg.dart';
import '../../core/enums/order_status.dart';
import '../../core/functions/functions.dart';
import '../../model/order_model.dart';

class AppWidget {
  final noData = Center(
    child: Lottie.asset(AppLottie.noData,
        width: 180, height: 210, fit: BoxFit.fill),
  );

  final noDataAfterSearch = Center(
    child: Lottie.asset(AppLottie.noDataAfterSearch,
        width: 180, height: 210, fit: BoxFit.fill),
  );

  final addFav = Center(
    child: Lottie.asset(AppLottie.addFav,
        width: 180, height: 210, fit: BoxFit.fill),
  );

  final reports = Center(
    child: Lottie.asset(
      AppLottie.reports,
      width: AppSize.width * .75,
      height: AppSize.width * .75,
      fit: BoxFit.fill,
    ),
  );

  Widget getOrderIcon(OrderModel model) {
    const s = 20.0;
    if (model.status == OrderStatus.preparing) {
      return Tooltip(
        message: model.status.name.tr,
        child: const SvgImage(
          path: AppSvg.timePast,
          color: AppColor.red,
          size: s,
        ),
      );
    }
    if (model.status == OrderStatus.hasBeenSent) {
      return Tooltip(
        message: model.status.name.tr,
        child: SvgImage(
          path: isEnglish() ? AppSvg.shippingFast : AppSvg.shippingFastLeft,
          color: AppColor.blue,
          size: s,
        ),
      );
    }
    return Tooltip(
      message: model.status.name.tr,
      child: const SvgImage(
        path: AppSvg.checkCircle,
        color: AppColor.green,
        size: s,
      ),
    );
  }
}
