import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'components/btn_animated.dart';
import 'components/costum_sign_in_dialog.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool isDialogSignInShown = false;
  late RiveAnimationController _btnAnimationController;
  @override
  void initState() {
    _btnAnimationController = OneShotAnimation("active", autoplay: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: <Widget>[
        Positioned(
          width: MediaQuery.of(context).size.width * 1.7,
          bottom: 200,
          left: 100,
          child: Image.asset("assets/Backgrounds/Spline.png"),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 20,
              sigmaY: 10,
            ),
          ),
        ),
        const RiveAnimation.asset("assets/RiveAssets/shapes.riv"),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 30,
              sigmaY: 30,
            ),
            child: const SizedBox(),
          ),
        ),
        AnimatedPositioned(
          top: isDialogSignInShown ? -50 : 0,
          duration: const Duration(milliseconds: 240),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(),
                    SizedBox(
                      width: 260,
                      // ignore: prefer_const_literals_to_create_immutables
                      child: Column(children: [
                        const Text(
                          "Learn design & code",
                          style: TextStyle(
                              fontSize: 60, fontFamily: 'Poppins', height: 1.2),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                            "Don't skip design. Learn design and code, by building real apps with Flutter and Swift. Complete courses about the best tools."),
                      ]),
                    ),
                    const Spacer(
                      flex: 2,
                    ),
                    BtnAnimated(
                      btnAnimationController: _btnAnimationController,
                      press: () {
                        _btnAnimationController.isActive = true;
                        Future.delayed(const Duration(milliseconds: 800), () {
                          setState(() {
                            isDialogSignInShown = true;
                          });
                          customSigningDialog(context, onClosed: (_) {
                            setState(() {
                              isDialogSignInShown = false;
                            });
                          });
                        });
                      },
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                      child: Text(
                          "Purchase includes access to 30+ courses, 240+ premium tutarials, 120+hours of videos, source files and certificates."),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ]),
            ),
          ),
        )
      ]),
    );
  }
}
