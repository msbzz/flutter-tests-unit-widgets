 import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/main.dart';
import 'package:bytebank/screens/contact_form.dart';
import 'package:bytebank/screens/contacts_list.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'matchers.dart';
import 'save_contact_flow_test.mocks.dart';

@GenerateMocks([ContactDao])
void main() {
  testWidgets('Should be save contact', (tester) async {
    final mockContactDao = MockContactDao();
    
    // Configurar o mock para retornar uma lista vazia
    when(mockContactDao.findAll()).thenAnswer((_) async {
      debugPrint("Mock findAll() called, returning an empty list");
      return [];
    });

    await tester.pumpWidget(BytebankApp(
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
    debugPrint("Tapped on transfer feature item and waited for animations to settle");

    final contactsList = find.byType(ContactsList);
    expect(contactsList, findsOneWidget);
    debugPrint("ContactsList widget found after navigating to contacts list");

    final fabNewContact = find.widgetWithIcon(FloatingActionButton, Icons.add);
    expect(fabNewContact, findsOneWidget);
    debugPrint("FloatingActionButton for adding new contact found");

    await tester.tap(fabNewContact);
    debugPrint("Tapped on FloatingActionButton to add new contact");
    await tester.pumpAndSettle();
    debugPrint("Waited for animations to settle after tapping FloatingActionButton");

    final contactForm = find.byType(ContactForm);
    expect(contactForm, findsOneWidget);
    debugPrint("ContactForm widget found for entering new contact details");
  });
}
