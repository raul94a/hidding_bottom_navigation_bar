import 'package:flutter/material.dart';
import 'package:hidding_bottom_navigation_bar/hidding_bottom_navigation_bar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: HiddingBottomNavBarWidgetTest());
  }
}

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
      body: ListView.separated(
        controller: controller,
        separatorBuilder: (context, index) => const Divider(color: Colors.grey,),
        itemCount: 150,
        itemBuilder: (ctx,i){
          return SizedBox(height: 50, child: Text('SOY EL NUMERO ${i + 1}'),)
       ; }),
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
          onAppear: () => print('ESTOY APARECIENDO'),
          onHide: () => print('ESTOY DESAPARECIENDO'),
          scrollController: controller),
    );
  }
}
