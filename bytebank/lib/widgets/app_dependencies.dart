import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:flutter/material.dart';

class AppDependencies extends InheritedWidget {
  final ContactDao contactDao;
  final TransactionWebClient transactionWebClient;
  const AppDependencies({
    required this.contactDao,required this.transactionWebClient,
    required Widget child,
    Key? key,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant AppDependencies oldWidget) {
    return contactDao != oldWidget.contactDao || transactionWebClient !=oldWidget.transactionWebClient;
  }

  static AppDependencies of(BuildContext context) {
    final AppDependencies? result = context.dependOnInheritedWidgetOfExactType<AppDependencies>();
    assert(result != null, 'No AppDependencies found in context');
    return result!;
  }
}
