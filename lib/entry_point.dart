import 'package:animate_app/components/animated_bar.dart';
import 'package:animate_app/constants.dart';
import 'package:animate_app/models/rive_assets.dart';
import 'package:animate_app/screens/onboding/home/home_screen.dart';
import 'package:animate_app/utils/rive_utils.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  RiveAssets selectedBottonNavBar = bottomNavBar.first;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: const HomeScreen(),
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 24),
          decoration: BoxDecoration(
            color: backgroundColor2.withOpacity(0.8),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...List.generate(
                  bottomNavBar.length,
                  (index) => GestureDetector(
                        onTap: () {
                          if (bottomNavBar[index] != selectedBottonNavBar) {
                            setState(() {
                              selectedBottonNavBar = bottomNavBar[index];
                            });
                          }
                          bottomNavBar[index].input!.change(true);
                          Future.delayed(const Duration(seconds: 1), () {
                            bottomNavBar[index].input!.change(false);
                          });
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedNavBar(
                              isActive:
                                  bottomNavBar[index] == selectedBottonNavBar,
                            ),
                            SizedBox(
                                width: 36,
                                height: 36,
                                child: Opacity(
                                  opacity: bottomNavBar[index] ==
                                          selectedBottonNavBar
                                      ? 1
                                      : 0.5,
                                  child: RiveAnimation.asset(
                                    bottomNavBar.first.src,
                                    artboard: bottomNavBar[index].artboard,
                                    onInit: (artboard) {
                                      StateMachineController controller =
                                          RiveUtils.getRiveContoroller(artboard,
                                              stateMachineName:
                                                  bottomNavBar[index]
                                                      .stateMachineName);
                                      bottomNavBar[index].input = controller
                                          .findSMI("active") as SMIBool;
                                    },
                                  ),
                                )),
                          ],
                        ),
                      ))
            ],
          ),
        ),
      ),
    );
  }
}
