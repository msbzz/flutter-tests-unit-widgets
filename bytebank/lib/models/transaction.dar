import 'contact.dart';

class Transaction {
  final String? id;
  final double value;
  final Contact? contact;

  // Transaction(
  //     this.id,
  //     this.value,
  //     this.contact,
  //     ):assert(value>0);

  Transaction(
    this.id,
    this.value,
    this.contact,
  ) {
    if (value <= 0) {
      throw ArgumentError('O valor deve ser maior que zero');
    }
  }

  Transaction.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        value = json['value'],
         contact = Contact.fromJson(json['contact']) // Inicializa o campo 'contact'
        // A partir daqui, estamos no corpo do construtor
  {
    // Validação no corpo do construtor
    if (value <= 0) {
      throw ArgumentError('O valor deve ser maior que zero');
    }
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
