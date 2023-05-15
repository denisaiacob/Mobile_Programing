// primele 100 nr prime
void main(){
    var i=1;
    var n=100;
    while(n!=0){
        i++;  
        var p=1;
        for(var j=2;j<=i/2;j++){
          if(i%j==0) p=0;
        }
        if(p==1){
            print(i);
            n--;
        }
    }
}

// ex2
void main(){
  String s="Exemplu  de fraza.";
  var start=0;
  for(int i=0;i<s.length;i++){
    var word="";
    if(s[i]==" "|| s[i]==","|| s[i]=="."){
      for(int j=start;j<i;j++){
        word= word+ s[j];
      }
      print(word);
      while(s[i]==" ") i++;
      start=i;
    }
  }
}