import 'package:flutter/material.dart';

class SignInButton extends StatelessWidget {
  final String textLabel;
  final String iconPath;
  final double elevation;
  final Color backgroundColor;
  final void Function() onTap;

  const SignInButton({
    Key key,
    this.textLabel,
    this.iconPath,
    this.elevation,
    this.backgroundColor,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          primary: backgroundColor,
          shape: const StadiumBorder(),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 6,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                  iconPath,
                ),
                height: 20,
                width: 20,
              ),
              const SizedBox(
                width: 14,
              ),
              Text(
                textLabel,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
