import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'generated/l10n.dart';
import 'customer_form_page.dart';
import 'models/customer.dart';

class CustomerListPage extends StatefulWidget {
  @override
  _CustomerListPageState createState() => _CustomerListPageState();
}

class _CustomerListPageState extends State<CustomerListPage> {
  List<Customer> _customers = [];
  Customer? _selectedCustomer;
  bool _isAddingCustomer = false;
  DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadCustomers();
  }

  Future<void> _loadCustomers() async {
    List<Customer> customers = await _databaseHelper.getCustomers();
    setState(() {
      _customers = customers;
    });
    if (_customers.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(S.of(context).noCustomersFound)),
      );
    }
  }

  void _navigateToAddCustomer() {
    if (MediaQuery.of(context).size.width > 600) {
      setState(() {
        _isAddingCustomer = true;
        _selectedCustomer = null;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CustomerFormPage(
            customer: null,
            onSave: _handleFormSave,
            onCancel: _handleFormCancel,
          ),
        ),
      ).then((value) {
        if (value == true) {
          _loadCustomers();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).customerAdded)),
          );
        }
      });
    }
  }

  void _navigateToEditCustomer(Customer customer) {
    if (MediaQuery.of(context).size.width > 600) {
      setState(() {
        _isAddingCustomer = false;
        _selectedCustomer = customer;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CustomerFormPage(
            customer: customer,
            onSave: _handleFormSave,
            onCancel: _handleFormCancel,
          ),
        ),
      ).then((value) {
        if (value == true) {
          _loadCustomers();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(S.of(context).customerEdited)),
          );
        }
      });
    }
  }

  void _handleFormSave() {
    _loadCustomers();
    setState(() {
      _isAddingCustomer = false;
      _selectedCustomer = null;
    });
  }

  void _handleFormCancel() {
    setState(() {
      _isAddingCustomer = false;
      _selectedCustomer = null;
    });
  }

  Future<void> _handleCustomerDelete(Customer customer) async {
    await _databaseHelper.deleteCustomer(customer.id!);
    _loadCustomers();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(S.of(context).customerDeleted)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // Tablet/Desktop Layout
          return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).customers),
            ),
            body: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ListView.builder(
                    itemCount: _customers.length,
                    itemBuilder: (context, index) {
                      final customer = _customers[index];
                      return ListTile(
                        title: Text('${customer.firstName} ${customer.lastName}'),
                        onTap: () => _navigateToEditCustomer(customer),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            final confirmed = await _showAlertDialog(
                              S.of(context).deleteCustomer,
                              S.of(context).confirmDelete,
                            );
                            if (confirmed == true) {
                              _handleCustomerDelete(customer);
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
                if (_isAddingCustomer || _selectedCustomer != null)
                  Expanded(
                    flex: 3,
                    child: CustomerFormPage(
                      customer: _selectedCustomer,
                      onSave: _handleFormSave,
                      onCancel: _handleFormCancel,
                    ),
                  ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _navigateToAddCustomer,
              child: Icon(Icons.add),
            ),
          );
        } else {
          // Mobile Layout
          return Scaffold(
            appBar: AppBar(
              title: Text(S.of(context).customers),
            ),
            body: ListView.builder(
              itemCount: _customers.length,
              itemBuilder: (context, index) {
                final customer = _customers[index];
                return ListTile(
                  title: Text('${customer.firstName} ${customer.lastName}'),
                  onTap: () => _navigateToEditCustomer(customer),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      final confirmed = await _showAlertDialog(
                        S.of(context).deleteCustomer,
                        S.of(context).confirmDelete,
                      );
                      if (confirmed == true) {
                        _handleCustomerDelete(customer);
                      }
                    },
                  ),
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: _navigateToAddCustomer,
              child: Icon(Icons.add),
            ),
          );
        }
      },
    );
  }

  Future<bool?> _showAlertDialog(String title, String message) async {
    return showDialog<bool?>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text(S.of(context).cancel),
              onPressed: () {
                Navigator.of(context).pop(false); // User pressed cancel
              },
            ),
            TextButton(
              child: Text(S.of(context).confirm),
              onPressed: () {
                Navigator.of(context).pop(true); // User pressed confirm
              },
            ),
          ],
        );
      },
    );
  }
}
