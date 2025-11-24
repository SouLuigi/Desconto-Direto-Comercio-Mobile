import 'package:desconto_direto_comercio_mobile/routing/routes.dart';
import 'package:desconto_direto_comercio_mobile/ui/core/themes/colors.dart';
import 'package:desconto_direto_comercio_mobile/ui/core/ui/widget_button.dart';
import 'package:desconto_direto_comercio_mobile/ui/profile/viewmodel/profile_viewmodel.dart';
import 'package:desconto_direto_comercio_mobile/ui/profile/widgets/info_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final viewModel = ProfileViewModel();

  @override
  void initState() {
    super.initState();
    viewModel.loadCommerce();
  }

  Future<void> _confirmarExclusao(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Excluir conta'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Tem certeza que deseja excluir sua conta?'),
                SizedBox(height: 10),
                Text(
                  'Essa ação é irreversível e todos os seus dados serão perdidos.',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancelar',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(ctx).pop(); // Fecha o modal
              },
            ),

            TextButton(
              child: const Text(
                'Sim, excluir',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () async {
                Navigator.of(ctx).pop();

                await viewModel.deleteAccount();

                if (mounted) {
                  context.push(Routes.auth);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fundo geral branco
      appBar: AppBar(
        backgroundColor: AppColors.Blue1,
        title: const Text('Meu perfil', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.Yellow1),
      ),
      body: ListenableBuilder(
        listenable: viewModel,
        builder: (context, child) {
          // 1. LOADING
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. ERROR
          if (viewModel.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    viewModel.errorMessage!,
                    style: const TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: viewModel.loadCommerce,
                    child: const Text("Tentar Novamente"),
                  ),
                ],
              ),
            );
          }

          final commerce = viewModel.commerce;

          if (commerce == null) {
            return const Center(child: Text("Nenhum dado encontrado."));
          }
          final bool hasValidImage =
              commerce.fotoUrl != null && commerce.fotoUrl!.isNotEmpty;

          return Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 40,
                ),
                width: double.infinity,
                color: AppColors.Orange1,

                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: AppColors.Yellow1,

                      backgroundImage: hasValidImage
                          ? NetworkImage(commerce.fotoUrl!)
                          : null,
                      child: !hasValidImage
                          ? Text(
                              commerce.nome.isNotEmpty
                                  ? commerce.nome[0].toUpperCase()
                                  : '?',
                              style: const TextStyle(
                                fontSize: 20,
                                color: AppColors.Blue1,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            commerce.nome,
                            style: GoogleFonts.kaiseiDecol(
                              textStyle: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Text(
                            commerce.categoria,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      // Efeito visual: Borda arredondada subindo no laranja
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    // O transform sobe o container branco para cima do laranja (-20 pixels)
                    transform: Matrix4.translationValues(0, -20, 0),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Expanded(
                              child: Column(
                                spacing: 5,
                                children: [
                                  InfoItemWidget(
                                    icon: Symbols.location_pin,
                                    label: 'Endereco',
                                    value: commerce.endereco ?? "Não informado",
                                  ),
                                  InfoItemWidget(
                                    icon: Symbols.location_city,
                                    label: 'CEP',
                                    value: commerce.cep ?? "Não informado",
                                  ),
                                  InfoItemWidget(
                                    icon: Symbols.phone,
                                    label: 'Telefone',
                                    value: commerce.telefone ?? "Não informado",
                                  ),
                                  InfoItemWidget(
                                    icon: Symbols.phone_android,
                                    label: 'Whatsapp',
                                    value: commerce.cep ?? "Não informado",
                                  ),
                                  InfoItemWidget(
                                    icon: Symbols.account_box,
                                    label: 'Instagram',
                                    value:
                                        commerce.instagram ?? "Não informado",
                                  ),
                                  InfoItemWidget(
                                    icon: Symbols.store,
                                    label: 'Funcionamentos',
                                    value:
                                        (commerce.horarioAbertura != null &&
                                            commerce.horarioFechamento != null)
                                        ? '${commerce.horarioAbertura} às ${commerce.horarioFechamento}'
                                        : 'Não informado',
                                  ),
                                  InfoItemWidget(
                                    icon: Symbols.delivery_truck_speed,
                                    label: 'Faz Entrega?',
                                    value: commerce.fazEntrega == true
                                        ? 'Sim'
                                        : 'Não',
                                  ),
                                  WidgetButton(
                                    text: 'Editar perfil',
                                    onPressed: () =>
                                        context.push(Routes.editProfile),
                                    color: AppColors.Yellow1,
                                  ),
                                  WidgetButton(
                                    text: 'Deletar minha conta',
                                    onPressed: () =>
                                        _confirmarExclusao(context),
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
