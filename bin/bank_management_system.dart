// class Account with 2 Mixins(Validation, LimitChecker) and implements 1 interface(AccountOperation)
class Account with Validation, LimitChecker implements AccountOperations{
  int accNum;
  double _balance;
  // A final list of objects from a class(Transaction)
  final List<Transaction> _transactions = [];  // this is a Composition because logically "an account is composed of transactions"
  Account(this.accNum, this._balance); //constructor

  @override // the implementation of deposit method from AccountOperations interface
  void deposit(double amount){
    _balance += amount;
    _transactions.add(Transaction(_transactions.length+1, amount, TransactionType.deposit));
  }
  @override // the implementation of withdraw method from AccountOperations interface
  void withdraw(double amount){
    // isValidAmount and canWithdraw are methods of Validation and LimitChecker interfaces
    if(isValidAmount(amount) && canWithdraw(_balance, amount)){
      _balance -= amount;
      //adding an object(Transaction) to transactions objects
      //Transaction(transactionId, amount, TransactionType)
      _transactions.add(Transaction(_transactions.length+1, -amount, TransactionType.withdraw));
    }
    else{
      print("Enter a valid amount");
    }
  }
  double get balance => _balance; //using Getter to access the balance
  List<Transaction> get transactions => _transactions; // using Getter to access transactions
}

// Savings Account has interest rate and inherit from Account
class SavingsAccount extends Account{
  double interestRate;
  SavingsAccount(super.accNum, super.balance, this.interestRate); //constructor
  //method of adding interest
  void addInterest() {
    _balance += _balance * interestRate;
  }
}

// Current Account has overdraft limit and inherit from Account
class CurrentAccount extends Account{
  double overdraftLimit;
  CurrentAccount(super.accNum, super.balance, this.overdraftLimit); //constructor
  @override
  void withdraw(double amount){
    if (isValidAmount(amount) && canWithdraw(_balance + overdraftLimit, amount)){
      _balance -= amount;
      _transactions.add(Transaction(_transactions.length+1, -amount, TransactionType.withdraw));
    }
    else{
      print("Enter a valid amount");
    }
  }
}


class Customer{
  int customerId;
  String name;
  List<Account> accounts = []; // This is an Association because logically "A customer has an account"

  Customer(this.customerId, this.name); //constructor
  //method to add object(account)
  void addAccount(Account account){
    accounts.add(account);
  }
}


class Transaction{
  int transactionId;
  double amount;
  TransactionType type;// enum
  Transaction(this.transactionId, this.amount, this.type); //constructor

  // this override is for making the object of Transaction appear in this way when printed
  @override
  String toString(){
    return "Transaction $transactionId : ${type.name} $amount";
  }
}
enum TransactionType{
  deposit,
  withdraw
}
abstract class AccountOperations{
  void deposit (double amount);
  void withdraw (double amount);
}
mixin Validation{
  bool isValidAmount(double amount){
    return amount > 0;
  }
}
mixin LimitChecker{
  bool canWithdraw(double balance, double amount){
    return amount <= balance;
  }
}