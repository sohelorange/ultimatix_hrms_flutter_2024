import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'common_app_image.dart';

class CommonCarouselBanner extends StatefulWidget {
  final List<String> images;

  const CommonCarouselBanner({
    super.key,
    required this.images,
  });

  @override
  State<CommonCarouselBanner> createState() => _CommonCarouselBannerState();
}

class _CommonCarouselBannerState extends State<CommonCarouselBanner> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          children: [
            CarouselSlider.builder(
              itemCount: widget.images.isNotEmpty ? widget.images.length : 1,
              options: CarouselOptions(
                height: 70,
                // Adjust height if needed
                autoPlay: widget.images.isNotEmpty,
                enlargeCenterPage: true,
                viewportFraction: 1.0,
                // Full width of the screen
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index; // Update the selected index
                  });
                },
              ),
              itemBuilder: (context, index, realIndex) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CommonAppImage(
                    imagePath: widget.images[index],
                    height: 70,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                );
              },
            ),
            // Indicators Positioned Inside Image
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(widget.images.length, (index) {
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4.0),
                    height: _currentIndex == index ? 6.0 : 4.0,
                    // Adjusted height for selected/unselected
                    width: _currentIndex == index ? 16.0 : 12.0,
                    // Adjusted width for selected/unselected
                    decoration: BoxDecoration(
                      color: _currentIndex == index
                          ? Colors.white.withOpacity(0.8) // Selected color
                          : Colors.white.withOpacity(0.5), // Unselected color
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  );
                }),
              ),
            ),

            // Positioned(
            //   bottom: 10,
            //   left: 0,
            //   right: 0,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: List.generate(widget.images.length, (index) {
            //       return AnimatedContainer(
            //         duration: const Duration(milliseconds: 300),
            //         margin: const EdgeInsets.symmetric(horizontal: 4.0),
            //         height: 8.0,
            //         width: _currentIndex == index ? 16.0 : 8.0,
            //         decoration: BoxDecoration(
            //           color: _currentIndex == index
            //               ? Colors.white.withOpacity(0.8) // Selected color
            //               : Colors.white.withOpacity(0.5), // Unselected color
            //           borderRadius: BorderRadius.circular(8.0),
            //         ),
            //       );
            //     }),
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
