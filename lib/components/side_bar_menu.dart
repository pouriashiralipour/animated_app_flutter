import 'dart:ui';

import 'package:animate_app/components/side_bar_menu_title.dart';
import 'package:animate_app/models/rive_assets.dart';
import 'package:animate_app/utils/rive_utils.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import 'card_info.dart';

class SideBarMenu extends StatefulWidget {
  const SideBarMenu({super.key});

  @override
  State<SideBarMenu> createState() => _SideBarMenuState();
}

class _SideBarMenuState extends State<SideBarMenu> {
  RiveAssets selectedMenu = sideBarTiles.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 288,
        height: double.infinity,
        color: const Color(0xFF17203A),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              const CardInfo(
                subTitle: "programmer",
                title: "pouria.shirali",
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32, bottom: 16, left: 24),
                child: Text(
                  "Browse".toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...List.generate(
                  sideBarTiles.length,
                  (index) => SideMenuTile(
                      menu: sideBarTiles[index],
                      press: () {
                        sideBarTiles[index].input!.change(true);
                        Future.delayed(const Duration(seconds: 1), () {
                          sideBarTiles[index].input!.change(false);
                        });
                      },
                      riveonInit: (artboard) {
                        StateMachineController controller =
                            RiveUtils.getRiveContoroller(artboard,
                                stateMachineName:
                                    sideBarTiles[index].stateMachineName);

                        sideBarTiles[index].input =
                            controller.findSMI("active") as SMIBool;
                      },
                      isActive: selectedMenu == sideBarTiles[index]))
            ],
          ),
        ),
      ),
    );
  }
}


// ...sideBarTiles.map((menu) => SideMenuTile(
//                     isActive: selectedMenu == menu,
//                     menu: menu,
//                     riveonInit: (artboard) {
//                       StateMachineController controller =
//                           RiveUtils.getRiveContoroller(artboard,
//                               stateMachineName: menu.stateMachineName);

//                       menu.input = controller.findSMI("active") as SMIBool;
//                     },
//                     press: () {
//                       menu.input!.change(true);
//                       Future.delayed(const Duration(seconds: 1), () {
//                         menu.input!.change(true);
//                       });
//                       setState(() {
//                         selectedMenu = menu;
//                       });
//                     },
//                   ))