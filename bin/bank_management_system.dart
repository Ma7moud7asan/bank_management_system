class Account{
  int accNum;
  double _balance;
  final List<Transaction> _transactions = [];
  Account(this.accNum, double balance) : _balance = balance;
  void deposit(double amount){
    _balance += amount;
    _transactions.add(Transaction(_transactions.length+1, amount));
  }
  void withdraw(double amount){
    if (amount <= _balance){
      _balance -= amount;
      _transactions.add(Transaction(_transactions.length+1, -amount));
    }
    else{
      print("Enter a valid amount");
    }
  }
  double get balance => _balance;
  List<Transaction> get transactions => _transactions;
}
class SavingsAccount extends Account{
  double interestRate;
  SavingsAccount(super.accNum, super.balance, this.interestRate);
  void addInterest() {
    _balance += _balance * interestRate;
  }
}
class CurrentAccount extends Account{
  double overdraftLimit;
  CurrentAccount(super.accNum, super.balance, this.overdraftLimit);
  @override
  void withdraw(double amount){
    if (amount <= _balance + overdraftLimit){
      _balance -= amount;
      _transactions.add(Transaction(_transactions.length+1, -amount));
    }
    else{
      print("Enter a valid amount");
    }
  }
}
class Customer{
  int customerId;
  String name;
  List<Account> accounts = [];

  Customer(this.customerId, this.name);

  void addAccount(Account account){
    accounts.add(account);
  }
}
class Transaction{
  int transactionId;
  double amount;
  Transaction(this.transactionId, this.amount);
  @override
  String toString(){
    return "Transaction $transactionId : $amount";
  }
}