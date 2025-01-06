

class SimpleTransaction {
  late String transactionId;
  late double amountInWeis;
  late String valueInUsdFormatted;
  late String valueInWeiFormatted;
  String date = '';
  final String walletId;
  final String? status;

  SimpleTransaction( {this.status,required this.transactionId, required this.amountInWeis, required this.date,
    required this.walletId, required this.valueInUsdFormatted, required this.valueInWeiFormatted});

  Map<String, Object?> toMap() {
    return {
      'transactionId': transactionId,
      'amountInWeis': amountInWeis,
      'date': date,
      'walletId': walletId,
      'valueInUsdFormatted': valueInUsdFormatted,
      'valueInWeiFormatted': valueInWeiFormatted,
      'status': status,
    };
  }

  @override
  String toString() {
    return 'SimpleTransaction{transactionId: $transactionId, amountInWeis: $amountInWeis, date: $date,  walletId: $walletId}, valueInUsdFormatted: ${valueInUsdFormatted}, valueInWeiFormatted: ${valueInWeiFormatted},  status: ${status}';
  }

}
