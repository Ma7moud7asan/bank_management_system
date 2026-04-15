import 'bank_management_system.dart';
void main(){
  Customer customer1 = Customer(123, "Mahmoud");
  print("Customer Name: ${customer1.name}");
  SavingsAccount acc1 = SavingsAccount(1, 10000, 0.1);
  customer1.addAccount(acc1);
  print("Account Balance: ${acc1.balance}");
  acc1.deposit(10000); // this can be an abstraction as the complex details are hidden
  print("deposited");
  acc1.addInterest();
  print("Account Balance: ${acc1.balance}");
  print("Account Transactions: ${acc1.transactions}");

}