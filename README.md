# Sistema de Registro de Estudiantes (Haskell & Prolog)

Este proyecto consiste en el desarrollo de dos versiones de un sistema para la gestión del ingreso y salida de estudiantes en una universidad. El sistema ha sido implementado bajo dos enfoques de programación distintos: funcional (Haskell) y lógico (Prolog).

Proyecto realizado para el curso **ST 0244 - Programación de Lenguajes de Programación** de la **Escuela de Ciencias Aplicadas e Ingeniería - Universidad EAFIT**.

## Descripción
El programa permite administrar el flujo de estudiantes en el campus, registrando sus tiempos de permanencia y asegurando que la información sea persistente a través de un archivo de texto externo. 

El diseño se centra en comparar cómo se aborda un mismo problema desde paradigmas de programación radicalmente opuestos.

## Funcionalidades Principales
Ambas implementaciones cumplen con las siguientes capacidades:

1.  **Check In (Entrada):** Registro del ID de un estudiante y su minuto de ingreso.
2.  **Búsqueda por ID:** Localización de un estudiante dentro de la universidad y visualización de su estado actual.
3.  **Cálculo de Tiempo:** Determinación de cuánto tiempo permaneció el estudiante en el campus, mostrado en un formato de horas y minutos.
4.  **Lista de Estudiantes:** Carga de la información completa desde el archivo `University.txt`.
5.  **Check Out (Salida):** Registro de la hora de salida y actualización automática del archivo de persistencia.

## Detalles de Implementación

### Versión Haskell (Enfoque Funcional)
* **Estructuras:** Se utiliza el tipo de dato `Estudiante` definido con sintaxis de registros y almacenado en listas inmutables.
* **Persistencia:** Implementa una gestión de archivos optimizada con la función `seq` para evitar bloqueos de lectura/escritura (Lazy Evaluation).
* **Manejo del Tiempo:** El tiempo se almacena como un entero (minutos transcurridos desde las 00:00) para simplificar los cálculos matemáticos.

### Versión Prolog (Enfoque Lógico)
* **Estructuras:** Uso de una base de datos dinámica mediante hechos `estudiante/4` que representan el estado del conocimiento.
* **Persistencia:** Implementación de flujos de lectura y escritura de términos de Prolog para mantener la base de datos actualizada en el disco.
* **Lógica:** Basada en la unificación y la búsqueda de soluciones a través de predicados lógicos.

## Instrucciones de Uso

### Ejecución de la versión Haskell
1.  Asegúrese de tener instalado el compilador **GHC**.
2.  Abra la terminal en la carpeta del proyecto.
3.  Inicie el intérprete: `ghci practica.hs`.
4.  Ejecute la función principal: `main`.

### Ejecución de la versión Prolog
1.  Asegúrese de tener instalado **SWI-Prolog**.
2.  Abra la terminal en la carpeta del proyecto.
3.  Cargue el archivo: `swipl -s practica.pl`.
4.  Inicie el sistema con el predicado: `inicio.`.

## Estructura de Archivos
* `practica.hs`: Código fuente en Haskell.
* `practica.pl`: Código fuente en Prolog.
* `University.txt`: Archivo plano donde se almacenan los datos de los estudiantes.

---
**Docente:** Alexander Narváez Berrío  
**Fecha:** Febrero 2026  
**Repositorio:** [leoduarte-ops/PRACTICA-PARADIGMAS-DE-PROGRAMACION](https://github.com/leoduarte-ops/PRACTICA-PARADIGMAS-DE-PROGRAMACION)
