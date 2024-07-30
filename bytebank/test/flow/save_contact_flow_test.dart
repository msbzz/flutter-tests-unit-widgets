import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/http/webclients/transaction_webclient.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/models/contact.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../matchers/matchers.dart';
 
import '../mocks/save_contact_flow_test.mocks.dart';

@GenerateMocks([ContactDao,TransactionWebClient])
void main() {
  testWidgets('Should save contact', (tester) async {
    final mockContactDao = MockContactDao();
    final mockTransactionWebClient = MockTransactionWebClient(); 

    // Configurar o mock para retornar uma lista vazia
    when(mockContactDao.findAll()).thenAnswer((_) async {
      debugPrint("Mock findAll() called, returning an empty list");
      return [];
    });

    // Configurar o mock para salvar um contato
    final capturedContacts = <Contact>[];
    when(mockContactDao.save(captureAny)).thenAnswer((invocation) async {
      final contact = invocation.positionalArguments[0] as Contact;
      capturedContacts.add(contact);
      debugPrint("Mock save() called with: $contact");
      return 1; // Suponha que o retorno seja o ID do contato salvo
    }); 

    await tester.pumpWidget(BytebankApp(
      transactionWebClient: mockTransactionWebClient,
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
    debugPrint("ContactsList widget found after navigating to contacts list");
    verify(mockContactDao.findAll()).called(1);
    debugPrint("verify findAll called in contacts list");

    final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNewContact, findsOneWidget);
    debugPrint("FloatingActionButton for adding new contact found");

    await tester.tap(fabNewContact);
    debugPrint("Tapped on FloatingActionButton to add new contact");
    await tester.pumpAndSettle();
    debugPrint(
        "Waited for animations to settle after tapping FloatingActionButton");

    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);
    debugPrint("ContactForm widget found for entering new contact details");

    // final nameTextField = find.byWidgetPredicate((widget) {
    //   if (widget is TextField) {
    //     return widget.decoration!.labelText == 'Full name';
    //   }
    //   return false;
    // });

    final nameTextField = find.byWidgetPredicate((widget) => _textFieldMatcher(widget,'Full name' )
    );

    expect(nameTextField, findsOneWidget);
    debugPrint("Text field 'Full name' finder");
    await tester.enterText(nameTextField, 'Alex');
    debugPrint("Entered name 'Alex'");

    // final accountNumberTextField = find.byWidgetPredicate((widget) {
    //   if (widget is TextField) {
    //     return widget.decoration!.labelText == 'Account number';
    //   }
    //   return false;
    // });

    final accountNumberTextField = find.byWidgetPredicate((widget) => _textFieldMatcher(widget,'Account number' )
    );

    expect(accountNumberTextField, findsOneWidget);
    debugPrint("Text field 'Account number' finder");
    await tester.enterText(accountNumberTextField, '1000');
    debugPrint("Entered account number '1000'");

    final createButton = find.widgetWithText(TextButton, 'Create');
    expect(createButton, findsOneWidget);
    debugPrint("TextButton 'Create' finder");
    await tester.tap(createButton);
    debugPrint("Tapped on TextButton to create new contact");

    await tester.pumpAndSettle();

    // // Realizar todas as verificações com base nos contatos capturados
    // debugPrint("Iniciando verificações dos contatos capturados");
    // try {
    //   expect(capturedContacts.length, 1, reason: "Deve haver exatamente uma chamada ao método save");
    //   final savedContact = capturedContacts.first;
    //   expect(savedContact, isA<Contact>(), reason: "O contato salvo deve ser do tipo Contact");
    //   expect(savedContact.name, 'Alex', reason: "O nome do contato salvo deve ser 'Alex'");
    //   expect(savedContact.accountNumber, 1000, reason: "O número da conta do contato salvo deve ser 1000");
    //   debugPrint("Todas as verificações dos contatos capturados passaram");
    // } catch (e) {
    //   debugPrint("Falha nas verificações dos contatos capturados: $e");
    //   rethrow;
    // }

    verify(mockContactDao.save(Contact(id:0,name: 'Alex',accountNumber: 1000)));
    debugPrint("the 'save' method has been fully verified");

    final contactsListBack = find.byType(ContactsList);
    expect(contactsListBack, findsOneWidget);

verify(mockContactDao.findAll());
  });
}

bool _textFieldMatcher(Widget widget,String labelText) {
     
    if (widget is TextField) {
      return widget.decoration!.labelText == labelText;
    }
    return false;
       
}