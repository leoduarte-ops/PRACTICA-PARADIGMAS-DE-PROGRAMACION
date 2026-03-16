# Sistema de Registro de Estudiantes (Haskell & Prolog)

[cite_start]Este proyecto consiste en el desarrollo de dos versiones de un sistema para la gestión del ingreso y salida de estudiantes en una universidad[cite: 5]. [cite_start]El sistema ha sido implementado bajo dos enfoques de programación distintos: funcional (Haskell) y lógico (Prolog)[cite: 6, 7].

[cite_start]Proyecto realizado para el curso **ST 0244 - Programación de Lenguajes de Programación** de la **Escuela de Ciencias Aplicadas e Ingeniería - Universidad EAFIT**[cite: 1].

## 📝 Descripción
[cite_start]El programa permite administrar el flujo de estudiantes en el campus, registrando sus tiempos de permanencia y asegurando que la información sea persistente a través de un archivo de texto externo[cite: 9, 10, 42, 50].

## 🚀 Requerimientos Funcionales
[cite_start]Ambas implementaciones cumplen con las siguientes capacidades[cite: 8, 9]:

1.  [cite_start]**Check In (Entrada):** Permite registrar el ID de un estudiante y su hora de ingreso[cite: 11, 12, 13].
2.  [cite_start]**Búsqueda por ID:** Localiza a un estudiante dentro de la universidad y muestra su información actual[cite: 17, 18, 20].
3.  [cite_start]**Cálculo de Tiempo:** Determina cuánto tiempo permaneció el estudiante en el campus y lo muestra en un formato claro de horas y minutos[cite: 23, 24, 25].
4.  [cite_start]**Lista de Estudiantes:** Carga la información desde el archivo `University.txt` y la muestra en la terminal[cite: 26, 28, 30].
5.  [cite_start]**Check Out (Salida):** Registra la hora de salida de un estudiante y actualiza el archivo de persistencia[cite: 32, 33, 35, 36].

## 🛠️ Detalles de Implementación

### [cite_start]Versión Haskell (Enfoque Funcional) [cite: 38]
* [cite_start]**Estructuras:** Se utiliza una lista para almacenar los registros de los estudiantes en memoria durante la ejecución[cite: 40].
* [cite_start]**Persistencia:** Implementa gestión de archivos para cargar `University.txt` al inicio y guardar cambios tras cada registro de entrada o salida[cite: 42, 43, 44].
* [cite_start]**Manejo del Tiempo:** El tiempo se almacena como un entero (minutos desde las 00:00) para optimizar los cálculos aritméticos[cite: 57].

### [cite_start]Versión Prolog (Enfoque Lógico) [cite: 45]
* [cite_start]**Estructuras:** Uso de una base de datos dinámica mediante hechos y términos para representar a los estudiantes[cite: 47, 48].
* [cite_start]**Persistencia:** Implementación de predicados para la lectura y escritura de términos en el archivo `University.txt`[cite: 50, 51, 52].
* [cite_start]**Lógica:** Cada requerimiento funcional se resuelve mediante un predicado específico siguiendo el paradigma de programación lógica[cite: 49].

## 📋 Instrucciones de Uso

### Ejecución de la versión Haskell
1.  Asegúrese de tener instalado el compilador **GHC** (o GHCup).
2.  Navegue a la carpeta del proyecto en su terminal.
3.  Inicie el intérprete: `ghci practica.hs`.
4.  Ejecute la función principal: `main`.

### Ejecución de la versión Prolog
1.  Asegúrese de tener instalado **SWI-Prolog**.
2.  Abra la terminal en la carpeta del proyecto.
3.  Cargue el archivo: `swipl -s practica.pl`.
4.  Inicie el sistema con el predicado: `inicio.`.

## 📂 Archivos del Proyecto
* [cite_start]`practica.hs`: Código fuente en Haskell[cite: 39].
* [cite_start]`practica.pl`: Código fuente en Prolog[cite: 46].
* [cite_start]`University.txt`: Archivo de base de datos plana para la persistencia[cite: 28, 51].

---
[cite_start]**Docente:** Alexander Narváez Berrío [cite: 1]  
[cite_start]**Fecha:** Febrero 2026 [cite: 2]  
**Repositorio:** [leoduarte-ops/PRACTICA-PARADIGMAS-DE-PROGRAMACION](https://github.com/leoduarte-ops/PRACTICA-PARADIGMAS-DE-PROGRAMACION)
