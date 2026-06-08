draw_set_alpha(1)
draw_set_colour(c_black)
for (var i = 0; i < array_length(voidSquaresPos); i++)
{
	var square = voidSquaresPos[i]
	var size = obj_eng.gridSize / 2
	draw_rectangle(square.x - size, square.y - size, square.x + size, square.y + size, false)
}
