cam = instance_create_layer(room_width / 2, room_height / 2, "Instances", obj_cam)
cam.zoom = 0.25
cam.freeCam = true

buttonmenu = noone
note = instance_create_layer(room_width / 2, room_height / 2, "UI", obj_note)
note.image_xscale = 16
note.image_yscale = 24
note.text = "ble desverre ikke helt i mål med hensikten, men mange grunnlegende ting er på plass, med et par som trenger litt restrukturering. jeg har laget map generator, basic ai med et sosial system (ikke uttrykket mye). selvom den ikke ble ferdig innen fristen (eller fristen etter fristen), så har jeg tenkt til å fortsette å jobbe med prosjektet gjennom sommeren. evt kan sende nye iterasjoner"