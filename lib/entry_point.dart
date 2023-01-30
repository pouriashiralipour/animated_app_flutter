import 'dart:math';

import 'package:animate_app/components/animated_bar.dart';
import 'package:animate_app/components/side_bar_menu.dart';
import 'package:animate_app/constants.dart';
import 'package:animate_app/models/rive_assets.dart';
import 'package:animate_app/screens/onboding/home/home_screen.dart';
import 'package:animate_app/utils/rive_utils.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'models/menu_btn.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key});

  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint>
    with SingleTickerProviderStateMixin {
  RiveAssets selectedBottonNavBar = bottomNavBar.first;

  late AnimationController _animationController;
  late Animation<double> animation;
  late Animation<double> scaleAnimation;

  late SMIBool isSideBarClosed;
  bool isMenuClosed = true;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(() {
        setState(() {});
      });

    animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));
    scaleAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: _animationController, curve: Curves.fastOutSlowIn));

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor2,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Stack(
        children: [
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            width: 288,
            left: isMenuClosed ? -288 : 0,
            height: MediaQuery.of(context).size.height,
            child: const SideBarMenu(),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(animation.value - 30 * animation.value * pi / 180),
            child: Transform.translate(
              offset: Offset(animation.value * 265, 0),
              child: Transform.scale(
                  scale: scaleAnimation.value,
                  child: const ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      child: HomeScreen())),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            top: 16,
            left: isMenuClosed ? 0 : 220,
            curve: Curves.fastOutSlowIn,
            child: MenuButton(
              riveOnInit: (artboard) {
                StateMachineController controller =
                    RiveUtils.getRiveContoroller(artboard,
                        stateMachineName: "State Machine");
                isSideBarClosed = controller.findSMI("isOpen") as SMIBool;
                isSideBarClosed.value = true;
              },
              press: () {
                isSideBarClosed.value = !isSideBarClosed.value;
                if (isMenuClosed) {
                  _animationController.forward();
                } else {
                  _animationController.reverse();
                }
                setState(() {
                  isMenuClosed = isSideBarClosed.value;
                });
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Transform.translate(
        offset: Offset(0, 100 * animation.value),
        child: SafeArea(
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
                                            RiveUtils.getRiveContoroller(
                                                artboard,
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
      ),
    );
  }
}
