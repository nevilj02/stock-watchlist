import 'package:flutter/material.dart';

class SearchResultTile extends StatelessWidget {
  final String result;
  final VoidCallback onTap;
  const SearchResultTile({required this.result, required this.onTap, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(result),
      onTap: onTap,
    );
  }
} 