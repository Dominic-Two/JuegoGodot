extends Node3D

@onready var juego_cartas_escena = preload("res://escenas/JuegoCartas.tscn")

var jugador1: Node3D
var jugador2: Node3D

enum Turno { JUGADOR1, JUGADOR2, FINAL }
var turno_actual: Turno = Turno.JUGADOR1
var ronda_terminada := false

var orden_secreto: Array = []

func _ready():
	orden_secreto = [0, 1, 2, 3, 4]
	orden_secreto.shuffle()
	print("Orden secreto de la ronda:", orden_secreto)

	# Instanciar, añadir y luego inicializar
	jugador1 = juego_cartas_escena.instantiate()
	add_child(jugador1)
#	jugador1.translation = Vector3(0, 1, -2)
	jugador1.initialize(orden_secreto)

	jugador2 = juego_cartas_escena.instantiate()
	add_child(jugador2)
#	jugador2.translation = Vector3(0, 1, 2)
	jugador2.rotation_degrees.y = 180
	jugador2.initialize(orden_secreto)

	print("Turno de Jugador 1")
	jugador1.set_process_input(true)
	jugador2.set_process_input(false)

func _input(event):
	if event.is_action_pressed("ui_accept") and not ronda_terminada:
		match turno_actual:
			Turno.JUGADOR1:
				jugador1.set_process_input(false)
				jugador2.set_process_input(true)
				turno_actual = Turno.JUGADOR2
				get_tree().current_scene.mover_camara_a_jugador(.25)
				print("Turno de Jugador 2")
			Turno.JUGADOR2:
				jugador2.set_process_input(false)
				evaluar_ronda()
				turno_actual = Turno.FINAL

func evaluar_ronda():
	var aciertos_j1 = jugador1.evaluar_resultado()
	var aciertos_j2 = jugador2.evaluar_resultado()

	print("Jugador 1 acertó:", aciertos_j1)
	print("Jugador 2 acertó:", aciertos_j2)

	if aciertos_j1 > aciertos_j2:
		print("¡Jugador 1 gana la ronda!")
	elif aciertos_j2 > aciertos_j1:
		print("¡Jugador 2 gana la ronda!")
	else:
		print("¡Empate!")

	ronda_terminada = true
