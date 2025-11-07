//abstract parent class for all bank accounts.
abstract class BankAccount {
  int _accountNumber; //private account number.
  String _holderName; //private account holder’s name.
  double _balance; //privateaccount balance.
  List<String> _transactionHistory = []; //keeps a log of all transactions.

  //constructor initializes account details.
  BankAccount(this._accountNumber, this._holderName, this._balance);

  //getter for account number (read-only).
  int get accountNumber => _accountNumber;

  //getter for holder name.
  String get holderName => _holderName;

  //getter for current balance.
  double get balance => _balance;

  //deposit money into account.
  void deposit(double amount) {
    if (amount > 0) {
      _balance += amount; //increase balance by deposit amount.
      _transactionHistory.add("Deposited: \$${amount.toStringAsFixed(2)}"); /// Log transaction.
    } else {
      print("Invalid deposit amount."); //simple validation.
    }
  }

  //display account details.
  void displayInfo() {
    print("Account Number: $_accountNumber");
    print("Holder Name: $_holderName");
    print("Balance: \$${_balance.toStringAsFixed(2)}");
  }

  //show full transaction history.
  void showTransactionHistory() {
    print("\nTransaction History for $_holderName:");
    for (var t in _transactionHistory) {
      print("- $t");
    }
  }

  //bbstract withdraw method/must be defined in child classes.
  void withdraw(double amount);
}
