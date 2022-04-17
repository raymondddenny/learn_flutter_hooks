import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'extension/normalize_num.dart';

import 'constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends HookWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final opacity = useAnimationController(
      duration: const Duration(seconds: 1),
      initialValue: 1,
      upperBound: 1,
      lowerBound: 0.0,
    );
    final size = useAnimationController(
      duration: const Duration(seconds: 1),
      initialValue: 1,
      upperBound: 1,
      lowerBound: 0.0,
    );

    final scrollController = useScrollController();

    useEffect(() {
      scrollController.addListener(() {
        final newOpacity = max(imageHeight - scrollController.offset, 0.0);
        final normalize = newOpacity.normalized(0.0, imageHeight).toDouble();
        opacity.value = normalize;
        size.value = normalize;
      });
      return null;
    }, [scrollController]);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Column(
        children: [
          SizeTransition(
            // this will resize the widget as we scroll
            sizeFactor: size,
            axis: Axis.vertical,
            axisAlignment: -1.0,
            child: FadeTransition(
              opacity: opacity,
              child: Image.network(
                url,
                height: imageHeight,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemCount: 100,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    'Person ${index + 1}',
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
