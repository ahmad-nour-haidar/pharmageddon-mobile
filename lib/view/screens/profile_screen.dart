import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pharmageddon_mobile/core/constant/app_padding.dart';
import 'package:pharmageddon_mobile/core/constant/app_strings.dart';
import 'package:pharmageddon_mobile/core/services/dependency_injection.dart';
import 'package:pharmageddon_mobile/view/widgets/custom_app_bar.dart';
import '../../controllers/profile_cubit/profile_cubit.dart';
import '../../controllers/profile_cubit/profile_state.dart';
import '../../core/class/validation.dart';
import '../../core/constant/app_color.dart';
import '../../core/constant/app_size.dart';
import '../../core/constant/app_svg.dart';
import '../../core/functions/functions.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';
import '../widgets/handle_state.dart';
import '../widgets/row_lang.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final radius = AppSize.width * .75 / 2;
    return BlocProvider<ProfileCubit>(
      create: (context) => AppInjection.getIt<ProfileCubit>()..initial(),
      child: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          if (state is ProfileFailureState) {
            handleState(state: state.state, context: context);
          }
        },
        builder: (context, state) {
          final cubit = ProfileCubit.get(context);
          return Scaffold(
            appBar: CustomAppBar(
              title: AppStrings.profile.tr,
              showUserEdit: true,
              onTapEditUser: cubit.onTapEdit,
            ).build(),
            body: Form(
              key: cubit.formKey,
              child: ListView(
                padding: AppPadding.screenPadding,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(radius),
                        child: cubit.imageWidget,
                      ),
                      if (cubit.enableEdit)
                        Positioned(
                          bottom: 15,
                          left: isEnglish() ? 15 : null,
                          right: isEnglish() ? null : 15,
                          child: ClipOval(
                            child: DecoratedBox(
                              decoration: const BoxDecoration(
                                color: AppColor.green, // Button color
                              ),
                              child: InkWell(
                                splashColor: AppColor.transparent,
                                highlightColor: AppColor.transparent,
                                onTap: cubit.pickImage,
                                child: const SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Icon(
                                    size: 20,
                                    Icons.edit,
                                    color: AppColor.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  const Gap(15),
                  CustomTextFormField(
                    enabled: false,
                    controller: cubit.emailController,
                    keyboardType: TextInputType.phone,
                    validator: (_) => null,
                    textInputAction: TextInputAction.next,
                    fillColor: AppColor.white,
                    colorPrefixIcon: AppColor.gray3,
                    prefixIcon: AppSvg.email,
                    hintText: '',
                  ),
                  if (cubit.enableEdit) const Gap(15),
                  CustomTextFormField(
                    enabled: cubit.enableEdit,
                    controller: cubit.phoneController,
                    keyboardType: TextInputType.phone,
                    validator: ValidateInput.isPhone,
                    textInputAction: TextInputAction.next,
                    fillColor: AppColor.white,
                    colorPrefixIcon: AppColor.gray3,
                    prefixIcon: AppSvg.phone,
                    hintText: '',
                  ),
                  if (cubit.enableEdit) const Gap(15),
                  CustomTextFormField(
                    enabled: cubit.enableEdit,
                    controller: cubit.nameController,
                    keyboardType: TextInputType.name,
                    validator: ValidateInput.isUsername,
                    textInputAction: TextInputAction.next,
                    fillColor: AppColor.white,
                    colorPrefixIcon: AppColor.gray3,
                    prefixIcon: AppSvg.user,
                    hintText: '',
                  ),
                  if (cubit.enableEdit) const Gap(15),
                  CustomTextFormField(
                    enabled: cubit.enableEdit,
                    controller: cubit.addressController,
                    keyboardType: TextInputType.text,
                    validator: ValidateInput.isAddress,
                    textInputAction: TextInputAction.next,
                    fillColor: AppColor.white,
                    colorPrefixIcon: AppColor.gray3,
                    prefixIcon: AppSvg.marker,
                    hintText: '',
                  ),
                  const Gap(25),
                  if (state is ProfileLoadingState)
                    const SpinKitThreeBounce(color: AppColor.buttonColor),
                  if (state is! ProfileLoadingState && cubit.enableEdit)
                    CustomButton(
                      onTap: cubit.updateUser,
                      text: AppStrings.edit.tr,
                    ),
                  const Gap(25),
                  const RowLang(),
                  const Gap(40),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
