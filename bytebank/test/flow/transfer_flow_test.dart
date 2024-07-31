import 'package:bytebank/components/transaction_auth_dialog.dart';
import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/screens/transaction_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
 
import '../mocks/save_contact_flow_test.mocks.dart';

@GenerateMocks([ContactDao,TransactionWebClient])
void main(){
  testWidgets('transfer to a contact', (tester) async {
    final mockContactDao = MockContactDao();
    final mockTransactionWebClient = MockTransactionWebClient(); 
    // Configurar o mock para retornar uma lista vazia
    when(mockContactDao.findAll()).thenAnswer((_) async {
      debugPrint("Mock findAll() called, returning an empty list");
      return [];
    });

      when(mockContactDao.findAll()).thenAnswer((invocation) async {
      debugPrint("Mock findAll() called, returning ${invocation.memberName}");
      return [Contact(id:0,name:'Marco',accountNumber:1000)];
    });

    // Configurar o mock para salvar um contato
    final capturedContacts = <Contact>[];

    // when(mockContactDao.save(captureAny)).thenAnswer((invocation) async {
    //   final contact = invocation.positionalArguments[0] as Contact;
    //   capturedContacts.add(contact);
    //   debugPrint("Mock save() called with: $contact");
    //   return 1; //  
    // });

    await tester.pumpWidget(BytebankApp(
      transactionWebClient:mockTransactionWebClient,
      contactDao: mockContactDao,
    ));
    debugPrint("BytebankApp widget loaded successfully");

    final dashboard = find.byType(Dashboard);
    expect(dashboard, findsOneWidget);
    debugPrint("Dashboard widget found on screen");

    final transferFeatureItem = find.byWidgetPredicate((widget) =>
    featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
    expect(transferFeatureItem, findsOneWidget);
    debugPrint("Transfer feature item found on dashboard");

    await tester.tap(transferFeatureItem);
    await tester.pumpAndSettle();
    debugPrint(
        "Tapped on transfer feature item and waited for animations to settle");

    final contactsList = find.byType(ContactsList);
    expect(contactsList, findsOneWidget);
    debugPrint("Finded widget ContactList");

    debugPrint("ContactsList widget found after navigating to contacts list");
    verify(mockContactDao.findAll()).called(1);
    debugPrint("verify findAll called in contacts list");


    final contactItem = find.byWidgetPredicate((widget){
       if(widget is ContactItem){
        return widget.contact.name == 'Marco' && widget.contact.accountNumber  == 1000;
       }
       return false;
    });

    expect(contactItem, findsOneWidget);
    debugPrint("verify finded contact item");
    
    await tester.tap(contactItem);
    await tester.pumpAndSettle();
    debugPrint("typed contactItem");

    final transactionForm = find.byType(TransactionForm);
    expect(transactionForm,findsOneWidget);
    debugPrint("finded TransactionForm");
   final contactName = find.text('Marco');
    expect(contactName, findsOneWidget);
    debugPrint("finded name Marco");
    final contactAccountNumber = find.text('1000');
    expect(contactAccountNumber, findsOneWidget);
    debugPrint("finded accountNumber 1000");

    
    final textFieldValue = find.byWidgetPredicate((widget){
      return textFieldByLabelTextMatcher(widget,  'Value');
    });

    expect(textFieldValue, findsOneWidget);
    debugPrint("finded label text Value");

    await tester.enterText(textFieldValue, '200');
    debugPrint("edited textValue 200");

    final transferButton = find.widgetWithText(TextButton, 'Transfer');
    expect(transferButton, findsOneWidget);
    debugPrint("finded Textbutton Transfer");

    await tester.tap(transferButton);
    await tester.pumpAndSettle();
    debugPrint("taped Textbutton Transfer");

    final transactionAuthDialog = find.byType(TransactionAuthDialog);
    expect(transactionAuthDialog, findsOneWidget);
    debugPrint("finded TransactionAuthDialog");

    

  });
}