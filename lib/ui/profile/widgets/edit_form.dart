import 'package:desconto_direto_comercio_mobile/data/model/commerce_model.dart';
import 'package:desconto_direto_comercio_mobile/ui/core/ui/widget_button.dart';
import 'package:desconto_direto_comercio_mobile/ui/core/ui/widget_dropdown.dart';
import 'package:desconto_direto_comercio_mobile/ui/core/ui/widget_textField.dart';
import 'package:desconto_direto_comercio_mobile/ui/profile/viewmodel/edit_profile_viewmodel.dart';
import 'package:desconto_direto_comercio_mobile/ui/profile/widgets/widget_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class EditCommerceForm extends StatefulWidget {
  const EditCommerceForm({super.key});

  @override
  State<EditCommerceForm> createState() => _EditCommerceFormState();
}

class _EditCommerceFormState extends State<EditCommerceForm> {
  final formKey = GlobalKey<FormBuilderState>();
  final viewModel = EditProfileViewModel();

  final _nomeController = TextEditingController();

  final _telefoneController = TextEditingController();
  final _telefoneCelularController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _bairroController = TextEditingController();
  final _cepController = TextEditingController();
  final _instagramController = TextEditingController();
  final _aberturaController = TextEditingController();

  final _fechamentoController = TextEditingController();

  String? _categoria;
  String? _fazEntrega;
  TimeOfDay? horarioEntrada;
  TimeOfDay? horarioFechamento;

  @override
  void initState() {
    super.initState();
    viewModel.loadCommerce();
    viewModel.addListener(_onViewModelChanged);
  }

  void _onViewModelChanged() {
    if (!viewModel.isLoading && viewModel.commerce != null) {
      final commerce = viewModel.commerce!;

      // Verificamos se o nome está vazio para garantir que é a primeira carga
      // e não sobrescrever edições do usuário se a tela reconstruir.
      if (_nomeController.text.isEmpty) {
        // 1. Campos de Texto Simples
        _nomeController.text = commerce.nome;
        _telefoneController.text = commerce.telefone ?? '';
        _telefoneCelularController.text =
            commerce.telefoneCelular ?? ''; // Verifique o nome no seu Model
        _enderecoController.text = commerce.endereco ?? '';
        _bairroController.text = commerce.bairro ?? '';
        _cepController.text = commerce.cep ?? '';
        _instagramController.text = commerce.instagram ?? '';

        // 2. Atualizando Dropdowns e Horários (precisa de setState)
        setState(() {
          // Dropdown Categoria
          // Certifique-se que a string 'commerce.categoria' existe exatametne na lista '_categories'
          if (viewModel.categories.contains(commerce.categoria)) {
            _categoria = commerce.categoria;
          }

          // Dropdown Delivery (Lógica de conversão Bool -> String)
          // Supondo que no seu Model 'fazEntrega' seja um bool
          // Se for string, ajuste conforme necessário
          _fazEntrega = (commerce.fazEntrega == true) ? 'Sim' : 'Não';

          // 3. Horários (Complexidade Extra: String -> Controller + TimeOfDay)
          if (commerce.horarioAbertura != null) {
            // 1. Converte DateTime do banco para TimeOfDay (para o relógio funcionar)
            horarioEntrada = TimeOfDay.fromDateTime(commerce.horarioAbertura!);

            // 2. Converte para String para mostrar no Input
            _aberturaController.text = _formatTimeOfDay(horarioEntrada!);
          }

          if (commerce.horarioFechamento != null) {
            horarioFechamento = TimeOfDay.fromDateTime(
              commerce.horarioFechamento!,
            );
            _fechamentoController.text = _formatTimeOfDay(horarioFechamento!);
          }
        });
      }
    }
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  DateTime? _timeOfDayToDateTime(TimeOfDay? time) {
    if (time == null) return null;
    final now = DateTime.now();
    // Cria um DateTime com a data de hoje, mas com a hora selecionada
    return DateTime(now.year, now.month, now.day, time.hour, time.minute);
  }

  @override
  void dispose() {
    viewModel.removeListener(
      _onViewModelChanged,
    ); // Importante remover o listener
    _nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: viewModel,
      builder: (context, child) {
        if (viewModel.commerce == null) {
          return const Center(child: CircularProgressIndicator());
        }
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

        return FormBuilder(
          key: formKey,
          child: Column(
            spacing: 5,
            children: [
              CustomInput(label: 'Nome', controller: _nomeController),
              CustomDropdown(
                label: 'Categoria',
                items: viewModel.categories,
                value: _categoria,
                onChanged: (value) => setState(() => _categoria = value),
              ),
              CustomInput(label: 'Telefone', controller: _telefoneController),
              CustomInput(
                label: 'Telefone Celular',
                controller: _telefoneCelularController,
              ),
              CustomInput(label: 'Endereço', controller: _enderecoController),
              CustomInput(label: 'Bairro', controller: _bairroController),
              CustomInput(label: 'CEP', controller: _cepController),
              CustomInput(label: 'Instagram', controller: _instagramController),
              CustomDropdown(
                label: 'Delivery?',
                items: viewModel.delivery,
                onChanged: (value) => setState(() => _fazEntrega = value),
              ),
              CustomTimePicker(
                label: 'Horário de abertura',
                controller: _aberturaController,
                onTimeSelected: (time) => setState(() => horarioEntrada = time),
              ),
              CustomTimePicker(
                label: 'Horário de fechamento',
                controller: _fechamentoController,
                onTimeSelected: (time) =>
                    setState(() => horarioFechamento = time),
              ),
              WidgetButton(
                text: 'Salvar',
                onPressed: () async {
                  final commerceAtualizado = Commerce(
                    id: viewModel.commerce!.id,
                    nome: _nomeController.text,
                    categoria: _categoria ?? '',
                    telefone: _telefoneController.text,
                    telefoneCelular: _telefoneCelularController.text,
                    endereco: _enderecoController.text,
                    bairro: _bairroController.text,
                    cep: _cepController.text,
                    instagram: _instagramController.text,
                    fazEntrega: _fazEntrega == 'Sim',
                    horarioAbertura: _timeOfDayToDateTime(horarioEntrada),
                    horarioFechamento: _timeOfDayToDateTime(horarioFechamento),
                    email: viewModel.commerce!.email,
                    senha: viewModel.commerce!.senha,
                  );
                  await viewModel.updateCommerce(commerceAtualizado);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
