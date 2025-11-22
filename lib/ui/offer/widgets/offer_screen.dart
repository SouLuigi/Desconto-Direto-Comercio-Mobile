import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'offer_edit_form.dart';

class OfferScreen extends StatelessWidget {
  const OfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor :CupertinoColors.activeBlue,
        body: Column(
          children: [
            const SizedBox(height: 30),
            Center(
              child: Image.asset(
                'assets/Logo.png',
                width: 200,
                height: 200,
                fit: BoxFit.scaleDown,
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: CupertinoColors.systemYellow,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: const SingleChildScrollView(
                  child: OfferEditForm(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
