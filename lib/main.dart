import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoList(),
      theme: ThemeData(
        primaryColor: Colors.deepPurple[800],
        brightness: Brightness.light,
      ),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<bool> chbox = [false, false, false, false];

  final List<String> tasks = ['Buy items', 'Bring the equipments'];

  final taskcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF6038D3),
        title: Center(
          child: Text(
            "My Todo's",
            style: GoogleFonts.nunito(
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: Key(tasks[index]),
              background: Container(
                alignment: AlignmentDirectional.centerEnd,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Icon(
                    Icons.delete,
                    color: Colors.redAccent,
                    size: 32.0,
                  ),
                ),
                color: Colors.grey[50],
              ),
              onDismissed: (_) {
                setState(() {
                  tasks.removeAt(index);
                  chbox.removeAt(index);
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                width: double.infinity,
                child: Card(
                  elevation: 5,
                  child: Row(children: [
                    Checkbox(
                        value: chbox[index],
                        activeColor: Color(0XFF6038D3),
                        onChanged: (bool newvalue) {
                          setState(() {
                            chbox[index] = newvalue;
                          });
                        }),
                    Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: _strikeThrough(
                            todoText: tasks[index], todoToggle: chbox[index]))
                  ]),
                ),
              ),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  color: Color(0xff757575),
                  child: Container(
                    padding: EdgeInsets.all(20.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextField(
                          style: TextStyle(fontSize: 18.0),
                          //autofocus: true,
                          controller: taskcontroller,
                          decoration: InputDecoration(
                              labelStyle: TextStyle(fontSize: 18.0),
                              labelText: 'Task',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              )),
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15.0),
                            color: Color(0XFF6038D3),
                          ),
                          child: FlatButton(
                            autofocus: true,
                            onPressed: () {
                              setState(() {
                                tasks.add(taskcontroller.text);
                                chbox.add(false);
                                taskcontroller.clear();
                              });

                              Navigator.of(context).pop();
                            },
                            child: Text(
                              'Add Task',
                              style: GoogleFonts.nunito(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        child: Icon(
          Icons.add,
          size: 42.0,
        ),
        backgroundColor: Color(0XFF6038D3),
        tooltip: 'New Task',
      ),
    );
  }
}

class _strikeThrough extends StatelessWidget {
  final bool todoToggle;
  String todoText;
  _strikeThrough({this.todoToggle, this.todoText}) : super();

  Widget _strikewidget() {
    if (todoToggle == false) {
      return Text(
        todoText,
        maxLines: 2,
        style: GoogleFonts.nunito(
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
      );
    } else {
      return Text(
        todoText,
        maxLines: 2,
        style: GoogleFonts.nunito(
            fontSize: 18.0,
            decoration: TextDecoration.lineThrough,
            color: Colors.grey,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.normal),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _strikewidget();
  }
}
