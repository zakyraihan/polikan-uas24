import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/tambah_poli_controller.dart';

class TambahPoliView extends GetView<TambahPoliController> {
  const TambahPoliView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Poli'),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: TambahPoliForm(),
      ),
    );
  }
}

class TambahPoliForm extends StatefulWidget {
  const TambahPoliForm({super.key});

  @override
  _TambahPoliFormState createState() => _TambahPoliFormState();
}

class _TambahPoliFormState extends State<TambahPoliForm> {
  final controller = Get.put(TambahPoliController());
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    controller.namaDokterController.dispose();
    controller.spesialisController.dispose();
    controller.lokasiController.dispose();
    controller.kontakController.dispose();
    controller.informasiTambahanController.dispose();
    super.dispose();
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != controller.selectedDate) {
      setState(() {
        controller.selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        children: <Widget>[
          _buildTextField(
            controller: controller.namaDokterController,
            label: 'Nama Dokter',
          ),
          _buildTextField(
            controller: controller.spesialisController,
            label: 'Spesialis',
          ),
          _buildDatePickerField(context),
          _buildTextField(
            controller: controller.lokasiController,
            label: 'Lokasi',
          ),
          _buildTextField(
            controller: controller.kontakController,
            label: 'Kontak',
          ),
          _buildTextField(
            controller: controller.informasiTambahanController,
            label: 'Informasi Tambahan',
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                // Handle form submission
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDatePickerField(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () => _selectDate(context),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: 'Jam Praktek',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                controller.selectedDate == null
                    ? 'Select Date'
                    : '${controller.selectedDate!.day}/${controller.selectedDate!.month}/${controller.selectedDate!.year}',
                style: const TextStyle(fontSize: 16),
              ),
              const Icon(Icons.calendar_today),
            ],
          ),
        ),
      ),
    );
  }
}
