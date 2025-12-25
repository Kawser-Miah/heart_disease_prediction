import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/assessment_bloc.dart';
import '../blocs/assessment_event.dart';
import '../models/health_assessment.dart';
import '../config/app_colors.dart';
import '../config/app_constants.dart';
import '../utils/helpers.dart';
import 'analyzing_screen.dart';

class CheckScreen extends StatefulWidget {
  const CheckScreen({super.key});

  @override
  State<CheckScreen> createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  final _formKey = GlobalKey<FormState>();
  final _scrollController = ScrollController();

  // Form controllers
  final _ageController = TextEditingController();
  final _bpController = TextEditingController();
  final _cholesterolController = TextEditingController();
  final _heartRateController = TextEditingController();
  final _stDepressionController = TextEditingController();

  // Form data
  FormData _formData = const FormData();

  @override
  void dispose() {
    _ageController.dispose();
    _bpController.dispose();
    _cholesterolController.dispose();
    _heartRateController.dispose();
    _stDepressionController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final formData = FormData(
        age: _ageController.text,
        sex: _formData.sex,
        chestPainType: _formData.chestPainType,
        exerciseInducedAngina: _formData.exerciseInducedAngina,
        stDepression: _stDepressionController.text,
        restingBP: _bpController.text,
        cholesterol: _cholesterolController.text,
        maxHeartRate: _heartRateController.text,
        fastingBloodSugar: _formData.fastingBloodSugar,
        restingECG: _formData.restingECG,
        stSlope: _formData.stSlope,
        numVessels: _formData.numVessels,
        thalassemia: _formData.thalassemia,
      );

      context.read<AssessmentBloc>().add(SubmitAssessment(formData));

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const AnalyzingScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all required fields correctly'),
          backgroundColor: AppColors.redDark,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heart Health Check'),
        backgroundColor: AppColors.teal600,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          controller: _scrollController,
          padding: const EdgeInsets.all(24),
          children: [
            const Text(
              'Please provide accurate information for a reliable assessment',
              style: TextStyle(fontSize: 14, color: AppColors.gray600),
            ),
            const SizedBox(height: 24),

            // Section 1: Personal Information
            _buildSectionHeader('Personal Information', Icons.person),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _ageController,
              label: 'Age',
              hint: 'Enter your age',
              keyboardType: TextInputType.number,
              validator: Validators.validateAge,
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              label: 'Sex',
              value: _formData.sex.isEmpty ? null : _formData.sex,
              items: AppConstants.sexOptions,
              onChanged: (value) {
                setState(() {
                  _formData = _formData.copyWith(sex: value);
                });
              },
            ),
            const SizedBox(height: 32),

            // Section 2: Symptoms & History
            _buildSectionHeader('Symptoms & History', Icons.medical_services),
            const SizedBox(height: 16),
            _buildDropdown(
              label: 'Chest Pain Type',
              value: _formData.chestPainType.isEmpty
                  ? null
                  : _formData.chestPainType,
              items: AppConstants.chestPainTypes,
              onChanged: (value) {
                setState(() {
                  _formData = _formData.copyWith(chestPainType: value);
                });
              },
              validator: (value) =>
                  value == null ? 'Please select chest pain type' : null,
            ),
            const SizedBox(height: 16),
            _buildSwitchTile(
              title: 'Exercise-Induced Angina',
              subtitle: 'Do you experience chest pain during exercise?',
              value: _formData.exerciseInducedAngina,
              onChanged: (value) {
                setState(() {
                  _formData = _formData.copyWith(exerciseInducedAngina: value);
                });
              },
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _stDepressionController,
              label: 'ST Depression',
              hint: 'Enter ST depression value (e.g., 2.5)',
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: Validators.validateSTDepression,
              helperText: 'ST depression induced by exercise relative to rest',
            ),
            const SizedBox(height: 32),

            // Section 3: Medical Measurements
            _buildSectionHeader('Medical Measurements', Icons.monitor_heart),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _bpController,
              label: 'Resting Blood Pressure',
              hint: 'Enter BP in mmHg',
              keyboardType: TextInputType.number,
              validator: Validators.validateBloodPressure,
              suffixText: 'mmHg',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _cholesterolController,
              label: 'Serum Cholesterol',
              hint: 'Enter cholesterol level',
              keyboardType: TextInputType.number,
              validator: Validators.validateCholesterol,
              suffixText: 'mg/dL',
            ),
            const SizedBox(height: 16),
            _buildTextField(
              controller: _heartRateController,
              label: 'Maximum Heart Rate',
              hint: 'Enter max heart rate achieved',
              keyboardType: TextInputType.number,
              validator: Validators.validateHeartRate,
              suffixText: 'bpm',
            ),
            const SizedBox(height: 32),

            // Section 4: Test Results
            _buildSectionHeader('Test Results', Icons.assignment),
            const SizedBox(height: 16),
            _buildSwitchTile(
              title: 'Fasting Blood Sugar > 120 mg/dL',
              subtitle: 'Is your fasting blood sugar elevated?',
              value: _formData.fastingBloodSugar,
              onChanged: (value) {
                setState(() {
                  _formData = _formData.copyWith(fastingBloodSugar: value);
                });
              },
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              label: 'Resting ECG Results',
              value: _formData.restingECG.isEmpty ? null : _formData.restingECG,
              items: AppConstants.restingECGTypes,
              onChanged: (value) {
                setState(() {
                  _formData = _formData.copyWith(restingECG: value);
                });
              },
              validator: (value) =>
                  value == null ? 'Please select ECG result' : null,
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              label: 'ST Slope',
              value: _formData.stSlope.isEmpty ? null : _formData.stSlope,
              items: AppConstants.stSlopeTypes,
              onChanged: (value) {
                setState(() {
                  _formData = _formData.copyWith(stSlope: value);
                });
              },
              validator: (value) =>
                  value == null ? 'Please select ST slope' : null,
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              label: 'Number of Major Vessels',
              value: _formData.numVessels.isEmpty ? null : _formData.numVessels,
              items: {for (var v in AppConstants.numVesselsOptions) v: v},
              onChanged: (value) {
                setState(() {
                  _formData = _formData.copyWith(numVessels: value);
                });
              },
              validator: (value) =>
                  value == null ? 'Please select number of vessels' : null,
              helperText:
                  'Number of major vessels colored by fluoroscopy (0-4)',
            ),
            const SizedBox(height: 16),
            _buildDropdown(
              label: 'Thalassemia',
              value: _formData.thalassemia.isEmpty
                  ? null
                  : _formData.thalassemia,
              items: AppConstants.thalassemiaTypes,
              onChanged: (value) {
                setState(() {
                  _formData = _formData.copyWith(thalassemia: value);
                });
              },
              validator: (value) =>
                  value == null ? 'Please select thalassemia type' : null,
            ),
            const SizedBox(height: 32),

            // Submit Button
            ElevatedButton(
              onPressed: _submitForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.teal600,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
              ),
              child: const Text(
                'Analyze Heart Health',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 16),

            // Disclaimer
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.teal50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: AppColors.teal600,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'This assessment is for informational purposes only and should not replace professional medical advice.',
                      style: TextStyle(fontSize: 12, color: AppColors.gray700),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.teal50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.teal600, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.tealDark,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    String? helperText,
    String? suffixText,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        helperText: helperText,
        suffixText: suffixText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.gray300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.teal600, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.redDark),
        ),
        filled: true,
        fillColor: AppColors.gray50,
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required Map<String, String> items,
    required void Function(String?) onChanged,
    String? Function(String?)? validator,
    String? helperText,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        helperText: helperText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.gray300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.teal600, width: 2),
        ),
        filled: true,
        fillColor: AppColors.gray50,
      ),
      items: items.entries.map((entry) {
        return DropdownMenuItem<String>(
          value: entry.key,
          child: Text(entry.value),
        );
      }).toList(),
      onChanged: onChanged,
      validator: validator,
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required void Function(bool) onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.gray50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.gray300),
      ),
      child: SwitchListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(
          subtitle,
          style: const TextStyle(fontSize: 12, color: AppColors.gray600),
        ),
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.teal600,
      ),
    );
  }
}
