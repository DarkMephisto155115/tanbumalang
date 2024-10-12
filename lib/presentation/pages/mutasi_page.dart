import 'package:flutter/material.dart';
import '../element/mutasi_element.dart'; // Ensure you have this file with TransactionItem defined

class MutasiPage extends StatefulWidget {
  @override
  _MutasiPageState createState() => _MutasiPageState();
}

class _MutasiPageState extends State<MutasiPage> {
  int _selectedIndex = 1; // Current index of the bottom navigation bar
  String _selectedRange = 'Hari ini'; // Default selection for time range
  List<TransactionItem> transactions = []; // Full transaction list
  List<TransactionItem> filteredTransactions = []; // Filtered list based on selected time range

  DateTime? _selectedDate; // Variable for storing the selected date
  DateTime? _selectedMonth; // Variable for storing the selected month

  @override
  void initState() {
    super.initState();
    // Initialize your transaction list (or get it from an API/DB)
    transactions = [
      const TransactionItem(date: '2024-10-11', description: 'Pembayaran Himpunan', amount: '-Rp 20.000,00'),
      const TransactionItem(date: '2024-10-10', description: 'Pembayaran Asrama', amount: '-Rp 500.000,00'),
      const TransactionItem(date: '2024-09-02', description: 'Pembayaran Himpunan', amount: '-Rp 20.000,00'),
      const TransactionItem(date: '2024-09-01', description: 'Pembayaran Asrama', amount: '-Rp 500.000,00'),
      // Add more transactions as needed
    ];
    // Apply initial filtering
    filterTransactions();
  }

  void filterTransactions() {
    setState(() {
      DateTime now = DateTime.now();
      filteredTransactions = transactions; // Default to showing all

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


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Add navigation logic based on the selected index
    switch (index) {
      case 0: // Home
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1: // Mutasi
        break;
      case 2: // QR (Work on Progress)
        break;
      case 3: // Info
        Navigator.pushReplacementNamed(context, '/info');
        break;
      case 4: // Profile
        Navigator.pushReplacementNamed(context, '/profil');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        title: const Text('Mutasi'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo.png', width: 50, height: 50), // Logo custom
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
        backgroundColor: Colors.green[300],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white70,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/icon_home.png', width: 24, height: 24),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icon_mutasi.png', width: 24, height: 24),
            label: 'Mutasi',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset(
                  'assets/icon_qr_code.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icon_info.png', width: 24, height: 24),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: Image.asset('assets/icon_profile.png', width: 24, height: 24),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
