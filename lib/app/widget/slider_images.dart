import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../utils/colors.dart';

class SliderImages extends StatefulWidget {
  final List<String> slider;

  // final bool showFraction;
  final bool largeHeight;

  const SliderImages({
    super.key,
    required this.slider,
    // required this.showFraction,
    this.largeHeight = false,
  });

  @override
  State<SliderImages> createState() => _SliderImagesState();
}

class _SliderImagesState extends State<SliderImages> {
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
            items:
                widget.slider
                    .map(
                      (e) => Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(
                          e,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox();
                          },
                        ),
                      ),
                    )
                    .toList(),
            options: CarouselOptions(
              // height: 300,
              onPageChanged: (index, reason) {
                setState(() {
                  activeIndex = index;
                });
              },
              autoPlay: widget.slider.length > 1 ? true : false,
              enlargeCenterPage: widget.slider.length > 1 ? true : true,
              disableCenter: true,
              viewportFraction: widget.slider.length > 1 ? 0.8 : 0.95,
              aspectRatio: 12 / 5,
            ),
          ),
          const SizedBox(height: 10),
          AnimatedSmoothIndicator(
            activeIndex: activeIndex,
            count: widget.slider.length,
            effect: ExpandingDotsEffect(
              activeDotColor: AppColors.primary,
              dotColor: AppColors.grey,
              dotHeight: 8,
              dotWidth: 8,
            ),
          ),
        ],
      ),
    );
  }
}
