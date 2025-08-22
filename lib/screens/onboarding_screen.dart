import 'package:flutter/material.dart';
import 'dart:async';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final controller = PageController();
  int index = 0;

  final List<Map<String, dynamic>> onboardingData = [
    {
      "title": "Explore The Best Products",
      "desc":
          "Discover and explore thousands of high-quality products from various categories, and enjoy a fast, simple, and secure checkout process for a convenient shopping experience.",
      "image": "lib/images/shop.PNG",
      "size": 200.0,
    },
    {
      "title": "Fast Delivery",
      "desc":
          "Enjoy lightning-fast delivery services that bring your favorite products right to your doorstep in no time, ensuring convenience and reliability with every order.",
      "image": "lib/images/delivery.PNG",
      "size": 200.0,
    },
    {
      "title": "Chat Support",
      "desc":
          "Our dedicated support team is available 24/7 to provide assistance, answer your questions, and ensure you have a smooth and hassle-free shopping experience anytime you need us.",
      "image": "lib/images/support.PNG",
      "size": 200.0,
    }
  ];

  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (!mounted) return;

      if (index < onboardingData.length - 1) {
        index++;
        controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
        setState(() {});
      } else {
        timer.cancel();
        goToLoginScreen();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void goToLoginScreen() {
    Navigator.pushReplacementNamed(context, '/login_screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                onPageChanged: (i) => setState(() => index = i),
                itemCount: onboardingData.length,
                itemBuilder: (_, i) => _OnboardingCard(data: onboardingData[i]),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                onboardingData.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 8,
                  width: i == index ? 24 : 8,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: i == index
                        ? const Color.fromARGB(255, 33, 109, 39)
                        : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: FilledButton(
                onPressed: goToLoginScreen,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 32, 2, 165),
                  minimumSize: const Size.fromHeight(48),
                ),
                child: Text(
                    index == onboardingData.length - 1 ? 'Get Started' : 'Skip'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const _OnboardingCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            data['image'],
            height: data['size'],
            colorBlendMode: BlendMode.dst,
          ),
          const SizedBox(height: 24),
          Text(
            data['title'],
            textAlign: TextAlign.center,
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Text(
            data['desc'],
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
