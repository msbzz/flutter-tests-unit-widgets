
import 'package:flutter_test/flutter_test.dart';

import '../../lib/models/transaction.dart';

void main(){
  test('Should return the value when create a transaction', (){
    final transaction = Transaction(id:null,value: 200,contact: null);
    expect(transaction.value, 200);
  });
  // test('Should show error when create transaction with value less than zero', (){
  //   expect(() => Transaction(null, 0, null), throwsAssertionError);
  // });

    test('Should show error when create transaction with value less than zero', (){
    expect(() => Transaction(id:null,value: 0,contact: null), throwsArgumentError);
  });
}