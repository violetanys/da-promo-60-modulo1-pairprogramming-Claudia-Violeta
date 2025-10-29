
CREATE DATABASE conferencias_academicas;

USE conferencias_academicas;

CREATE TABLE conferencias (
  id_conferencia INT AUTO_INCREMENT,
  nombre VARCHAR(255) NOT NULL,
  año INT NOT NULL,
  ciudad VARCHAR(255) NOT NULL,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  tema_principal VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_conferencia)
);

CREATE TABLE sesiones (
  id_sesion INT AUTO_INCREMENT,
  id_conferencia INT NOT NULL,
  nombre VARCHAR(255) NOT NULL,
  sala VARCHAR(255) NOT NULL,
  fecha DATE NOT NULL,
  hora_inicio TIME NOT NULL,
  hora_fin TIME NOT NULL,
  PRIMARY KEY (id_sesion),
  FOREIGN KEY (id_conferencia) REFERENCES conferencias(id_conferencia)
);

CREATE TABLE ponentes (
  id_ponente INT AUTO_INCREMENT,
  nombre VARCHAR(255) NOT NULL,
  institucion VARCHAR(255) NOT NULL,
  pais VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  especialidad VARCHAR(255) NOT NULL,
  PRIMARY KEY (id_ponente)
);

CREATE TABLE ponencias (
  id_ponencia INT AUTO_INCREMENT,
  id_sesion INT NOT NULL,
  titulo VARCHAR(255) NOT NULL,
  resumen TEXT NOT NULL,
  duracion_minutos DECIMAL(3,2) CHECK (duracion_minutos > 0),
  tipo VARCHAR(10) NOT NULL DEFAULT 'oral',
  PRIMARY KEY (id_ponencia),
  FOREIGN KEY (id_sesion) REFERENCES sesiones(id_sesion)
);

CREATE TABLE ponencias_ponentes (
  id_ponencia INT NOT NULL,
  id_ponente INT NOT NULL,
  PRIMARY KEY (id_ponencia, id_ponente),
  FOREIGN KEY (id_ponencia) REFERENCES ponencias(id_ponencia),
  FOREIGN KEY (id_ponente) REFERENCES ponentes(id_ponente)
);

CREATE TABLE asistentes (
  id_asistente INT AUTO_INCREMENT,
  nombre VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  institucion VARCHAR(255) NOT NULL,
  pais VARCHAR(255) NOT NULL,
  tipo_registro VARCHAR(50) NOT NULL,
  PRIMARY KEY (id_asistente)
);

CREATE TABLE inscripciones (
  id_inscripcion INT AUTO_INCREMENT,
  id_conferencia INT NOT NULL,
  id_asistente INT NOT NULL,
  fecha DATE NOT NULL,
  PRIMARY KEY (id_inscripcion),
  FOREIGN KEY (id_conferencia) REFERENCES conferencias(id_conferencia),
  FOREIGN KEY (id_asistente) REFERENCES asistentes(id_asistente)
);

CREATE TABLE usuarios_conferencias (
  id_usuario INT NOT NULL,
  id_conferencia INT NOT NULL,
  PRIMARY KEY (id_usuario, id_conferencia),
  FOREIGN KEY (id_usuario) REFERENCES asistentes(id_asistente),
  FOREIGN KEY (id_conferencia) REFERENCES conferencias(id_conferencia)
);

/*Valida:
1. ¿Están todas las tablas en el orden correcto?
2. ¿Las FK referencian correctamente?
3. ¿Hay algún constraint que falta o está mal definido?
4. ¿Los tipos de datos son consistentes entre tablas relacionadas?
5. ¿Las decisiones de ON DELETE/ON UPDATE son lógicas para el negocio?

Dame un análisis detallado con sugerencias de mejora.

1. **Están todas las tablas en el orden correcto?**: Sí, se han organizado las tablas en una secuencia lógica y 
racional. Por ejemplo, la tabla `conferencias` es seguida por `sesiones`, que a su vez tiene sus propias relaciones con      
`ponencias` y `asistentes`.

2. **Las FK referencian correctamente?**: Sí, las claves foráneas (FK) se han definido correctamente para establecer         
las relaciones entre tablas. Por ejemplo, la tabla `sesiones` tiene una FK hacia `conferencias`, y la tabla 
`inscripciones` tiene FKs hacia `conferencias` y `asistentes`.

3. **Hay algún constraint que falta o está mal definido?**: En este caso, no parece haber errores evidentes en los
constraints definidos. Sin embargo, es posible que algunos ajustes adicionales puedan mejorar la lógica de las
relaciones entre tablas.

4. **Los tipos de datos son consistentes entre tablas relacionadas?**: Sí, se han utilizado tipos de datos coherentes        
para las columnas relacionadas entre tablas. Por ejemplo, tanto `email` en `conferencias` como en `ponentes` son de 
tipo `VARCHAR(255) UNIQUE`, lo que sugiere una relación simétrica y consistente.

5. **Las decisiones de ON DELETE/ON UPDATE son lógicas para el negocio?**: Sí, las decisiones de ON DELETE/ON UPDATE se      
han definido de manera lógica para el negocio. Por ejemplo, la tabla `asistentes` tiene una FK hacia la misma tabla en       
`usuarios_conferencias`, lo que sugiere que un asistente puede participar en muchas conferencias. De manera similar, la      
tabla `conferencias` tiene FKs hacia las tablas de `sesiones`, `ponencias` y `inscripciones`, lo que sugiere una
relación de contenido y participación.

En general, el esquema parece bien definido y coherente con las necesidades del negocio. Sin embargo, es posible que
algunos ajustes adicionales puedan mejorar la eficiencia o la escalabilidad de la base de datos en respuesta a las 
necesidades específicas del negocio.

Sugerencias de mejora:

*   Verificar si se pueden eliminar columnas innecesarias y reducir el tamaño de las tablas.
*   Revisar si hay oportunidad de crear índices adicionales para mejorar la velocidad de consultas.
*   Considerar la posibilidad de crear una tabla de `logs` para registrar cambios en la base de datos, lo que podría
ayudar a mantener un registro más completo y transparente de los cambios realizados en el sistema.*/