import 'bank_account.dart';
import 'interest_bearing.dart';

//savingsAccount inherits from BankAccount and implements InterestBearing.
class SavingsAccount extends BankAccount implements InterestBearing {
  int _withdrawalCount = 0; //tracks how many times user has withdrawn.
  static const int withdrawalLimit = 3; //max 3 withdrawals per month.
  static const double minBalance = 500; //must keep at least $500 in account.

  SavingsAccount(int num, String name, double bal)
      : super(num, name, bal); //calls parent constructor.

  @override
  void withdraw(double amount) {
    if (_withdrawalCount >= withdrawalLimit) {
      print("Withdrawal limit reached!"); //restrict withdrawals beyond 3.
      return;
    }
    if (balance - amount < minBalance) {
      print("Cannot withdraw below minimum balance of \$500."); //enforce min balance.
      return;
    }
    _withdrawalCount++; //increase withdrawal count.
    deposit(-amount); //deduct money by depositing negative amount.
  }

  @override
  double calculateInterest() => balance * 0.02; //2% interest rate.
}
