import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget{
  @override
  _HomeWidgetState createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget>{
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _weightController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  String _result;
  
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: buildAppBar(),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: buildForm(),
      ),
    );
  }

  AppBar buildAppBar(){
    return AppBar(
      centerTitle: true,
      title: Text(
        'Calculando IMC',
        style: TextStyle(
          fontSize: 25.0,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.blue[600],
      actions: <Widget>[
        IconButton(
          icon: Icon(
            Icons.refresh,
            size: 35.0,
          ),
          onPressed: (){
            resetFields();
          },
        ),
      ],
    );
  }

  Form buildForm(){
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildTextFormField(
            label: "Peso (kg)",
            error: "Insira seu peso!",
            controller: _weightController
          ),
          buildTextFormField(
            label: "Altura (cm)",
            error: "Insira sua altura",
            controller: _heightController
          ),
          buildTextResult(),
          buildCalculateButton(),
        ],
      ),
    );
  }

  Padding buildCalculateButton(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      // ignore: deprecated_member_use
      child: RaisedButton(
        color: Colors.blue[800],
        onPressed: (){
          if(_formKey.currentState.validate()){
            calculateImc();
          }
        },
        child: Text(
          'CALCULAR',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Padding buildTextResult(){
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 36.0),
      child: Text(
        _result,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 20.0,
        ),
      ),
    );
  }

  TextFormField buildTextFormField({TextEditingController controller, String error, String label}){
    return TextFormField(
      style: TextStyle(
        fontSize: 20.0
      ),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(labelText: label),
      controller: controller,
      validator: (text){
        return text.isEmpty ? error : null;
      },
    );
  }

  @override
  void initState(){
    super.initState();
    resetFields();
  }

  void resetFields(){
    _weightController.text = '';
    _heightController.text = '';
    setState((){
      _result = 'Preencha os campos corretamente.';
    });
  }

  void calculateImc(){
    double weight = double.parse(_weightController.text);
    double height = double.parse(_heightController.text);
    double imc = (weight / (height * height)) * 10000;

    setState((){
      _result = "IMC = ${imc.toStringAsPrecision(2)}\n";

      if(imc < 18.5)
        _result += "Abaixo do peso";
      else if(imc >= 18.5 && imc <= 24.9)
        _result += "Peso ideal";
      else if(imc >= 25 && imc <= 29.9)
        _result += "Levemente acima do peso";
      else if(imc >= 30.0 && imc <= 34.9)
        _result += "Obesidade Grau I";
      else if(imc >= 35.0 && imc <= 49.9)
        _result += "Obedidade Grau II";
      else
        _result += "Obedidade Grau III";
    });
  } 
}