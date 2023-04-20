import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hidding_bottom_navigation_bar/src/flexible_bottom_navigation_bar.dart';

class HiddingBottomNavigationBar extends StatefulWidget {
  const HiddingBottomNavigationBar(
      {super.key,
      this.currentIndex = 0,
      required this.items,
      required this.onTap,
      this.type = FlexibleBottomNavigationBarType.fixed,
      this.duration = const Duration(milliseconds: 550),
      this.reverseDuration = const Duration(milliseconds: 1000),
      required this.scrollController,
      this.height = 120.0});
      final int currentIndex;
  final List<BottomNavigationBarItem> items;
  final ScrollController scrollController;
  final double height;
  final Function(int)? onTap;
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
        _heightController.reverse();
      }
    } else if (widget.scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if ((_sliderController.isCompleted || !_sliderController.isAnimating)) {
        _sliderController.forward();
        _heightController.forward();
      }
    }
    return;
  }
}
