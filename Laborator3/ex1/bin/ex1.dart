import 'package:ex1/ex1.dart' as ex1;
class Queue{
  var l=<int>[];
  print(){
    return l;
  }
  void push(var param){
    l.add(param);
  }
   void pop(){
    l.removeAt(0);
   } 
   back(){
    return l[l.length-1];
   } 
   front(){
    return l[0];
   } 
   bool isEmpty(){
    if(l.length==0){
      return true;
    }else{
      return false;
    }
   }
}
void main(List<String> arguments) {
  var q=Queue();
  q.push(1);
  q.push(2);
  print(q.print());
  print("Elementul de la inceputul cozii este:${q.front()}");
  print("Elementul de la finalul cozii este:${q.back()}");
  q.pop();
  print(q.print());
  print(q.isEmpty());
  q.pop();
  print(q.isEmpty());

}
