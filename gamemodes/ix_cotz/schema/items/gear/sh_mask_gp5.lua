ITEM.name = "GP5"
ITEM.description = "An old gasmask"
ITEM.longdesc = "Cheap rubber gas mask of soviet origin, paired with a modern non-asbestos filter. Due to odd shape, it doesn't fit with all types of helmets."
ITEM.model = "models/shtokerbox/ground_mask_gp5.mdl"

ITEM.price = 21000
ITEM.weight = 0.6

ITEM.isGasmask = true
ITEM.isHelmet = false
-- 
ITEM.br = 0.00
ITEM.fbr = 0
ITEM.ar = 0
ITEM.far = 0
ITEM.radProt = 0.10

-- ITEM.exRender = true
-- ITEM.iconCam = {
-- 	pos = Vector(0, 0, 200),
-- 	ang = Angle(90, 90, 0),
-- 	fov = 3.85
-- }
ITEM.img = ix.util.GetMaterial("vgui/hud/gp5.png", "noclamp smooth")

ITEM.pacData = {
	[1] = {
        ["children"] = {
                [1] = {
                        ["children"] = {
                        },
                        ["self"] = {
                                ["Skin"] = 0,
                                ["UniqueID"] = "9f1780df13bc6e25c66ae1801138fbe2806dc3aef27d5cdbcc4cf23d267a4a5a",
                                ["NoLighting"] = false,
                                ["AimPartName"] = "",
                                ["IgnoreZ"] = false,
                                ["AimPartUID"] = "",
                                ["Materials"] = "",
                                ["Name"] = "",
                                ["LevelOfDetail"] = 0,
                                ["NoTextureFiltering"] = false,
                                ["PositionOffset"] = Vector(0, 0, 0),
                                ["IsDisturbing"] = false,
                                ["EyeAngles"] = false,
                                ["DrawOrder"] = 0,
                                ["TargetEntityUID"] = "",
                                ["Alpha"] = 1,
                                ["Material"] = "",
                                ["Invert"] = false,
                                ["ForceObjUrl"] = false,
                                ["Bone"] = "head",
                                ["Angles"] = Angle(1.2023075441903e-06, -78.995674133301, -90.000015258789),
                                ["AngleOffset"] = Angle(0, 0, 0),
                                ["BoneMerge"] = false,
                                ["Color"] = Vector(1, 1, 1),
                                ["Position"] = Vector(-67.764404296875, -12.5390625, 0.0048828125),
                                ["ClassName"] = "model2",
                                ["Brightness"] = 1,
                                ["Hide"] = false,
                                ["NoCulling"] = false,
                                ["Scale"] = Vector(1, 1.039999961853, 1),
                                ["LegacyTransform"] = false,
                                ["EditorExpand"] = false,
                                ["Size"] = 1.06,
                                ["ModelModifiers"] = "",
                                ["Translucent"] = false,
                                ["BlendMode"] = "",
                                ["EyeTargetUID"] = "",
                                ["Model"] = "models/shtokerbox/headgear/male_mask_gp5.mdl",
                        },
                },
        },
        ["self"] = {
                ["DrawOrder"] = 0,
                ["UniqueID"] = "e002c917f1d4866bf1ca90131651ec2caf6d49d4bed526d0818ea9e6ebfc1cf3",
                ["Hide"] = false,
                ["TargetEntityUID"] = "",
                ["EditorExpand"] = true,
                ["OwnerName"] = "self",
                ["IsDisturbing"] = false,
                ["Name"] = "",
                ["Duplicate"] = false,
                ["ClassName"] = "group",
        },
},

}
