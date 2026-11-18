import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';

import '../models/explosao_exception.dart';

class Campo {
  final int linha;
  final int coluna;
  final List<Campo> vizinhos = [];

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
      vizinhos.forEach((v) => v.abrir());
    }
  }

  void revelarBomba() {
    if (_minado) {
      _aberto = true;
    }
  }

  void minar() {
    _minado = true;
  }

  void alternarMarcacao() {
    _marcado = !_marcado;
  }

  void reiniciar() {
    _aberto = false;
    _marcado = false;
    _minado = false;
    _explodido = false;
  }

  bool get minado {
    return _minado;
  }

  bool get explodido {
    return _explodido;
  }

  bool get aberto {
    return _abero;
  }

  bool get marcado {
    return _marcado;
  }

  bool get resolvido {
    bool minadoEmarcado = minado && marcado;
    bool seguroEaberto = !minado && aberto;
    return minadoEmarcado || seguroEaberto;
  }

  Bool get vizinhancaSegura {
    return vizinhos.every((v) => !v._minado);
  }

  int get qtdeMinasNaVizinha {
    return vizinhos.where((v) => v.minado).length;
  }
}
