import 'package:flutter/material.dart';

class SearchInputField extends StatelessWidget {
  final TextEditingController controller;
  final void Function(String) onSearch;

  const SearchInputField({
    super.key,
    required this.controller,
    required this.onSearch,
  });

  void _handleSearch(String value) {
    if (value.trim().isNotEmpty) {
      onSearch(value.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        onChanged: _handleSearch,
        onFieldSubmitted: _handleSearch,
        decoration: InputDecoration(
          hintText: "Enter ingredients name...",
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _handleSearch(controller.text),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
