// calculadora.dart
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:math_expressions/math_expressions.dart';

class Calculadora extends StatefulWidget {
  const Calculadora({super.key});

  @override
  State<Calculadora> createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  String _expressao = '';
  String _resultado = '';

  void _adicionarCaractere(String caractere) {
    setState(() {
      _expressao += caractere;
    });
  }

  void _limpar() {
    setState(() {
      _expressao = '';
      _resultado = '';
    });
  }

  void _calcular() {
    try {
      Parser parser = Parser();
      Expression exp = parser.parse(_expressao);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      setState(() {
        _resultado = eval.toString();
      });
    } catch (e) {
      setState(() {
        _resultado = 'Erro';
      });
    }
  }

  Widget _botao(String label, {Color? corDeFundo, Color? corDoTexto, Function()? onPressed}) {
    return ElevatedButton(
      onPressed: onPressed ?? () => _adicionarCaractere(label),
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(),
        padding: const EdgeInsets.all(8),
        backgroundColor: corDeFundo ?? Colors.pink,
        foregroundColor: corDoTexto ?? Colors.white,
        minimumSize: const Size(50, 50),
      ),
      child: Text(
        label,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 500,
          decoration: BoxDecoration(
            color: Colors.pink[50],
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(color: Colors.grey, blurRadius: 8, offset: Offset(2, 2)),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      alignment: Alignment.bottomRight,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        _expressao,
                        style: const TextStyle(fontSize: 28, color: Colors.black54),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        _resultado,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                  children: [
                    Expanded(
                      flex: 5,
                      child: GridView.count(
                        crossAxisCount: 4,
                        childAspectRatio: 1,
                        padding: const EdgeInsets.all(8),
                        children: [
                          _botao('7', corDeFundo: Colors.pink),
                          _botao('8', corDeFundo: Colors.pink),
                          _botao('9', corDeFundo: Colors.pink),
                          _botao('÷', corDeFundo: Colors.orange, onPressed: () => _adicionarCaractere('/')),
                          _botao('4', corDeFundo: Colors.pink),
                          _botao('5', corDeFundo: Colors.pink),
                          _botao('6', corDeFundo: Colors.pink),
                          _botao('x', corDeFundo: Colors.orange, onPressed: () => _adicionarCaractere('*')),
                          _botao('1', corDeFundo: Colors.pink),
                          _botao('2', corDeFundo: Colors.pink),
                          _botao('3', corDeFundo: Colors.pink),
                          _botao('-', corDeFundo: Colors.orange, onPressed: () => _adicionarCaractere('-')),
                          _botao('0', corDeFundo: Colors.pink),
                          _botao('.', corDeFundo: Colors.pink, onPressed: () => _adicionarCaractere('.')),
                          _botao('=', corDeFundo: Colors.orangeAccent, onPressed: _calcular),
                          _botao('+', corDeFundo: Colors.orange, onPressed: () => _adicionarCaractere('+')),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _limpar,
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(),
                        padding: const EdgeInsets.all(8),
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                      ),
                      child: const Icon(Icons.backspace, size: 28),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
