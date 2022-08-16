import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:opac_univalle/providers/providers.dart';
import 'package:opac_univalle/shared_preferences/preferences.dart';
import 'package:opac_univalle/utils/mostrar_alerta.dart';
import 'package:opac_univalle/widgets/widgets.dart';

class PerfilScreen extends StatelessWidget {
  final String fecha;
  final String multa;
  final String librosPrestamo;
  final String historialLibro;

  const PerfilScreen(
      {Key? key,
      required this.fecha,
      required this.multa,
      required this.librosPrestamo,
      required this.historialLibro})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: double.infinity,
            height: 60,
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: Text(
                  'Hemos preparado un resumen de tu cuenta para ti',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          BannerInformacion(
            titulo: 'Multa actual',
            valor: '\$ $multa',
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ItemInformacion(
                  valor: librosPrestamo,
                  icon: Icons.book_rounded,
                  titulo: 'En prestamo'),
              ItemInformacion(
                  valor: historialLibro,
                  icon: Icons.history_rounded,
                  titulo: 'Historial'),
            ],
          ),
          BannerInformacion(titulo: 'Fecha expiración', valor: fecha),
          BotonPrimario(
              onPressed: () {
                mostrarAlerta(
                    context,
                    AlertaSiNo(
                        title: '¿Deseas cerrar la sesión?',
                        onPressendNo: () => Navigator.pop(context),
                        onPressendSi: () {
                          Preferences.codigo = '';
                          Preferences.nombre = '';
                          Navigator.pushReplacementNamed(context, 'login');
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Estas apunto de cerrar la sesión, ¿deseas continuar?',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            )
                          ],
                        )));
              },
              child: const Text('Cerrar sesión'))
        ],
      ),
    );
  }
}
