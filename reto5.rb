class Game

  # Declaramos variables globales
  @@answer = "", @@definiciones = [], @@respuestas = []

  def initialize
    self.load_game
  end

  # Funciones que carga la interface del juego
  def load_game
    puts "Bienvenido a reto 5, Para jugar, solo ingresa el termino correcto para cada una de las definiciones, Listo? Vamos!"
    self.show_question()
  end

  # Funcion que carga desde un archivo externo las deficiones y las respuestas
  def load_def_answers
    # Expresiones regulares
    expRegDef = /Definicion/
    expRegRes = /Respuesta/
    # Lectura del archivo externo de definiciones y respuestas
    content = File.read("questions.txt")
    lines = content.split("\n")
    # Recorremos linea por linea y guardamos en un arreglo diferente para las definiciones y las respuestas
    lines.each do |line|
      if expRegDef.match(line)
        # Eliminamos del string la  palabra (Definicion) 
        line = line.sub " (Definicion)", ""
        # Agregamos al array @@definiciones la linea formateada
    		@@definiciones.push(line)
      elsif expRegRes.match(line)
        # Eliminamos del string la palabra (Respuesta)
        line = line.sub "(Respuesta)", ""
        # Eliminamos todos los espacios en blanco del string
        line = line.gsub(/\s+/, "")
        # Agregamos al array @@drespuestas la linea formateada
    		@@respuestas.push(line)
    	end
    end
  end

  # Funcion que muestra por pantalla cada definicions y evalua la respuesta dada por el usuario
  def show_question()
    band = false
    # Variable para recorrer el array de las respuestas cargadas previamente
    contador = 0
    # Cargamos las deficiones y las respuestas
    self.load_def_answers()
    #  Recorremos cada deficion cargada desde el archivo
    @@definiciones.each { |definicion|
        puts "Definición"
        puts definicion
        # Ciclo que evalua si la respuesta dada es correcta mediante una bandera   
        while !band
          print "Adivinar: "
          @@answer = gets.chomp
          if @@answer.downcase == @@respuestas[contador]
            puts "Correcto!"
            band = true
            contador += 1 
          else
            puts "Incorrecto!, Trata de nuevo"
          end
        end
        # Volvemos a asignar false a la bandera para que se vuelva a ejecutar el ciclo while en el siguiente salto  del  ciclo @@deficiones.each
        band = false
    }
  end
end

Game.new