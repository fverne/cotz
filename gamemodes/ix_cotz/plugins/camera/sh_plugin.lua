PLUGIN.name = "Camera"
PLUGIN.author = "COTZ"
PLUGIN.description = "Photographs visible CotZ entities and configured spawn points."

PLUGIN.photoFOV = 90
PLUGIN.photoAspect = 16 / 9
PLUGIN.photoWidth = 1366
PLUGIN.photoHeight = 768
PLUGIN.photoRange = 2000
PLUGIN.photoCooldown = 1
PLUGIN.maxPhotoSubjects = 128

ix.util.Include("sv_plugin.lua")
ix.util.Include("cl_viewfinder.lua")
ix.util.Include("cl_plugin.lua")
