import 'package:ex2/ex2.dart' as ex2;
class Client{
  var _Name;
  double _PurchasesAmount=0;
  Client():_Name='Denisa'{}
  double getPA(){
    return _PurchasesAmount;
  }
  void add(double param){
    _PurchasesAmount+=param;
  }
}
class LoyalClient extends Client{
  double _PurchasesAmount=0;
  double getPALoyalClient(){
    return _PurchasesAmount;
  }
  void discount(){
    var val=getPA();
    _PurchasesAmount=val-(0.1*val);
  }
}
void main(List<String> arguments) {
  var c1=LoyalClient();
  c1.add(100);
  c1.discount();
  print(c1.getPALoyalClient());
}
