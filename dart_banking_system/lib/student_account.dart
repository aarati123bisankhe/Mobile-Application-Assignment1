import 'bank_account.dart';

//studentaccount has no fees but a max balance of $5,000
class StudentAccount extends BankAccount {
  static const double maxBalance = 5000; //can’t exceed this limit.

  StudentAccount(int num, String name, double bal)
      : super(num, name, bal); //calls parent constructor.

  @override
  void deposit(double amount) {
    if (balance + amount > maxBalance) {
      print("Cannot exceed max balance of \$5,000."); //enforce limit
      return;
    }
    super.deposit(amount); //otherwise, deposit normally
  }

  @override
  void withdraw(double amount) {
    if (balance - amount < 0) {
      print("Insufficient balance."); //prevent negative balance
      return;
    }
    deposit(-amount); //deduct by depositing negative value
  }
}
