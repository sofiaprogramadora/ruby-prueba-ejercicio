menu = %Q{1. Generar un archivo con el nombre de cada alumno y el promedio de sus notas.
2. Contar la cantidad de inasistencias totales y mostrarlas en pantalla.
3. Mostrar que alumnos aprobaron
4. Salir
}

class Alumno
	attr_accessor :notas, :nombre
	def initialize(nombre, *splat)
		@notas = []
		splat.each do |i|
			i.each do |io|
				@notas << io.to_i unless io == "A"
				@notas << io unless io != "A"
			end
		end
		@nombre = nombre
	end

	def aprove?(min = 5)
		nota = []
		@notas.each do |i|
			if i.to_i >= min
				nota << true
			end
		end
		"#{@nombre} - Aprovado!" if nota.include?(true)
	end

	def promedio()
		sum = 0
		@notas.each do |i|
			sum += i.to_i
		end
		total = (sum/@notas.size)
		return total
	end
end

data = nil
file = File.open("alumnos.csv", "r") { |filem| data = filem.readlines }

puts menu
input = gets.chomp.to_i

newdata = []
data.each do |i|
	ii = i.split(", ")
	newdata << Alumno.new(ii[0], ii[1..(ii.size)] )
end

while input != 4
	if input == 1
	nfile = File.open("alumnos_promedios.txt", "w")
		newdata.each do |i|
			nfile.print "#{i.nombre} #{i.promedio}"
			nfile.puts
		end
	nfile.close
	elsif input == 2
		newdata.each do |i|
			i.notas.each do |ii|
				puts "#{i.nombre} - #{ii} " if ii == "A"
			end
		end
    elsif input == 3
        print "Minimo: "
        numinput = gets.to_i
        if numinput == 0
            numinput = 5
        end
        newdata.each do |i|
            puts i.aprove?(numinput)
        end
    else
        puts "Porfavor ingrese un comando valido: "
	end
	puts menu
	input = gets.chomp.to_i
end
