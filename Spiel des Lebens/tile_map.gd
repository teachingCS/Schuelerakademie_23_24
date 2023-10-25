extends TileMap


const TILE_SIZE : int = 128

var höhe : int = 200
var breite : int = 200

var spiel_läuft : bool = false
var temporäres_feld = []

# Called when the node enters the scene tree for the first time.
func _ready():
#	set_cell(0, Vector2i(0,0), 1, Vector2i(0,0))
	for x in range(breite):
		for y in range(höhe):
			zeichne_Zelle(x, y, 0)
	
	erzeuge_temp_feld()

func _input(event):
	if event.is_action_pressed("startstopp"):
		spiel_läuft = !spiel_läuft
	if event.is_action_pressed("mausklick"):
#		print(get_local_mouse_position())
		var xpos = int(get_local_mouse_position().x / TILE_SIZE)
		var ypos = int(get_local_mouse_position().y / TILE_SIZE)
		var pos = Vector2(xpos, ypos)
#		print(pos)
		if get_cell_source_id(0, pos) == 0:
			zeichne_Zelle(xpos, ypos, 1)
		else:
			zeichne_Zelle(xpos, ypos, 0)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	berechne_temporäres_feld()


func erzeuge_temp_feld():
	for x in range(breite):
		var zeile = []
		for y in range(höhe):
			zeile.append(0)
		temporäres_feld.append(zeile)


func zeichne_Zelle(xPosition : int, yPosition : int, tilesetID : int):
	set_cell(0, Vector2i(xPosition,yPosition), tilesetID, Vector2i(0,0))
	
func berechne_temporäres_feld():
	if not spiel_läuft:
		return
	else:
		for x in range(breite):
			for y in range(höhe):
				# lokale Variable für Nachbarzählung
				var nachbarn = 0
				# Alle benachbarten Zellen befinden sich relativ gesehen in den Spalten eins links, der gleichen Spalte und der Spalte eins rechts
				for x_relativ in [-1, 0, 1]:
					# Betrachtung der Zeilen analog zu den Spalten:
					for y_relativ in [-1, 0, 1]:
						# die Zelle selbst soll nicht in die Nachbarszählung einbezogen werden
						if not (x_relativ == 0 and y_relativ == 0):
							# ist eine Nachbarzelle mit dem Wert 1 belegt, wird die Variable nachbarn um eins erhöht
							if get_cell_source_id(0, Vector2i(x + x_relativ, y + y_relativ)) == 1:
								nachbarn = nachbarn + 1
				# Conways Regeln:
				if get_cell_source_id(0, Vector2i(x,y)) == 1:
					if (nachbarn == 2 or nachbarn == 3):
						temporäres_feld[x][y] = 1
					else:
						temporäres_feld[x][y] = 0
				else:
					if nachbarn == 3:
						temporäres_feld[x][y] = 1
					else:
						temporäres_feld[x][y] = 0
				# Ende Conways Regeln:
		aktualisiere_tilemap()

func aktualisiere_tilemap():
	for x in range(breite):
		for y in range(höhe):
			zeichne_Zelle(x,y,temporäres_feld[x][y])
