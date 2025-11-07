import 'bank_account.dart';

//checkingAccount allows overdraft but applies a $35 fee if balance < 0.
class CheckingAccount extends BankAccount {
  static const double overdraftFee = 35.0; //fee for going negative.

  CheckingAccount(int num, String name, double bal)
      : super(num, name, bal); //calls parent class constructor.

  @override
  void withdraw(double amount) {
    if (balance - amount < 0) {
      deposit(-amount - overdraftFee); //deduct amount + fee.
      print("Overdraft! Fee applied: \$35"); //inform user.
    } else {
      deposit(-amount); //normal withdrawal.
    }
  }
}
