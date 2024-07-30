import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/database/database_helper.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Reset the database
  //await DatabaseHelper.resetDatabase();

  runApp(BytebankApp(contactDao: ContactDao()));
}

class BytebankApp extends StatelessWidget {
  final ContactDao contactDao;

  BytebankApp({required this.contactDao});

  @override
  Widget build(BuildContext context) {

    return AppDependencies(
      contactDao:contactDao,
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.green[900],
          hintColor: Colors.blueAccent[700],
          buttonTheme: ButtonThemeData(
            buttonColor: Colors.blueAccent[700],
            textTheme: ButtonTextTheme.primary,
          ),
        ),
        home: Dashboard(),
      ),
    );
  }
}
