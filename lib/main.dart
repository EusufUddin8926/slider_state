import 'package:flutter/material.dart';
import 'package:slider_flutter/slider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Slide to act Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  final GlobalKey<SlideActionState> _slideActionKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.76,
          child: SlideAction(
            key: _slideActionKey, // Assign the key to the SlideAction
            text: 'Start Market Visit',
            textStyle: const TextStyle(color: Colors.white, fontSize: 16),
            innerColor: Colors.yellow.withOpacity(0.4),
            elevation: 4,
            height: 58,
            enabled: !isLoading,
            outerColor: Colors.blue.withOpacity(0.8),
            sliderButtonIconPadding: 4,
            sliderButtonIcon: Center(
              child: isLoading
                  ? Transform.scale(
                      scale: 0.8,
                      child: const CircularProgressIndicator(
                        strokeWidth: 3.0,
                        color: Colors.pink,
                      ),
                    )
                  : const Icon(
                      Icons.arrow_right_alt_outlined,
                      color: Colors.white,
                      size: 40.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
            ),
            onSubmit: () async {
              // Check again to ensure that the slide action only triggers once.
              if (isLoading) return;

              setState(() {
                isLoading = true; // Show loading spinner
              });

              print('Sliding action initiated...');

              // Reset the slider position immediately after triggering the action

              // Simulate a delay (e.g., for an API call or other asynchronous task)
              await Future.delayed(const Duration(seconds: 5), () {
                print('Market visit started!');
                setState(() {
                  isLoading = false; // Hide loading spinner
                });
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Slider task Done")));
              });
              _slideActionKey.currentState?.reset();
            },
          ),
        ),
      ),
    );
  }
}
