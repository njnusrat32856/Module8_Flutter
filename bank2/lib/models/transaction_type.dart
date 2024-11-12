enum TransactionType {
  deposit,
  withdraw,
  fundTransfer,
}
// Convert enum to a string for JSON
String transactionTypeToJson(TransactionType type) {
  return type.toString().split('.').last;
}

// Parse string to enum from JSON
TransactionType transactionTypeFromJson(String? type) {
  switch (type) {
    case 'deposit':
      return TransactionType.deposit;
    case 'withdraw':
      return TransactionType.withdraw;
    case 'fundTransfer':
      return TransactionType.fundTransfer;
    default:
      print('Warning: Unknown transaction type "$type". Defaulting to "deposit".');
      return TransactionType.deposit;
      throw Exception('Unknown transaction type');
  }
}
