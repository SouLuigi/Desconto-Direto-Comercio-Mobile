import 'package:desconto_direto_comercio_mobile/ui/core/themes/colors.dart';
import 'package:desconto_direto_comercio_mobile/ui/profile/widgets/edit_form.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<StatefulWidget> createState() => EditProfileState();
}

class EditProfileState extends State<EditProfile> {



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Editar perfil",
          style: TextStyle(color: AppColors.Yellow1),
        ),

        centerTitle: true,
        backgroundColor: AppColors.Blue1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: EditCommerceForm(),
        ),
      ),
    );
  }
}
