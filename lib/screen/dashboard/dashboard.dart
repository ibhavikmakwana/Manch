/*
 * BSD 2-Clause License
 *
 * Copyright (c) 2021, Bhavik Makwana
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:manch/screen/dashboard/home/home_screen.dart';
import 'package:manch/screen/dashboard/profile/profile_screen.dart';
import 'package:manch/screen/dashboard/store/dashboard_store.dart';
import 'package:manch/values/app_colors.dart';
import 'package:manch/values/assets.dart';
import 'package:manch/widget/indicator_dot.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({
    Key? key,
  }) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late final DashboardStore _dashboardStore;
  @override
  void initState() {
    super.initState();
    _dashboardStore = DashboardStore();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        controller: _dashboardStore.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          Container(),
          Container(),
          ProfileScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: SvgPicture.asset(SVGs.icPlus,
            colorFilter: ColorFilter.mode(
              AppColors.dark,
              BlendMode.srcIn,
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 8,
        clipBehavior: Clip.antiAlias,
        child: Observer(
          builder: (_) => Container(
            height: 92,
            child: Row(
              children: [
                BottomAppBarItem(
                  svgPath: SVGs.icHome,
                  isSelected: _dashboardStore.selectedBottomNavItem.index == 0,
                  onTap: () {
                    _dashboardStore.switchBottomItem(BottomNavItem.HOME);
                  },
                ),
                BottomAppBarItem(
                  svgPath: SVGs.icSend,
                  isSelected: _dashboardStore.selectedBottomNavItem.index == 1,
                  onTap: () {
                    _dashboardStore.switchBottomItem(BottomNavItem.SEARCH);
                  },
                ),
                BottomAppBarItem(
                  svgPath: SVGs.icMessage,
                  isSelected: _dashboardStore.selectedBottomNavItem.index == 2,
                  onTap: () {
                    _dashboardStore.switchBottomItem(BottomNavItem.MESSAGES);
                  },
                ),
                BottomAppBarItem(
                  svgPath: SVGs.icUser,
                  isSelected: _dashboardStore.selectedBottomNavItem.index == 3,
                  onTap: () {
                    _dashboardStore.switchBottomItem(BottomNavItem.PROFILE);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomAppBarItem extends StatelessWidget {
  final String svgPath;
  final bool isSelected;
  final GestureTapCallback? onTap;

  const BottomAppBarItem({
    Key? key,
    required this.svgPath,
    required this.isSelected,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              colorFilter: ColorFilter.mode(
                isSelected ? Theme.of(context).primaryColor : Theme.of(context).disabledColor,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 8),
            IndicatorDot(
              isSelected: isSelected,
              selectedColor: Theme.of(context).primaryColor,
              unSelectedColor: Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
