import 'package:flutter/material.dart';

class ErrorProducts extends StatelessWidget {

  final String message ;
  final VoidCallback onRety; 

  const ErrorProducts({super.key,required this.message,required this.onRety});
 

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(padding: EdgeInsets.all(24.0),
                    child:Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(message,style: TextStyle(fontSize: 16,color: Colors.red),textAlign: TextAlign.center,),

                        SizedBox(height: 12,),
                        ElevatedButton(onPressed: onRety, child: Text("Retry"))
                      ],
                    )),
    );
  }
}