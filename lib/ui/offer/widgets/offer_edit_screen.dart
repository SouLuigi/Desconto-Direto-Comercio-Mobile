import 'package:flutter/material.dart';
import '../../core/themes/colors.dart';
import 'offer_edit_form.dart';

class OfferEditScreen extends StatelessWidget {
  const OfferEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: OfferEditForm(),
        ),
      ),
    );
  }
}
