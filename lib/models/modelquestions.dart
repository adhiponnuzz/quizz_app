//create a simple class
class Question{
  final String id;
  final String title;
  final Map<String, bool>options;

  //create constructor
 Question({
   required this.id,
   required this.title,
   required this.options,
 });

 //override the toString method to print the question on console
@override
  String toString(){
  return 'Question(id: $id,title:$title,options:$options)';
}

}