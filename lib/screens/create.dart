import 'package:flutter/material.dart';

class Create extends StatefulWidget {
  const Create({super.key});

  @override
  State<Create> createState() => _CreateState();
}

class _CreateState extends State<Create> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _onSendPressed() {
    String enteredText = _textController.text.trim();
    if (enteredText.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("You entered: $enteredText")),
      );
      _textController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 60.0), 
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(43, 254, 198, 41),
                  borderRadius: BorderRadius.circular(15),
                ),
                margin:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                padding:
                const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const ImageIcon(
                          AssetImage("assets/icons/information.png"),
                          size: 35,
                          color: Color.fromARGB(255, 254, 198, 41),
                        ),
                        const SizedBox(width: 15),
                        const Text(
                          "Content Safety",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildStatRow("Safe Content", "75%",
                        const Color.fromARGB(255, 0, 171, 74)),
                    const SizedBox(height: 12.5),
                    _buildStatRow("Under Review", "15%",
                        const Color.fromARGB(255, 181, 144, 30)),
                    const SizedBox(height: 12.5),
                    _buildStatRow("Flagged Content", "10%",
                        const Color.fromARGB(255, 224, 62, 99)),
                    const SizedBox(height: 10),
                    const Text(
                      "Real-Time Update from Post Content",
                      style: TextStyle(
                        fontSize: 10,
                        color: Color.fromARGB(255, 112, 112, 112),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(
                thickness: 2,
                color: Color.fromARGB(255, 215, 215, 215),
              ),

              
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(43, 254, 198, 41),
                  borderRadius: BorderRadius.circular(15),
                ),
                margin:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _textController,
                        maxLines: null,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter your text here to check...",
                          hintStyle: TextStyle(
                            color: Color.fromARGB(255, 81, 81, 81),
                            fontSize: 16, 
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const ImageIcon(
                        AssetImage("assets/icons/send.png"),
                        size: 28,
                        color: Color.fromARGB(255, 254, 198, 41),
                      ),
                      onPressed: _onSendPressed,
                    ),
                  ],
                ),
              ),

              
              const Divider(
                thickness: 2,
                color: Color.fromARGB(255, 215, 215, 215),
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: const [
                    Text(
                      "✨ Our AI is continuously filtering out spam, toxic, and unsafe posts.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 80, 80, 80),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: null, // indeterminate loading
                      backgroundColor: Color.fromARGB(50, 254, 198, 41),
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromARGB(255, 254, 198, 41)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 17,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 17,
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
