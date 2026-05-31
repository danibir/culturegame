if (formCaveStep(20).complete and complete = false) {
	carveWorld()
	complete = true
	obj_eng.initGame()
}
progress = array_length(caves) / array_length(cavesWIP)
if progress < 1 {
	var currCave = cavesWIP[array_find_index(cavesWIP, function (a) {return a.complete == false})]
	var caveProg = currCave.offset / currCave.path_length / 0.9
	progress += caveProg / array_length(cavesWIP)
}