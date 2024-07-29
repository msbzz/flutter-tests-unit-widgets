import 'contact.dart';

class Transaction {
  final String? id;
  final double value;
  final Contact? contact;

  Transaction(
    {
    required this.id,
    required this.value,
    required this.contact,
    }

  ) {
    if (value <= 0) {
      throw ArgumentError('O valor deve ser maior que zero');
    }
  }


  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      value: json['value'].toDouble(),
      contact: Contact.fromJson(json['contact']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'value': value,
        'contact': contact?.toJson(),
      };

  @override
  String toString() {
    return 'Transaction{value: $value, contact: $contact}';
  }
}
