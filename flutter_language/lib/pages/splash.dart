import 'package:flutter/material.dart';
import 'package:flutter_language/pages/main_page.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward().then((_) {
      // Navigate to the home screen after animation completes
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => const MainPage(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              Positioned(
                  top: constraints.maxHeight * 0.0,
                  left: constraints.maxWidth * 0.0,
                  child: Image.asset(
                    "images/1.png",
                  )),
              Positioned(
                  top: constraints.maxHeight * 0.0,
                  left: constraints.maxWidth * 0.49,
                  child: Image.asset(
                    "images/2.png",
                  )),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeTransition(
                      opacity: _animationController,
                      child: Image.asset(
                        "images/logo.png",
                        height: 100,
                        width: 100,
                      ),
                    ),
                    SlideTransition(
                      position: _animation,
                      child: Text(
                        'Translate on the Go',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: constraints.maxWidth * 0.05,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
