import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _infoText = "Informe seus dados";
  String? errorWeight;
  String? errorHeight;


  void _resetField(){
    weightController.text = "";
    heightController.text = "";

    setState((){
      _infoText = "Informe seus dados";
      errorWeight = null;
      errorHeight = null;
    });
  }

  void calculate(){

    setState((){

      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;
      double imc = weight / (height * height);

      if(imc < 18.5){
        _infoText = "Abaixo do peso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 18.5 && imc < 25){
        _infoText = "Peso Ideal (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 25 && imc < 30){
        _infoText = "Sobrepeso (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 30 && imc < 35){
        _infoText = "Obesidade grau I (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 35 && imc < 40){
        _infoText = "Obesidade grau II (${imc.toStringAsPrecision(4)})";
      } else if(imc >= 40){
        _infoText = "Obesidade grau III (${imc.toStringAsPrecision(4)})";
      }

    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
        centerTitle: true,
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            onPressed: _resetField,
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.person_outline,
              size: 120,
              color: Colors.green,
            ),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: Text(""
                    "Peso (kg)"),
                labelStyle: TextStyle(color: Colors.green),
                errorText: errorWeight,
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 18),
            ),
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Altura (cm)",
                labelStyle: TextStyle(color: Colors.green),
                errorText: errorHeight,
              ),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.green, fontSize: 18),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: ElevatedButton(
                onPressed: (){
                  setState((){
                    String weightText = weightController.text;
                    String heightText = weightController.text;

                    if(weightText.isEmpty && heightText.isEmpty){

                      errorWeight = 'Preencha esse campo';
                      errorHeight = 'Preencha esse campo';

                    }else{
                      calculate();
                    }
                  });

                },
                child: Text(
                  'Calcular',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  fixedSize: Size(30, 40),
                ),
              ),
            ),
            Text(
              _infoText,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
