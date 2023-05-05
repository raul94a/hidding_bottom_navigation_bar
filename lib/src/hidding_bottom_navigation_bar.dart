import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hidding_bottom_navigation_bar/src/flexible_bottom_navigation_bar.dart';

class HiddingBottomNavigationBar extends StatefulWidget {
  const HiddingBottomNavigationBar(
      {super.key,
      this.currentIndex = 0,
      required this.items,
      required this.onTap,
      this.elevation,
      this.fixedColor,
      this.backgroundColor,
      this.iconSize = 24.0,
      this.selectedIconTheme,
      this.unselectedIconTheme,
      this.selectedFontSize = 14.0,
      this.unselectedFontSize = 12.0,
      this.selectedLabelStyle,
      this.unselectedLabelStyle,
      this.showSelectedLabels,
      this.showUnselectedLabels,
      this.enableFeedback,
      this.mouseCursor,
      this.selectedItemColor,
      this.unselectedItemColor,
      this.onAppear,
      this.onHide,
      this.landscapeLayout,
      this.type = FlexibleBottomNavigationBarType.fixed,
      this.duration = const Duration(milliseconds: 550),
      this.reverseDuration = const Duration(milliseconds: 550),
      required this.scrollController,
      this.height = 120.0});
  final int currentIndex;
  final List<BottomNavigationBarItem> items;
  final ScrollController scrollController;
  final double height, selectedFontSize, unselectedFontSize, iconSize;
  final double? elevation;
  final Color? fixedColor,
      backgroundColor,
      selectedItemColor,
      unselectedItemColor;
  final bool? showSelectedLabels, showUnselectedLabels, enableFeedback;
  final IconThemeData? selectedIconTheme, unselectedIconTheme;
  final BottomNavigationBarLandscapeLayout? landscapeLayout;
  final MouseCursor? mouseCursor;
  final TextStyle? selectedLabelStyle, unselectedLabelStyle;
  final Function(int)? onTap;
  final Function()? onHide, onAppear;
  final FlexibleBottomNavigationBarType type;
  final Duration duration, reverseDuration;
  @override
  State<HiddingBottomNavigationBar> createState() =>
      _HiddingBottomNavigationBarState();
}

class _HiddingBottomNavigationBarState extends State<HiddingBottomNavigationBar>
    with TickerProviderStateMixin {
  late final AnimationController _sliderController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 550),
      reverseDuration: const Duration(milliseconds: 1000));
  late final Animation<Offset> _sliderAnimation =
      Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, 0.8))
          .chain(CurveTween(curve: Curves.fastOutSlowIn))
          .animate(_sliderController);

  late final AnimationController _heightController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
      reverseDuration: const Duration(milliseconds: 1000));
  bool navBarIsHidden = false;
  @override
  void dispose() {
    _heightController.dispose();
    _sliderController.dispose();
    widget.scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Animation<double> heightAnimation =
        Tween<double>(begin: widget.height, end: 0)
            .chain(CurveTween(curve: Curves.fastOutSlowIn))
            .animate(_heightController);
    _setController();

    return AnimatedBuilder(
        animation: Listenable.merge([_sliderController, _heightController]),
        builder: (context, child) {
          return Transform.translate(
              offset: _sliderAnimation.value,
              child: SizedBox(
                height: heightAnimation.value,
                child: FlexibleBottomNavigationBar(
                  enableFeedback: widget.enableFeedback,
                  elevation: widget.elevation,
                  mouseCursor: widget.mouseCursor,
                  landscapeLayout: widget.landscapeLayout,
                  iconSize: widget.iconSize,
                  selectedIconTheme: widget.selectedIconTheme,
                  unselectedIconTheme: widget.unselectedIconTheme,
                  selectedFontSize: widget.selectedFontSize,
                  unselectedFontSize: widget.unselectedFontSize,
                  selectedItemColor: widget.selectedItemColor,
                  unselectedItemColor: widget.unselectedItemColor,
                  selectedLabelStyle: widget.selectedLabelStyle,
                  unselectedLabelStyle: widget.unselectedLabelStyle,
                  showSelectedLabels: widget.showSelectedLabels,
                  showUnselectedLabels: widget.showUnselectedLabels,
                  currentIndex: widget.currentIndex,
                  fixedColor: widget.fixedColor,
                  backgroundColor: widget.backgroundColor,
                  onTap: widget.onTap,
                  items: widget.items,
                  type: widget.type,
                ),
              ));
        });
  }

  _setController() {
    widget.scrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    if (_sliderController.isAnimating) {
      return;
    }
    if (widget.scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (_sliderController.isCompleted) {
        _sliderController.reverse();
        _heightController.reverse().whenComplete(() {
          navBarIsHidden = false;
          widget.onAppear != null ? widget.onAppear!() : () => {};
        });
      }
    } else if (widget.scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if ((_sliderController.isCompleted || !_sliderController.isAnimating)) {
        _sliderController.forward();
        _heightController.forward().whenComplete(() {
          if (navBarIsHidden) {
            return;
          }
          navBarIsHidden = true;
          widget.onHide != null ? widget.onHide!() : () => {};
        });
      }
    }
    return;
  }
}
