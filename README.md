
## Features

A Bottom Navigation bar that hides when scrolling down or appears when scrolling up.

## Getting started

### Install in pubspec.yaml

```yaml


hidding_bottom_navigation_bar:
    git:
      url: https://github.com/raul94a/hidding_bottom_navigation_bar
 ```    
### import
```dart

import 'package:hidding_bottom_navigation_bar/hidding_bottom_navigation_bar.dart';

```

## Usage

Just use HiddingBottomNavigationBar in the Scaffold bottomNavigationBar parameter. You need to attatch a ScrollController both the HiddingNavigationBar and the scrollable Widget (SingleChildScrollView, ListView, etc). 

```dart

class HiddingBottomNavBarWidgetTest extends StatefulWidget {
  const HiddingBottomNavBarWidgetTest({super.key});

  @override
  State<HiddingBottomNavBarWidgetTest> createState() =>
      _HiddingBottomNavBarWidgetTestState();
}

class _HiddingBottomNavBarWidgetTestState
    extends State<HiddingBottomNavBarWidgetTest> {
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
          scrollController: controller),
    );
  }
}
```

## Additional information


