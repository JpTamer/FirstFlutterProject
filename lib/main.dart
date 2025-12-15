import 'package:flutter/material.dart';
import 'services/tree_api_service.dart';

void main() {
  runApp(const TreeCureApp());
}

class TreeCureApp extends StatefulWidget {
  const TreeCureApp({super.key});

  @override
  State<TreeCureApp> createState() => _TreeCureAppState();
}

class _TreeCureAppState extends State<TreeCureApp> {
  bool isDarkMode = false;

  void toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TreeCure',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: TreeMedicinePage(
        onThemeToggle: toggleTheme,
        isDarkMode: isDarkMode,
      ),
    );
  }
}

class TreeMedicinePage extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const TreeMedicinePage({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<TreeMedicinePage> createState() => _TreeMedicinePageState();
}

class _TreeMedicinePageState extends State<TreeMedicinePage> {
  String searchQuery = '';
  List<Map<String, dynamic>> treeMedicines = [];
  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _loadTreeData();
  }

  Future<void> _loadTreeData() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final data = await TreeApiService.fetchTreeMedicines();

      setState(() {
        treeMedicines = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    }
  }

  List<Map<String, dynamic>> getFilteredTrees() {
    if (searchQuery.isEmpty) {
      return treeMedicines;
    }
    return treeMedicines.where((tree) {
      return tree['tree'].toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final filteredTrees = getFilteredTrees();

    return Scaffold(
      backgroundColor: widget.isDarkMode ? null : const Color(0xFFE8F5E9),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3B2F),
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          '🌳 TreeCure',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onThemeToggle,
            tooltip: 'Change Theme',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadTreeData,
            tooltip: 'Refresh Data',
          ),
        ],
      ),
      body: isLoading
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(color: Colors.green),
                  SizedBox(height: 16),
                  Text('Loading tree data from server...'),
                ],
              ),
            )
          : errorMessage != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _loadTreeData,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                // Search bar
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search trees...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: widget.isDarkMode
                          ? Colors.grey[800]
                          : Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                  ),
                ),

                // Tree list
                Expanded(
                  child: filteredTrees.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.search_off,
                                size: 64,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                searchQuery.isEmpty
                                    ? 'No trees available'
                                    : 'No trees found matching "$searchQuery"',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: filteredTrees.length,
                          itemBuilder: (context, index) {
                            final tree = filteredTrees[index];
                            final diseases = tree['diseases'] as List;

                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ExpansionTile(
                                leading: const Icon(
                                  Icons.local_florist,
                                  color: Colors.green,
                                ),
                                title: Text(
                                  tree['tree'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                                children: diseases.map<Widget>((disease) {
                                  return ListTile(
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        disease['imageTree'],
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    title: Text(disease['name']),
                                    subtitle: Text(
                                      'Medicine: ${disease['medicine']}',
                                    ),
                                    trailing: const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.green,
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              DiseaseDetailPage(
                                                treeName: tree['tree'],
                                                disease: disease,
                                              ),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}

class DiseaseDetailPage extends StatelessWidget {
  final String treeName;
  final Map<String, dynamic> disease;

  const DiseaseDetailPage({
    super.key,
    required this.treeName,
    required this.disease,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3B2F),
        foregroundColor: Colors.white,
        title: Text(treeName),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Disease image
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  disease['imageTree'],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Disease name
            Text(
              disease['name'],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 10),

            // Medicine info
            Card(
              color: isDarkMode ? Colors.blue.shade900 : Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(
                      Icons.medication,
                      color: isDarkMode ? Colors.blue.shade200 : Colors.blue,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Medicine: ${disease['medicine']}',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Symptoms section
            _buildSection(
              'Symptoms',
              disease['symptoms'],
              Icons.medical_services,
              isDarkMode,
            ),

            // Causes section
            _buildSection('Causes', disease['causes'], Icons.eco, isDarkMode),

            // Treatment steps
            _buildSection(
              'Treatment Steps',
              disease['steps'],
              Icons.healing,
              isDarkMode,
            ),

            // Precaution
            Card(
              color: isDarkMode
                  ? Colors.orange.shade900
                  : Colors.orange.shade50,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning,
                      color: isDarkMode
                          ? Colors.orange.shade200
                          : Colors.orange,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Precaution: ${disease['precaution']}',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: isDarkMode ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    String title,
    List items,
    IconData icon,
    bool isDarkMode,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.green, size: 24),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...items.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '• ',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(item, style: const TextStyle(fontSize: 15)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
