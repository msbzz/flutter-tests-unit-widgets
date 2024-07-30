import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/database/database_helper.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/widgets/app_dependencies.dart';
import 'package:flutter/material.dart';
 

void main() async {
  // Ensure Flutter is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Reset the database
  //await DatabaseHelper.resetDatabase();

  runApp(BytebankApp(contactDao: ContactDao(),transactionWebClient:TransactionWebClient() ,));
}

class BytebankApp extends StatelessWidget {
  final ContactDao contactDao;
   final TransactionWebClient transactionWebClient;
  BytebankApp({required this.contactDao,required this.transactionWebClient});

  @override
  Widget build(BuildContext context) {

    return AppDependencies(
      contactDao:contactDao,
      transactionWebClient:transactionWebClient ,
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
