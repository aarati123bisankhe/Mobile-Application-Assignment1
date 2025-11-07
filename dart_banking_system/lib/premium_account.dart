import 'bank_account.dart';
import 'interest_bearing.dart';

//premiumAccount for high-value clients with high balance requirements
class PremiumAccount extends BankAccount implements InterestBearing {
  static const double minBalance = 10000; //must maintain $10,000 minimum

  PremiumAccount(int num, String name, double bal)
      : super(num, name, bal); //call parent constructor

  @override
  void withdraw(double amount) {
    if (balance - amount < minBalance) {
      print("Cannot go below minimum balance of \$10,000."); //restrict low balance
      return;
    }
    deposit(-amount); //deduct amount
  }

  @override
  double calculateInterest() => balance * 0.05; //5% interest rate
}
