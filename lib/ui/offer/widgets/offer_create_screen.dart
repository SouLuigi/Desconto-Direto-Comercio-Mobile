import 'package:flutter/material.dart';
import 'offer_create_form.dart';

class OfferCreateScreen extends StatelessWidget {
  const OfferCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: const Color(0xFF003049),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: OfferCreateForm(),
        ),
      ),
    );
  }
}
