import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
class HiveTodo extends StatefulWidget {


  @override
  State<HiveTodo> createState() => _HiveTodoState();
}

class _HiveTodoState extends State<HiveTodo> {

  TextEditingController list=TextEditingController();
  List<String> todoitems=[];
  late Box box;
  @override
  void initState(){
    super.initState();
  box = Hive.box('mybox');
    loadtodoitem();
  }
  loadtodoitem() async{
    List <String>? tasks=box.get('todoitems')?.cast <String>();
    if(tasks != null){
    setState(() {
      todoitems=tasks;
    });
  }
  }
  savedtodoitems()async{
    box.put('todoitems', todoitems);
  }
  void _addtodoitem(String task){
    if(task.isNotEmpty){
    setState(() {
    todoitems.add(task);

    });
    savedtodoitems();
      list.clear();
    }
    }
    
  void _removetodoitems(int index){
    setState(() {
      todoitems.removeAt(index);
    });
    savedtodoitems();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 151, 213, 240),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: 
        Text("HIVE WITH TODO",style: TextStyle(color: Colors.red),),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 60,
                width: 400,
                child: TextField(
                  controller: list,
                  decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),),
                  
              ),
              SizedBox(height: 20),
              ElevatedButton(onPressed: (){
                _addtodoitem(list.text);
              }, child: Icon(Icons.add)),
              Expanded(child: ListView.builder(
                itemCount: todoitems.length,
                itemBuilder: (context,index){
                return ListTile(
                  title: Text(todoitems[index]),
                  trailing: GestureDetector(
                    onTap:(){
                      _removetodoitems(index);
                  
                    
                  },child:Icon(Icons.delete)),
                );
              }))
            ],
          ),
        ),
      ),
    );
  }
}