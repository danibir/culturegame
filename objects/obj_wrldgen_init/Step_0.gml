if (formCaveStep(delta_time / 1000000 * 200).complete and complete = false) {
	carveWorld()
	complete = true
	obj_eng.initGame()
}
progress = array_length(caves) / array_length(cavesWIP)
if progress < 1 {
	var currCave = cavesWIP[array_find_index(cavesWIP, function (a) {return a.complete == false})]
	var caveProg = currCave.offset / currCave.path_length / 0.85
	progress += caveProg / array_length(cavesWIP)
}