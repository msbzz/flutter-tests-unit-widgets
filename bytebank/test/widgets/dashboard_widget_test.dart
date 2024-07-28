import 'package:bytebank/database/dao/contact_dao.dart';
import 'package:bytebank/screens/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../matchers/matchers.dart';
import '../mocks/save_contact_flow_test.mocks.dart';
//import 'mocks.dart';

@GenerateMocks([ContactDao])

void main(){
  
  final mockContactDao = MockContactDao();
    // Configurar o mock para retornar uma lista vazia ou qualquer dado necessário
    when(mockContactDao.findAll()).thenAnswer((_) async => []);
    
  
  testWidgets('Should display the main image when the Dashboard is opened',
      (WidgetTester tester) async {

    // obs1 :
    // Para executar o sistema, sera indicado um problema. 
    // caso a implementação de Dashboard() 
    // não tenho um Scaffold() quee é chamada definida pelo 
    //ByteBankApp. Sendo assim, feita a integração com MaterialApp(), 
    // fazendo com que tudo funcione. Sem essa integração, 
    // não é possivel subir o Dashboard().

    // obs2 : 
    // Ao executarmos o teste, caso não haja o 'await' antes de tester,
    // haverá um problema. 
    // Isso ocorre devido 'o tester.pumpWidget()' não esperar 
    //  fazer todas as execuções necessárias 
    // antes de fazer a busca. Isso é Resolvido com a 
    // declaração de um 'await'.    
    
    await tester.pumpWidget(MaterialApp(home: Dashboard(contactDao:mockContactDao)));

    final mainImage = find.byType(Image);
    expect(mainImage, findsOneWidget);
  });

  testWidgets('Should display the first feature when the Dashboard is opened',
    (tester) async {
  await tester.pumpWidget(MaterialApp(home: Dashboard(contactDao:mockContactDao)));
  final firstFeature = find.byType(FeatureItem);
  expect(firstFeature, findsWidgets);
});


testWidgets('Should display the transfer feature when the Dashboard is opened',
    (tester) async {
  await tester.pumpWidget(MaterialApp(home: Dashboard(contactDao:mockContactDao)));
  final transferFeatureItem = find.byWidgetPredicate((widget) => featureItemMatcher(widget, 'Transfer', Icons.monetization_on));
  expect(transferFeatureItem, findsOneWidget);
});
testWidgets('Should display the transaction feed feature when the Dashboard is opened',
    (tester) async {
  await tester.pumpWidget(MaterialApp(home: Dashboard(contactDao:mockContactDao)));
  final transactionFeedFeatureItem = find.byWidgetPredicate((widget) => featureItemMatcher(widget, 'Transaction Feed', Icons.description));
  expect(transactionFeedFeatureItem, findsOneWidget); 
}); 



}