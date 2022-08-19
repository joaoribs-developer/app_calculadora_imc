import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  String textView = "Insira seus dados!";

  GlobalKey<FormState> _infoForm = GlobalKey<FormState>();

  void _calculaIMC() {
    setState(() {
      double altura = double.parse(heightController.text) / 100;
      double peso = double.parse(weightController.text);
      double result = peso / (altura * altura);

      if (result < 18.5) {
        textView =
            "IMC:${result.toStringAsFixed(3)}, você está abaixo do seu peso";
      } else if (result >= 18.5 && result < 24.9) {
        textView =
            "IMC:${result.toStringAsFixed(3)}, você está com seu peso normal";
      } else if (result >= 25 && result < 29.9) {
        textView = "IMC:${result.toStringAsFixed(3)}, você está com sobrepeso";
      } else if (result >= 30 && result < 34.9) {
        textView =
            "IMC:${result.toStringAsFixed(3)}, você está com obesidade grau I";
      } else if (result >= 35 && result < 39.9) {
        textView =
            "IMC:${result.toStringAsFixed(3)}, você está com obesidade grau II";
      } else {
        textView =
            "IMC:${result.toStringAsFixed(3)}, você está com obesidade grau III";
      }
      heightController.clear();
      weightController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Calculadora IMC"),
        centerTitle: true,
        backgroundColor: Colors.blue[600],
        actions: [
          IconButton(
              onPressed: () {
                setState(() {
                  _infoForm = GlobalKey<FormState>();
                  textView = "Insira seus dados!";
                  heightController.clear();
                  weightController.clear();
                });
              },
              icon: const Icon(
                Icons.refresh,
              ))
        ],
      ),
      body: Form(
        key: _infoForm,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               Icon(
                Icons.person_outline_sharp,
                size: 120,
                color: Colors.blue[600],
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira seu peso";
                  }
                },
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Peso (kg)",
                    hintStyle: TextStyle(
                      color: Colors.blue[600],
                      fontSize: 26,
                    )),
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Insira sua altura";
                  }
                },
                controller: heightController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    hintText: "Altura (cm)",
                    hintStyle: TextStyle(
                      color: Colors.blue[600],
                    )),
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_infoForm.currentState!.validate()) {
                    _calculaIMC();
                  }
                },
                child: Text(
                  "CALCULAR",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    shadowColor: Colors.black,
                    primary:Colors.blue[600],
                    padding: EdgeInsets.all(16)),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                textView,
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.blue[600],
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
