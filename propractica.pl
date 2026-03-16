% ===========================================================================
% DEFINICIÓN DE LA BASE DE DATOS DINÁMICA
% ===========================================================================
% Esto permite que el programa agregue o elimine datos en tiempo de ejecución.
:- dynamic estudiante/4. 
% Estructura: estudiante(ID, Estado, MinutosEntrada, MinutosSalida).

% ===========================================================================
% INICIO Y MENÚ PRINCIPAL
% ===========================================================================
inicio :-
    cargar_desde_archivo,
    menu.

menu :-
    writeln('\n--- SISTEMA DE REGISTRO UNIVERSITARIO ---'),
    writeln('1. Registrar Entrada (Check-In)'),
    writeln('2. Registrar Salida (Check-Out)'),
    writeln('3. Buscar Estudiante por ID'),
    writeln('4. Listar Estudiantes'),
    writeln('5. Salir'),
    write('Seleccione una opcion: '),
    read(Opcion),
    ejecutar_opcion(Opcion).

% Caso para salir del programa
ejecutar_opcion(5) :- 
    writeln('Saliendo del sistema...'), !.

% Casos para las demás opciones
ejecutar_opcion(Opc) :-
    procesar(Opc),
    menu. % Recursión para volver al menú

% ===========================================================================
% REQUERIMIENTOS FUNCIONALES
% ===========================================================================

% 1. REGISTRAR ENTRADA (CHECK-IN) [cite: 11, 14]
procesar(1) :-
    write('Ingrese ID del estudiante: '), read(ID),
    (   estudiante(ID, adentro, _, _)
    ->  writeln('Error: El estudiante ya se encuentra en la universidad.')
    ;   write('Ingrese hora de entrada (minutos totales desde 00:00): '), read(Hora),
        retractall(estudiante(ID, _, _, _)), % Elimina registro previo si existe
        assertz(estudiante(ID, adentro, Hora, 0)),
        guardar_en_archivo,
        writeln('Entrada registrada exitosamente.')
    ).

% 2. REGISTRAR SALIDA (CHECK-OUT) [cite: 32, 33]
procesar(2) :-
    write('Ingrese ID del estudiante: '), read(ID),
    (   estudiante(ID, adentro, Entrada, _)
    ->  write('Ingrese hora de salida (minutos totales desde 00:00): '), read(Salida),
        retract(estudiante(ID, adentro, Entrada, _)),
        assertz(estudiante(ID, afuera, Entrada, Salida)),
        guardar_en_archivo,
        calcular_y_mostrar_tiempo(Entrada, Salida),
        writeln('Salida registrada exitosamente.')
    ;   writeln('Error: El estudiante no esta en la universidad o el ID no existe.')
    ).

% 3. BUSCAR POR ID [cite: 17, 18]
procesar(3) :-
    write('Ingrese ID a buscar: '), read(ID),
    (   estudiante(ID, Estado, Entrada, Salida)
    ->  format('Estudiante ID: ~w | Estado: ~w | Entrada: ~w min | Salida: ~w min~n', [ID, Estado, Entrada, Salida])
    ;   writeln('Estudiante no encontrado.')
    ).

% 4. LISTAR ESTUDIANTES (CARGAR DESDE ARCHIVO) [cite: 26, 30]
procesar(4) :-
    writeln('--- LISTA DE ESTUDIANTES ---'),
    forall(estudiante(ID, Estado, E, S), 
           format('ID: ~w | Estado: ~w | Entrada: ~w | Salida: ~w~n', [ID, Estado, E, S])).

% Si la opción no es válida
procesar(_) :- writeln('Opcion no valida.').

% ===========================================================================
% LÓGICA DE CÁLCULO DE TIEMPO [cite: 22, 23, 25]
% ===========================================================================
calcular_y_mostrar_tiempo(Entrada, Salida) :-
    TiempoTotal is Salida - Entrada,
    Horas is TiempoTotal // 60,
    Minutos is TiempoTotal mod 60,
    format('Tiempo en la universidad: ~w horas y ~w minutos.~n', [Horas, Minutos]).

% ===========================================================================
% MANEJO DE ARCHIVO (PERSISTENCIA) [cite: 50, 52]
% ===========================================================================
cargar_desde_archivo :-
    retractall(estudiante(_, _, _, _)),
    (   exists_file('University.txt')
    ->  setup_call_cleanup(
            open('University.txt', read, Stream),
            leer_datos(Stream),
            close(Stream)
        )
    ;   open('University.txt', write, Out), close(Out) % Crea el archivo si no existe
    ).

leer_datos(Stream) :-
    read(Stream, Termino),
    (   Termino == end_of_file
    ->  true
    ;   assertz(Termino),
        leer_datos(Stream)
    ).

guardar_en_archivo :-
    setup_call_cleanup(
        open('University.txt', write, Stream),
        (   forall(estudiante(ID, Estado, E, S), 
            format(Stream, 'estudiante(~w, ~w, ~w, ~w).~n', [ID, Estado, E, S]))
        ),
        close(Stream)
    ).