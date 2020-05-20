
class usuarios{
  final String usuario;
  final String contrasena;


  usuarios ({this.usuario,this.contrasena});


  /* Se crea el metodo toMap para transformar los datos de un formato de objeto
  a mapa. Este es necesario para introducir registros a la base de datos.
   */
  Map<String, dynamic> toMap() {
    return {
      'usuario': usuario,
      'contraseña': contrasena,
    };
  }



}
