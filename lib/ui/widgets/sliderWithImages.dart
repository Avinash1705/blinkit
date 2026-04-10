// import 'package:carousel_slider/carousel_slider.dart';
import 'dart:ui';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BasicImageSlider extends StatefulWidget {
  const BasicImageSlider({super.key});

  @override
  State<BasicImageSlider> createState() => _BasicImageSliderState();
}

class _BasicImageSliderState extends State<BasicImageSlider> {
  final PageController _pageController = PageController();

  int _currentIndex = 0;


  final List<String> imageList = [
    // 'assets/images/slider/sppons.jpg',
    // 'assets/images/slider/cup.jpg',
    // 'assets/images/slider/kaddu.jpg',
    'assets/images/slider/banner_sare.jpg',
  ];

  @override
  Widget build(BuildContext context) {

    final CarouselSliderController  _carouselController = CarouselSliderController ();
    
    return Column(
      children: [
        const SizedBox(height: 20),

        // 🖼️ Image Carousel
        CarouselSlider.builder(
          carouselController: _carouselController,
          itemCount: imageList.length,
          itemBuilder: (context, index, realIndex) {
            final imageUrl = imageList[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // background image
                  Image.asset(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),

                  // gradient overlay for better contrast
                  Container(
                    decoration: BoxDecoration(
                      // gradient: LinearGradient(
                      //   colors: [
                      //     Colors.black.withOpacity(0.1),
                      //     Colors.black.withOpacity(0.35),
                      //   ],
                      //   begin: Alignment.topCenter,
                      //   end: Alignment.bottomCenter,
                      // ),
                    ),
                  ),

                  // 🌫️ Frosted glass blur text box
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                        child: Container(
                          color: Colors.white.withOpacity(0.25),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          child: Row(
                            children: const [
                              Icon(Icons.local_fire_department_rounded,
                                  color: Colors.orange, size: 18),
                              SizedBox(width: 6),
                              Text(
                                "Limited Time Offer",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
          options: CarouselOptions(
            height: 230,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.9,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            onPageChanged: (index, reason) {
              setState(() => _currentIndex = index);
            },
          ),
        ),

        const SizedBox(height: 15),

        // 🔘 Dot Indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(imageList.length, (index) {
            bool isActive = _currentIndex == index;
            return GestureDetector(
              onTap: () => _carouselController.animateToPage(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: isActive ? 12 : 8,
                height: isActive ? 12 : 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive
                      ? Colors.orange
                      : Colors.grey.shade400.withOpacity(0.7),
                  boxShadow: isActive
                      ? [
                    BoxShadow(
                      color: Colors.orange.withOpacity(0.4),
                      blurRadius: 6,
                      spreadRadius: 2,
                    )
                  ]
                      : [],
                ),
              ),
            );
          }),
        ),

        const SizedBox(height: 30),

        const Text(
          "Shop trending deals near you!",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
