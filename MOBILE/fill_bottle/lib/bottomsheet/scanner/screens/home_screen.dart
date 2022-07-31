import 'package:fill_bottle/bottomsheet/scanner/screens/sign_in_options_screen.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  void _showModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
        top: Radius.circular(30),
      )),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.4,
          maxChildSize: 0.9,
          minChildSize: 0.32,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: const SignInOptionsScreen(),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showModalBottomSheet(context),
        tooltip: 'Bottom Sheet',
        child: const Icon(Icons.add),
      ),
    );
  }
}
