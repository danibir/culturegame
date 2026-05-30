var objs = tag_get_assets("depthed")
function depthAssets (assetType) {
	with asset_get_index(assetType) {
		depth = -y
	}
}

if is_array(objs) {
	for (var i = 0; i < array_length(objs); i++) {
		depthAssets(objs[i])
	}
} else {
	depthAssets(objs)
}