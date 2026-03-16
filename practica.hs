import System.IO
import Data.List (find)
import System.Directory (doesFileExist)

-- 1. ESTRUCTURA DE DATOS
-- Definimos el tipo Estudiante con nombres claros en español
data Estudiante = Estudiante {
    idEstudiante :: String,
    horaEntrada  :: Int,
    horaSalida   :: Int,
    estaPresente :: Bool
} deriving (Show, Read, Eq)

-- 2. LÓGICA DE TIEMPO
-- Convierte minutos a un formato de horas y minutos legible [cite: 25, 57]
formatearDuracion :: Int -> String
formatearDuracion totalMinutos =
    let horas = div totalMinutos 60
        minutos = mod totalMinutos 60
    in show horas ++ " horas y " ++ show minutos ++ " minutos"

-- 3. GESTIÓN DE ARCHIVOS (PERSISTENCIA)
-- Guarda la lista completa en University.txt [cite: 42, 44]
guardarDatos :: [Estudiante] -> IO ()
guardarDatos lista = do
    writeFile "University.txt" (show lista)
    putStrLn ">>> Datos guardados exitosamente."

-- Carga la lista con la corrección para evitar el error "Resource Busy" [cite: 28, 43]
cargarDatos :: IO [Estudiante]
cargarDatos = do
    existe <- doesFileExist "University.txt"
    if existe
        then do
            contenido <- readFile "University.txt"
            -- Forzamos la lectura completa con 'seq' para liberar el archivo inmediatamente
            let lista = if null (words contenido) then [] else read contenido
            length contenido `seq` return lista
        else return []

-- 4. MENÚ PRINCIPAL Y FUNCIONALIDADES
ejecutarMenu :: [Estudiante] -> IO ()
ejecutarMenu listaActual = do
    putStrLn "\n======================================="
    putStrLn "  SISTEMA DE REGISTRO UNIVERSITARIO"
    putStrLn "======================================="
    putStrLn "1. Registrar Entrada (Check In)"
    putStrLn "2. Buscar Estudiante por ID"
    putStrLn "3. Registrar Salida (Check Out)"
    putStrLn "4. Listar Estudiantes (Desde archivo)"
    putStrLn "5. Salir"
    putStr "Seleccione una opción: "
    hFlush stdout
    opcion <- getLine

    case opcion of
        "1" -> do
            putStr "ID del Estudiante: " >> hFlush stdout
            idIn <- getLine
            putStr "Minuto de entrada (0-1440): " >> hFlush stdout
            hInStr <- getLine
            let hIn = read hInStr :: Int
            let nuevo = Estudiante idIn hIn 0 True
            let nuevaLista = nuevo : listaActual
            guardarDatos nuevaLista
            ejecutarMenu nuevaLista

        "2" -> do
            putStr "ID a buscar: " >> hFlush stdout
            idBusq <- getLine
            case find (\e -> idEstudiante e == idBusq) listaActual of
                Just e -> putStrLn $ "Estado: " ++ (if estaPresente e then "DENTRO" else "SALIÓ")
                Nothing -> putStrLn "Estudiante no registrado."
            ejecutarMenu listaActual

        "3" -> do
            putStr "ID para salida: " >> hFlush stdout
            idSal <- getLine
            putStr "Minuto de salida (0-1440): " >> hFlush stdout
            hOutStr <- getLine
            let hOut = read hOutStr :: Int
            
            -- Actualizamos usando map para crear una lista nueva con el cambio [cite: 36, 40]
            let nuevaLista = map (\e -> if idEstudiante e == idSal && estaPresente e 
                                        then e { horaSalida = hOut, estaPresente = False } 
                                        else e) listaActual
            
            case find (\e -> idEstudiante e == idSal) nuevaLista of
                Just e -> putStrLn $ "Permanencia: " ++ formatearDuracion (horaSalida e - horaEntrada e)
                Nothing -> putStrLn "No se encontró al estudiante o ya salió."
            
            guardarDatos nuevaLista
            ejecutarMenu nuevaLista

        "4" -> do
            datosArchivo <- cargarDatos
            putStrLn "\n--- LISTA DE ESTUDIANTES REGISTRADOS ---"
            print datosArchivo
            ejecutarMenu datosArchivo

        "5" -> putStrLn "Cerrando sistema. ¡Hasta luego!"

        _   -> do
            putStrLn "Opción no válida."
            ejecutarMenu listaActual

-- PUNTO DE INICIO
main :: IO ()
main = do
    putStrLn "Iniciando sistema..."
    listaInicial <- cargarDatos
    ejecutarMenu listaInicial