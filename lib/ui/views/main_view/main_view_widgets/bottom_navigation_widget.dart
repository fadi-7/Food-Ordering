import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_orders_proj/app/core/enums/bottom_navigation.dart';
import 'package:food_orders_proj/ui/shared/colors.dart';

class BottomNavigationWidget extends StatefulWidget {
  const BottomNavigationWidget(
      {super.key, required this.bottomNavigation, required this.onTap});
  final BottomNavigationEnum bottomNavigation;
  final Function(BottomNavigationEnum, int) onTap;

  @override
  State<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CustomPaint(
          painter: ClipShadowShadowPainter(
              clipper: MyArch(),
              shadow: Shadow(
                offset: Offset(0, 1),
                color: AppColors.greyMainColor,
                blurRadius: 12,
              )),
          child: ClipPath(
            clipper: MyArch(),
            child: Container(
              width: size.width,
              height: size.width * 0.23,
              color: AppColors.whiteMainColor,
            ),
          ),
        ),
        Positioned(
          bottom: size.width * 0.05,
          left: size.width * 0.05,
          right: size.width * 0.05,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    navItem(
                        size: size,
                        imageName: 'ic_menu',
                        text: 'menu',
                        isSelected: widget.bottomNavigation ==
                            BottomNavigationEnum.MENU,
                        onTap: () {
                          widget.onTap(BottomNavigationEnum.MENU, 0);
                        }),
                    SizedBox(
                      width: size.width * 0.08,
                    ),
                    navItem(
                        size: size,
                        imageName: 'ic_shopping',
                        text: 'offers',
                        isSelected: widget.bottomNavigation ==
                            BottomNavigationEnum.OFFERS,
                        onTap: () {
                          widget.onTap(BottomNavigationEnum.OFFERS, 1);
                        })
                  ],
                ),
                Row(
                  children: [
                    navItem(
                        size: size,
                        imageName: 'ic_user',
                        text: 'profile',
                        isSelected: widget.bottomNavigation ==
                            BottomNavigationEnum.PROFILE,
                        onTap: () {
                          widget.onTap(BottomNavigationEnum.PROFILE, 3);
                        }),
                    SizedBox(
                      width: size.width * 0.08,
                    ),
                    navItem(
                        size: size,
                        imageName: 'ic_more',
                        text: 'more',
                        isSelected: widget.bottomNavigation ==
                            BottomNavigationEnum.MORE,
                        onTap: () {
                          widget.onTap(BottomNavigationEnum.MORE, 4);
                        })
                  ],
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: size.width * 0.13),
          child: InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              widget.onTap(BottomNavigationEnum.HOME, 2);
            },
            child: CircleAvatar(
              radius: size.width * 0.09,
              backgroundColor:
                  widget.bottomNavigation == BottomNavigationEnum.HOME
                      ? AppColors.orangeMainColor
                      : AppColors.hintTextGrey,
              child: SvgPicture.asset(
                'images/ic_home.svg',
                color: AppColors.whiteMainColor,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget navItem(
      {required Size size,
      required String imageName,
      required String text,
      required bool isSelected,
      required Function onTap}) {
    return InkWell(
        onTap: () {
          onTap();
        },
        child: Column(
          children: [
            SvgPicture.asset(
              'images/$imageName.svg',
              width: size.width * 0.06,
              color: isSelected
                  ? AppColors.orangeMainColor
                  : AppColors.greyMainColor,
            ),
            SizedBox(height: size.width * 0.01),
            Text(text)
          ],
        ));
  }
}

class MyArch extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path0 = Path();
    path0.moveTo(0, 0);
    path0.lineTo(size.width * 0.3381500, 0);
    path0.quadraticBezierTo(size.width * 0.3731500, size.height * 0.0069000,
        size.width * 0.3757000, size.height * 0.1236000);
    path0.quadraticBezierTo(size.width * 0.4022000, size.height * 0.5633000,
        size.width * 0.5006000, size.height * 0.5896000);
    path0.quadraticBezierTo(size.width * 0.5955500, size.height * 0.5727000,
        size.width * 0.6200000, size.height * 0.1240000);
    path0.quadraticBezierTo(size.width * 0.6204500, size.height * -0.0157000,
        size.width * 0.6646000, 0);
    path0.lineTo(size.width, 0);
    path0.lineTo(size.width, size.height);
    path0.lineTo(0, size.height);
    path0.lineTo(0, 0);
    path0.lineTo(size.width * 0.6225000, size.height * 0.6100000);
    return path0;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class ClipShadowShadowPainter extends CustomPainter {
  final Shadow shadow;
  final CustomClipper<Path> clipper;

  ClipShadowShadowPainter({required this.shadow, required this.clipper});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = shadow.toPaint();
    var clipPath = clipper.getClip(size).shift(shadow.offset);
    canvas.drawPath(clipPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
