import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';

import '../models/explosao_exception.dart';

class Campo {
  final int linha;
  final int coluna;
  final List<Campo> vizinhos = [];

  bool _aberto = false;
  bool _marcado = false;
  bool _minado = false;
  bool _explodido = false;

  Campo({this.linha, this.coluna});

  void adicionarvizinho(Campo vizinho) {
    final deltalinha = (linha - vizinho.linha).abs();
    final deltacoluna = (coluna - vizinho.coluna).abs();

    if (deltalinha == 0 && deltacoluna == 0) {
      return;
    }

    if (deltalinha <= 1 && deltacoluna <= 1) {
      vizinhos.add(vizinho);
    }
  }

  void abrir() {
    if (_aberto) {
      return;
    }

    _aberto = true;

    if (_minado) {
      _explodido = true;
      throw ExplosaoException();
    }

    if (vizinhancaSegura) {
      vizinhos.forEach((v) => v.abrir())
    }
  }

  void revelarBomba(){
    if(_minado){
      _aberto = true;
    }
  }


  bool get minado {
    return _minado;
  }

  Bool get vizinhancaSegura {
    return vizinhos.every((v) => !v._minado);
  }
}
