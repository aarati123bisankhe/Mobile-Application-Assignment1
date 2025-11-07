import 'savings_account.dart';
import 'checking_account.dart';
import 'premium_account.dart';
import 'student_account.dart';
import 'services_bank_dart';

void main() {
  var bank = Bank(); 
  //create a Bank object to manage all accounts

  var s1 = SavingsAccount(1001, "Aarati", 1000); 
  //create a savingsaccount for aarati with $1000 balance

  var c1 = CheckingAccount(1002, "Aryan", 200); 
  //create a checkingaccount for aryan with $200 balance

  var p1 = PremiumAccount(1003, "Rejin", 15000); 
  //create a premiumaccount for rejin with $15,000 balance

  var st1 = StudentAccount(1004, "Sanskriti", 4000); 
  //create a atudentaccount for sanskriti with $4,000 balance

  bank.addAccount(s1);  //adds aarati’s account to the bank
  bank.addAccount(c1);  //adds aryan’s account
  bank.addAccount(p1);  //adds rejin’s account
  bank.addAccount(st1); //adds sanskriti’s account

  s1.withdraw(300);  //aarati withdraws $300
  p1.deposit(2000);  //rejin deposits $2,000
  bank.transfer(1003, 1002, 500); //transfer $500 from rejin to aryan
  bank.applyMonthlyInterest(); //apply interest to eligible accounts

  bank.showAllAccounts(); //display all account details
}
