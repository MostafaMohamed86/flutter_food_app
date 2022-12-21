import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopping_app/domain/models.dart';
import 'package:shopping_app/presentation/onboarding/viewmodel/onboarding_viewmodel.dart';
import 'package:shopping_app/presentation/resources/color_manager.dart';
import 'package:shopping_app/presentation/resources/constants_manager.dart';
import 'package:shopping_app/presentation/resources/routes_manager.dart';
import 'package:shopping_app/presentation/resources/strings_manager.dart';
import 'package:shopping_app/presentation/resources/values_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});
  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController();
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();

  _bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(
      stream: _viewModel.outputsSliderViewObject,
      builder: (context, snapshot) {
        return _getContentWidget(snapshot.data);
      },
    );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return Scaffold(
        backgroundColor: ColorManager.white,
        appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: AppSize.s0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: ColorManager.white,
              statusBarBrightness: Brightness.dark),
        ),
        body: PageView.builder(
          scrollDirection: Axis.horizontal,
          controller: _pageController,
          itemCount: sliderViewObject.numOfSliders,
          onPageChanged: (index) {
            _viewModel.onPageChanged(index);
          },
          itemBuilder: (context, index) {
            return OnBoardingPage(object: sliderViewObject.sliderObject);
          },
        ),
        bottomSheet: Container(
          color: ColorManager.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes.loginRoute);
                  },
                  child: Text(
                    AppStrings.onBoardingSkip,
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              _getBottomSheetWidget(sliderViewObject)
            ],
          ),
        ),
      );
    }
  }

  Widget _getBottomSheetWidget(SliderViewObject? sliderViewObject) {
    if (sliderViewObject == null) {
      return Container();
    } else {
      return Container(
        color: ColorManager.primary,
        padding:
            const EdgeInsets.only(left: AppPadding.p20, right: AppPadding.p20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                _pageController.animateToPage(_viewModel.goPrevious(),
                    duration: const Duration(
                        microseconds: AppConstants.sliderAnimation),
                    curve: Curves.bounceInOut);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: ColorManager.white,
              ),
            ),
            Wrap(
              children: List.generate(sliderViewObject.numOfSliders, (index) {
                var currentIndex = sliderViewObject.currentIndex;
                return InkWell(
                  onTap: () {
                    _viewModel.onPageChanged(index);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 15),
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: ColorManager.white),
                        color: index == currentIndex
                            ? ColorManager.primary
                            : ColorManager.white),
                  ),
                );
              }),
            ),
            IconButton(
              onPressed: () {
                _pageController.animateToPage(_viewModel.goNext(),
                    duration: const Duration(
                        microseconds: AppConstants.sliderAnimation),
                    curve: Curves.bounceInOut);
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                color: ColorManager.white,
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject object;
  const OnBoardingPage({super.key, required this.object});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: AppSize.s40,
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            object.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppPadding.p8),
          child: Text(
            object.subTitle,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
        const SizedBox(
          height: AppSize.s60,
        ),
        SvgPicture.asset(object.image)
      ],
    );
  }
}
