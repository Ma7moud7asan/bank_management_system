import 'bank_management_system.dart';
void main(){
  Customer customer1 = Customer(123, "Mahmoud");
  SavingsAccount acc1 = SavingsAccount(1, 10000, 0.1);
  customer1.addAccount(acc1);
  acc1.deposit(10000);
  acc1.addInterest();
  print("Account Balance: ${acc1.balance}");
  print("Account Transaction: ${acc1.transactions}");

}