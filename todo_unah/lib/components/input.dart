import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatefulWidget{
  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final bool escondible;

  bool estaVisible = false;

  Input({
    super.key,
    required this.label,
    required this.controller,
    this.escondible = false,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: !widget.estaVisible,
      keyboardType: widget.keyboardType ,
      decoration: InputDecoration(
        label: Text(widget.label),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(color: Colors.grey[400]!),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        suffixIcon: widget.escondible ? IconButton(
                    icon: Icon(
                      !widget.estaVisible ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        widget.estaVisible = !widget.estaVisible;
                      });
                    },
                  ) : null,),
    );
  }
}