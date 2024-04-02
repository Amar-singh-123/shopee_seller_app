void main(){
  var list = ['d','d','r','e','x','s'];
  var row = 2;
  var col = 3;
  var rowList = [];
  var colList = [];
  var str = "";
   list.forEach((item) {
     str+=item;
   });

  var d = list.indexWhere((element) => element == 'e');
   print(d);




}