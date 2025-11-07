// Interest Bearing Interface

import 'dart:async';

abstract class InterestBearing {
  double calculateInterest();
  //This Interface defines a method calculateInterest()
  //Any account that earn interet (like savings or premium) must implement this.
}

//Abstract Base Class
abstract class BankAccount {
  int _accountNumber; //private accountnumber
  int _holderName; //private account holder name
  double _balance; //private balance
  List<String> _transcationHistory = []; //store transaction details

  // constructor initializes account details
  BankAccount(this._accountNumber, this._holderName, this._balance);

  //getter for encapsulation/ saftey access private fields
  int get accountNumber => _accountNumber;
  int get holderName => _holderName;
  double get balance => _balance;

  //deposite money into the account
  void deposit(double amount) {
    if (amount > 0) {
      _balance += amount; //increase balance
      _transcationHistory.add(
        "Deposited: \$${amount.toStringAsFixed(2)}",
      ); //add record
    } else {
      print("Invalid deposit amount."); //validation
    }
  }

  //display account into neatly
  void displayInfo() {
    print("Account Number: $_accountNumber");
    print("Holder Name: $_holderName");
    print("Balance: \$${_balance.toStringAsFixed(2)}");
  }

  // shows all the past transcation for this account
  void showTransactionHistory() {
    print("\nTransaction History for $_holderName:");
    for (var t in _transcationHistory) {
      print("- $t"); //prints each transaction
    }
  }

  //abtract method / must ne implemented by all subclasses
  void withdraw(double amount);
}

//Saving Account
class SavingAccount extends BankAccount implements InterestBearing {
  int _withdrawalcount = 0; //track number of withdrawals
  static const int withdrawalLimit = 3; //max 3 per mon
  static const double minBalance = 500; //minimum balance required

  SavingAccount(int num, String name, double bal)
    : super(num, name as int, bal); //call parent constructor

  @override
  void withdraw(double amount) {
    if (_withdrawalcount >= withdrawalLimit) {
      print("WithDrawal limit reached!"); //stop extra withdrawals
      return;
    }
    if (balance - amount < minBalance) {
      print(
        "cannot withdraw below minimum balance of \$500.",
      ); // protect min balance
      return;
    }
    _withdrawalcount++; //count this withdrawal
    super.deposit(-amount); // use deposit(-amount) to subtract safely
  }

  @override
  double calculateInterest() => balance * 0.02; //2% interest on balance
}

//checking account
class CheckingAccount extends BankAccount {
  static const double overdraftFee = 35.0; //fee if balance goes negative

  CheckingAccount(int num, String name, double bal)
    : super(num, name as int, bal); //constructor

  @override
  void withdraw(double amount) {
    if (balance - amount < 0) {
      // if withdraw causes negative balance
      super.deposit(-amount - overdraftFee); //deduct amount plus overdraft fee
      print("Overdraft! Fee applied: \$35");
    } else {
      super.deposit(-amount); //normal withdrawal
    }
  }
}

//premium account
class PremiumAccount extends BankAccount implements InterestBearing {
  static const double minBalance = 10000; //must maintain $10,000 balance

  PremiumAccount(int num, String name, double bal)
    : super(num, name as int, bal);

  @override
  void withdraw(double amount) {
    if (balance - amount < minBalance) {
      print("Cannot go below minimum balance of \$10,000."); // block withdrawal
      return;
    }
    super.deposit(-amount); //valid withdrawal
  }

  @override
  double calculateInterest() => balance * 0.05;
  // 5% interest for premium accounts
}

//Student account (extension)
class StudentAccount extends BankAccount {
  static const double maxBalance = 5000; // Can't go above $5000

  StudentAccount(int num, String name, double bal)
    : super(num, name as int, bal);

  @override
  void deposit(double amount) {
    // Prevent exceeding max balance
    if (balance + amount > maxBalance) {
      print("Cannot exceed max balance of \$5,000.");
      return;
    }
    super.deposit(amount); //valid deposit
  }

  @override
  void withdraw(double amount) {
    if (balance - amount < 0) {
      print("Insufficient balance."); //prevent negative balance
      return;
    }
    super.deposit(-amount); //valid withdrawal
  }
}

//bank class
class Bank {
  final List<BankAccount> _accounts = []; // Store all created accounts

  // Add new account to the bank
  void addAccount(BankAccount account) => _accounts.add(account);

  // Find an account by number (returns null if not found)
  BankAccount? findAccount(int number) =>
      _accounts.firstWhere((acc) => acc.accountNumber == number, orElse: () => null as BankAccount);

  // Transfer money between two accounts
  void transfer(int from, int to, double amount) {
    var sender = findAccount(from); // Find sender account
    var receiver = findAccount(to); // Find receiver account

    if (sender == null || receiver == null) {
      print("Invalid account number(s)."); // If account not found
      return;
    }

    sender.withdraw(amount); // Take money from sender
    receiver.deposit(amount); // Give money to receiver
    print("Transferred \$${amount.toStringAsFixed(2)} from ${sender.holderName} to ${receiver.holderName}.");
  }

  // apply monthly interest to all accounts that earn interest
  void applyMonthlyInterest() {
    for (var acc in _accounts) {
      if (acc is InterestBearing) {
        // Only applies to Savings and Premium accounts
        double interest = acc.calculateInterest();
        acc.deposit(interest);
        print("Interest of \$${interest.toStringAsFixed(2)} added to ${acc.holderName}");
      }
    }
  }

  // Display info for all accounts in the bank
  void showAllAccounts() {
    for (var acc in _accounts) {
      acc.displayInfo();
      print("----------------------------");
    }
  }
}


// // ========================= MAIN FUNCTION (PROGRAM START) =========================
// void main() {
//   var bank = Bank(); 
//   // Creates a new Bank object to manage all accounts.

//   var s1 = SavingAccount(1001, "Alice", 1000); 
//   // Alice's savings account with $1000 balance.

//   var c1 = CheckingAccount(1002, "Bob", 200); 
//   // Bob’s checking account with $200 balance.

//   var p1 = PremiumAccount(1003, "Charlie", 15000); 
//   // Charlie’s premium account with $15,000 balance.

//   var st1 = StudentAccount(1004, "David", 4000); 
//   // David’s student account with $4,000 balance.

//   bank.addAccount(s1);
//   // Adds Alice’s account to the bank’s account list.

//   bank.addAccount(c1);
//   // Adds Bob’s account to the bank’s account list.

//   bank.addAccount(p1);
//   // Adds Charlie’s premium account to the bank’s account list.

//   bank.addAccount(st1);
//   // Adds David’s student account to the bank’s account list.

//   s1.withdraw(300);
//   // Alice withdraws $300 → balance decreases by $300 (if within limits).

//   p1.deposit(2000);
//   // Charlie deposits $2000 → new balance = $17,000.

//   bank.transfer(1003, 1002, 500);
//   // Transfers $500 from Charlie’s (1003) account to Bob’s (1002).

//   bank.applyMonthlyInterest();
//   // Adds interest to all interest-bearing accounts (Savings and Premium).

//   bank.showAllAccounts();
//   // Displays all accounts' info: account number, holder name, and current balance.
// }