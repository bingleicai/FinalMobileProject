import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'models/customer.dart';
import 'generated/l10n.dart';

class CustomerFormPage extends StatefulWidget {
  final Customer? customer;
  final VoidCallback onSave;
  final VoidCallback onCancel;

  CustomerFormPage({this.customer, required this.onSave, required this.onCancel});

  @override
  _CustomerFormPageState createState() => _CustomerFormPageState();
}

class _CustomerFormPageState extends State<CustomerFormPage> {
  final _formKey = GlobalKey<FormState>();
  late String _firstName;
  late String _lastName;
  late String _address;
  late String _birthday;
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _firstName = widget.customer?.firstName ?? '';
    _lastName = widget.customer?.lastName ?? '';
    _address = widget.customer?.address ?? '';
    _birthday = widget.customer?.birthday ?? '';
  }

  Future<void> _saveCustomer() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Customer customer = Customer(
        id: widget.customer?.id,
        firstName: _firstName,
        lastName: _lastName,
        address: _address,
        birthday: _birthday,
      );
      bool isNew = widget.customer == null;
      if (isNew) {
        await _databaseHelper.insertCustomer(customer);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).customerAdded)),
        );
      } else {
        await _databaseHelper.updateCustomer(customer);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(S.of(context).customerUpdated)),
        );
      }
      widget.onSave();
      if (MediaQuery.of(context).size.width <= 600) {
        Navigator.pop(context, true); // Navigate back to CustomerListPage on mobile
      }
    } else {
      _showAlertDialog(S.of(context).error, S.of(context).fillAllFields);
    }
  }

  Future<void> _deleteCustomer() async {
    if (widget.customer != null) {
      await _databaseHelper.deleteCustomer(widget.customer!.id!);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).customerDeleted)),
      );
      widget.onSave();
      if (MediaQuery.of(context).size.width <= 600) {
        Navigator.pop(context, true); // Navigate back to CustomerListPage on mobile
      }
    }
  }

  Future<void> _showAlertDialog(String title, String message) async {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text(S.of(context).ok),
              onPressed: () {
                Navigator.of(context).pop();
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
      appBar: AppBar(
        title: Text(widget.customer == null
            ? S.of(context).addCustomer
            : S.of(context).editCustomer),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _firstName,
                decoration: InputDecoration(labelText: S.of(context).firstName),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).fieldRequired;
                  }
                  return null;
                },
                onSaved: (value) {
                  _firstName = value!;
                },
              ),
              TextFormField(
                initialValue: _lastName,
                decoration: InputDecoration(labelText: S.of(context).lastName),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).fieldRequired;
                  }
                  return null;
                },
                onSaved: (value) {
                  _lastName = value!;
                },
              ),
              TextFormField(
                initialValue: _address,
                decoration: InputDecoration(labelText: S.of(context).address),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).fieldRequired;
                  }
                  return null;
                },
                onSaved: (value) {
                  _address = value!;
                },
              ),
              TextFormField(
                initialValue: _birthday,
                decoration: InputDecoration(labelText: S.of(context).birthday),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return S.of(context).fieldRequired;
                  }
                  return null;
                },
                onSaved: (value) {
                  _birthday = value!;
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _saveCustomer,
                    child: Text(S.of(context).save),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      widget.onCancel();
                      if (MediaQuery.of(context).size.width <= 600) {
                        Navigator.pop(context); // Navigate back to CustomerListPage on mobile
                      }
                    },
                    child: Text(S.of(context).cancel),
                  ),
                  if (widget.customer != null) ...[
                    SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _deleteCustomer,
                      child: Text(S.of(context).delete),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
