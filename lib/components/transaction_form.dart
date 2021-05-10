import 'package:expense/components/adaptative_date_picker.dart';
import 'package:expense/components/adaptative_text_field.dart';
import 'package:flutter/material.dart';

import 'addptative_button.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm({@required this.onSubmit});

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _titleControler = TextEditingController();
  final TextEditingController _valueControler = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleControler.text;
    final value = double.tryParse(_valueControler.text) ?? 0.0;
    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              AdaptativeTextField(
                controller: _titleControler,
                label: 'Titulo',
                onSubmitted: _submitForm(),
              ),
              AdaptativeTextField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                controller: _valueControler,
                label: 'Valor (R\$)',
                onSubmitted: _submitForm(),
              ),
              AdaptativeDatePIker(
                selectedDate: _selectedDate,
                onDateChanged: (newDate) {
                  setState(
                    () {
                      _selectedDate = newDate;
                    },
                  );
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptativeButton(
                    label: 'Nova Transação',
                    onPressed: _submitForm,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
