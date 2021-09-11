import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final Function onSubmitText;
  const SearchWidget({Key? key, required this.onSubmitText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: Colors.white,
      style: const TextStyle(color: Colors.white),
      decoration: const InputDecoration.collapsed(
          hintText: 'Search', hintStyle: TextStyle(color: Colors.white60)),
      autofocus: true,
      onSubmitted: (text) => onSubmitText(text),
    );
  }
}
