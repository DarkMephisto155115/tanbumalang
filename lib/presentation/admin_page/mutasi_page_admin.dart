import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../element/mutasi_element.dart'; // Ensure this file defines TransactionItem

class MutasiPageAdmin extends StatefulWidget {
  @override
  _MutasiPageState createState() => _MutasiPageState();
}

class _MutasiPageState extends State<MutasiPageAdmin> {
  String _selectedRange = 'Hari ini';
  List<TransactionItem> transactions = [];
  List<TransactionItem> filteredTransactions = [];

  DateTime? _selectedDate;
  DateTime? _selectedMonth;

  @override
  void initState() {
    super.initState();
    fetchTransactionsFromFirestore();
  }

  Future<void> fetchTransactionsFromFirestore() async {
    try {
      final QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('payments').get();
      final List<TransactionItem> loadedTransactions = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return TransactionItem(
          date: (data['timestamp'] as Timestamp).toDate().toString(),
          description: data['name'] ?? '',
          amount: data['amount'] ?? '',
        );
      }).toList();

      setState(() {
        transactions = loadedTransactions;
        filterTransactions();
      });
    } catch (e) {
    }
  }

  void filterTransactions() {
    setState(() {
      DateTime now = DateTime.now();
      filteredTransactions = transactions;

      if (_selectedRange == 'Hari ini') {
        filteredTransactions = transactions.where((transaction) {
          DateTime transactionDate = DateTime.parse(transaction.date);
          return transactionDate.year == now.year &&
              transactionDate.month == now.month &&
              transactionDate.day == now.day;
        }).toList();
      } else if (_selectedRange == '7 Hari Terakhir') {
        filteredTransactions = transactions.where((transaction) {
          DateTime transactionDate = DateTime.parse(transaction.date);
          return now.difference(transactionDate).inDays <= 7;
        }).toList();
      } else if (_selectedRange == 'Pilih Bulan' && _selectedMonth != null) {
        filteredTransactions = transactions.where((transaction) {
          DateTime transactionDate = DateTime.parse(transaction.date);
          return transactionDate.year == _selectedMonth!.year &&
              transactionDate.month == _selectedMonth!.month;
        }).toList();
      } else if (_selectedRange == 'Pilih Tanggal' && _selectedDate != null) {
        filteredTransactions = transactions.where((transaction) {
          DateTime transactionDate = DateTime.parse(transaction.date);
          return transactionDate.year == _selectedDate!.year &&
              transactionDate.month == _selectedDate!.month &&
              transactionDate.day == _selectedDate!.day;
        }).toList();
      }
    });
  }
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020), // You can customize the range
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        filterTransactions(); // Filter transactions based on selected date
      });
    }
  }

  Future<void> _selectMonth(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime firstDayOfMonth = DateTime(now.year, now.month, 1); // Set initialDate to the 1st of the current month
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: firstDayOfMonth, // Ensure the initial date satisfies the predicate
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      helpText: 'Pilih Bulan', // Change the dialog title to "Select Month"
      fieldLabelText: 'Pilih bulan dan tahun', // Customize the input label
      selectableDayPredicate: (DateTime date) {
        return date.day == 1; // Only the first day of each month is selectable
      },
    );
    if (picked != null && picked != _selectedMonth) {
      setState(() {
        _selectedMonth = picked;
        filterTransactions(); // Filter transactions based on selected month
      });
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo.png', width: 50, height: 50),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Rentang Waktu Section
            ExpansionTile(
              title: const Text(
                'Rentang Waktu',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              children: [
                // Radio buttons for time range selection inside the ExpansionTile
                RadioListTile(
                  title: const Text('Hari ini'),
                  value: 'Hari ini',
                  groupValue: _selectedRange,
                  onChanged: (value) {
                    setState(() {
                      _selectedRange = value!;
                      filterTransactions(); // Filter transactions based on selection
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('7 Hari Terakhir'),
                  value: '7 Hari Terakhir',
                  groupValue: _selectedRange,
                  onChanged: (value) {
                    setState(() {
                      _selectedRange = value!;
                      filterTransactions(); // Filter transactions based on selection
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('Pilih Bulan'),
                  value: 'Pilih Bulan',
                  groupValue: _selectedRange,
                  onChanged: (value) {
                    setState(() {
                      _selectedRange = value!;
                      _selectMonth(context); // Open month picker
                    });
                  },
                ),
                RadioListTile(
                  title: const Text('Pilih Tanggal'),
                  value: 'Pilih Tanggal',
                  groupValue: _selectedRange,
                  onChanged: (value) {
                    setState(() {
                      _selectedRange = value!;
                      _selectDate(context); // Open date picker
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Display filtered transactions
            Expanded(
              child: ListView.builder(
                itemCount: filteredTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = filteredTransactions[index];
                  return TransactionItem(
                    date: transaction.date,
                    description: transaction.description,
                    amount: transaction.amount,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Mutasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'QR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: 1,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home_admin');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/mutasi_admin');
              break;
            case 2:
              Get.toNamed('/qrscan');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/info_admin');
              break;
            case 4:
              Navigator.pushReplacementNamed(context, '/profil_admin');
              break;
          }
        },
      ),
    );
  }
}
