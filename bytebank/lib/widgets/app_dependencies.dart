import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:flutter/material.dart';

class AppDependencies extends InheritedWidget {
  final ContactDao contactDao;

  const AppDependencies({
    required this.contactDao,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant AppDependencies oldWidget) {
    return contactDao != oldWidget.contactDao;
  }

  static AppDependencies of(BuildContext context) {
    final AppDependencies? result = context.dependOnInheritedWidgetOfExactType<AppDependencies>();
    assert(result != null, 'No AppDependencies found in context');
    return result!;
  }
}
