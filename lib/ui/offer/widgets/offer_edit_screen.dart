import 'package:flutter/material.dart';
import 'offer_edit_form.dart';  // o form separado

class OfferEditScreen extends StatelessWidget {
  const OfferEditScreen({super.key});

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
          
          centerTitle: true,
        ),

        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: OfferEditForm(), // AQUI ENTRA O FORM
        ),
      ),
    );
  }
}
