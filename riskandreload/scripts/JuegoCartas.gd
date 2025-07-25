extends Node3D

@onready var carta_escena = preload("res://escenas/Carta.tscn")
var cartas : Array = []
var orden_correcto : Array = []
var orden_jugador : Array = []
var seleccion : int = 0

func _ready():
	generar_cartas()
	barajar_orden()
	mostrar_cartas()
	resaltar_seleccion()

func generar_cartas():
	for i in range(5):
		var carta = carta_escena.instantiate()
		carta.name = "Carta_%d" % i
		add_child(carta)
		cartas.append(carta)

func barajar_orden():
	orden_correcto = [0, 1, 2, 3, 4]
	orden_correcto.shuffle()
	orden_jugador = orden_correcto.duplicate()
	print("Orden correcto:", orden_correcto)

func mostrar_cartas():
	for i in range(5):
		var carta = cartas[i]
		var nueva_pos = Vector3(i * 2.2- 4.4, -1, 0)
		var t = carta.transform
		t.origin = nueva_pos
		carta.transform = t

func intercambiar_cartas():
	if seleccion < 4:
		# Intercambiar objetos visuales
		var temp_carta = cartas[seleccion]
		cartas[seleccion] = cartas[seleccion + 1]
		cartas[seleccion + 1] = temp_carta

		# Intercambiar los datos del orden
		var temp_orden = orden_jugador[seleccion]
		orden_jugador[seleccion] = orden_jugador[seleccion + 1]
		orden_jugador[seleccion + 1] = temp_orden

		mostrar_cartas()

func evaluar_resultado():
	var aciertos = 0
	for i in range(5):
		if orden_jugador[i] == orden_correcto[i]:
			aciertos += 1
	return aciertos

func _input(event):
	if event.is_action_pressed("ui_left"):
		seleccion = max(seleccion - 1, 0)
		resaltar_seleccion()
	elif event.is_action_pressed("ui_right"):
		seleccion = min(seleccion + 1, cartas.size() - 1)
		resaltar_seleccion()
	elif event.is_action_pressed("ui_select") or event.is_action_pressed("intercambiar"):
		intercambiar_cartas()
		resaltar_seleccion()

func resaltar_seleccion():
	for i in range(5):
		var carta = cartas[i]
		if i == seleccion:
			carta.scale = Vector3(1.2, 1.2, 1.2)
			var animador = carta.get_node("Animador")
			animador.play("seleccionada")
		else:
			carta.scale = Vector3(1.0, .5, 1.0)
