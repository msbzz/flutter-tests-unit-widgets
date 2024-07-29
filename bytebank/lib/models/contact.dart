class Contact {
  final int id;
  final String name;
  final int accountNumber;

  Contact(
    {
    required this.id,
    required this.name,
    required this.accountNumber,
    }

  );
  
  // Construtor de fábrica para criar uma instância de Contact a partir de JSON
  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      name: json['name'],
      accountNumber: json['accountNumber'],
    );
  }

  @override
  String toString() {
    return 'Contact{id: $id, name: $name, accountNumber: $accountNumber}';
  }
 

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'accountNumber': accountNumber,
      };

  @override
  bool operator == (Object other) => identical(this, other) ||
      other is Contact &&
          runtimeType == other.runtimeType &&
          name == other.name && accountNumber == other.accountNumber;

  @override
  int get hashCode => name.hashCode ^ accountNumber.hashCode;
}
