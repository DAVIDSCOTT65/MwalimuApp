import 'package:ag_professeur/interfaces/courspage.dart';
import 'package:ag_professeur/interfaces/timerinterface.dart';
import 'package:flutter/material.dart';
import 'package:ag_professeur/interfaces/mescours.dart';

class CoursListe extends StatefulWidget {
  final List<MesCours> coursdata;
  CoursListe(this.coursdata, {Key key});

  @override
  _CoursListeState createState() => _CoursListeState();
}

class _CoursListeState extends State<CoursListe> {


  
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount:
              MediaQuery.of(context).orientation == Orientation.landscape
                  ? 2
                  : 3),
      itemCount: widget.coursdata.length == null ? 0 : widget.coursdata.length,
      itemBuilder: (BuildContext context, int i) {
        return GestureDetector(
          onTap: (){
            //Navigator.push(context, TimerInterface());
            Navigator.of(context).push(MaterialPageRoute(builder: 
        (BuildContext context)=> new TimerInterface(widget.coursdata[i].intitule,)));
          },
          child: Card(
            color: Colors.purple,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(8.0),
                    width: double.infinity,
                    
                    child: Text(
                      
                      widget.coursdata[i].intitule,
                      
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.white),
                    )
                  ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Type : " + widget.coursdata[i].type,
                        style: TextStyle(fontSize: 9.0, color: Colors.white),
                        
                      ),
                      
                    ),
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                Padding(
                  
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Volume : ${widget.coursdata[i].objectif} h",
                      style: TextStyle(fontSize: 14.0, color: Colors.white),
                      
                    )),
                    
              ],
              
            ),
            
          ),
        );
      },
    );
  }
}
