buttonList = []
createButton = function (value, displaytext, xpos, ypos, xscale, yscale) {
	var button = instance_create_layer(xpos, ypos, "UI", obj_button)
	button.value = value
	button.displayText = displaytext
	button.image_xscale = xscale
	button.image_yscale = yscale
	button.xpos = xpos
	button.ypos = ypos
	
	array_push(buttonList, button)
}
output = NaN