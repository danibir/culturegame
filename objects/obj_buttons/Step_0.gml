output = NaN
array_foreach(buttonList, function (button) {
	if button.state = "released" {
		output = button.value
	}
})