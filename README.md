
HiddingBottomNavigationBar is a lightweight library to create and control a hidding bottom navigation bar. When scrolling down, the BottomNavigationBar disappears. On the contrary, when scrolling up, the BottomNavigationBar appears. Effortlessly.

## Features

Simple and functional HiddingBottomNavigationBar. The implementation is the same as the Flutter BottomNavigationBar, with a extended functionality to make the bar dissapear or appear. Also, an onHide and onAppear callbacks are provided in the case you need them.

## Getting started

Install the dependency with the following command line:

```shell
flutter pub add hidding_bottom_navigation_bar
```

## Usage 

```dart
import 'package:hidding_bottom_navigation_bar/hidding_bottom_navigation_bar.dart';

/**
* Three simple steps:

*  1. Create a ScrollController
*  2. Pass the ScrollController to the ScrollableView (ListView, SingleChildScrollView, etc).
*  3. Pass the same ScrollController to the HiddingBottomNavigationBar
*
*/

class HiddingBottomNavBarWidgetExample extends StatefulWidget {
  const HiddingBottomNavBarWidgetExample({super.key});

  @override
  State<HiddingBottomNavBarWidgetExample> createState() =>
      _HiddingBottomNavBarWidgetExampleState();
}

class _HiddingBottomNavBarWidgetExampleState
    extends State<HiddingBottomNavBarWidgetTest> {
      //You need to create a ScrollController
  final controller = ScrollController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: null,
      body: SizedBox(
        height: size.height * 2,
        child: SingleChildScrollView(
          //pass the scroll controller to the SingleChildScrollView
          controller: controller,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                  width: size.width,
                  height: size.height,
                  child: const Center(child: Text('Test hidding bottom navigation bar')))
            ],
          ),
        ),
      ),
      bottomNavigationBar: HiddingBottomNavigationBar(
          type: FlexibleBottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today), label: 'Tasks'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Settings'),
          ],
          onTap: (index) {},
          //Then pass the scroll controller to the HiddingBototmNavigationBar in order to listen to Scroll changes in the screen
          scrollController: controller),
    );
  }
    }
```