import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/features/products/cubit/products_cubit.dart';



class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
            content: Text( 
              "Current state: ${context.read<ProductsCubit>().state}" , 
                style: TextStyle(fontSize: 18),),
          );
  }
}