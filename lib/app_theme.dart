import 'package:flutter/material.dart';

class AppTheme extends InheritedWidget {
  AppTheme({
    required this.id,
    required this.backgroundColor,
    required this.editTextBackgroundColor,
    required this.photoMatColor,
    required Widget child,
  }) : super(
          key: ValueKey(id),
          child: child,
        );

  static AppTheme of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<AppTheme>()!;

  factory AppTheme.light({required Widget child}) => AppTheme(
        id: 'light',
        backgroundColor: Colors.grey.shade300,
        editTextBackgroundColor: Colors.grey.shade100,
        photoMatColor: Colors.grey.shade100,
        child: child,
      );

  final String id;
  final Color backgroundColor;
  final Color photoMatColor;
  final Color editTextBackgroundColor;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return oldWidget is AppTheme && oldWidget.id != id;
  }
}
