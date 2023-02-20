AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2022 by Cpt. Hazama,All rights reserved. ***
	No parts of this code or any of its contents may be reproduced,copied,modified or adapted,
	without the prior written consent of the author,unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/fnaf_sb/vanessa.mdl"}
ENT.StartHealth = 60

ENT.VJ_NPC_Class = {"CLASS_FNAF_ANIMATRONIC"}

ENT.PoseParameterLooking_InvertYaw = true

ENT.VJC_Data = {
	CameraMode = 1,-- Sets the default camera mode | 1 = Third Person,2 = First Person
	ThirdP_Offset = Vector(0,30,-40),-- The offset for the controller when the camera is in third person
	FirstP_Bone = "Head_jnt",-- If left empty,the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(8,0,0),-- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = false,-- Should the bone shrink? Useful if the bone is obscuring the player"s view
	FirstP_CameraBoneAng = 3, -- Should the camera's angle be affected by the bone's angle?
	FirstP_CameraBoneAng_Offset = 0, -- How much should the camera's angle be rotated by? (Useful for weird bone angles, this is the roll angle)
}

ENT.BloodColor = "Red"

ENT.HullType = HULL_HUMAN

ENT.HasMeleeAttack = true
ENT.MeleeAttackDistance = 40
ENT.MeleeAttackDamageDistance = 110
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
ENT.TimeUntilMeleeAttackDamage = 0
ENT.DisableDefaultMeleeAttackDamageCode = true
ENT.StopMeleeAttackAfterFirstHit = true

ENT.AttackProps = false
ENT.PushProps = false

ENT.DisableFootStepSoundTimer = true
ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100

ENT.NextSoundTime_Idle = VJ_Set(9, 15)
ENT.NextSoundTime_Investigate = VJ_Set(6, 8)
ENT.NextSoundTime_LostEnemy = VJ_Set(8, 15)
ENT.NextSoundTime_Alert = VJ_Set(7, 15)
ENT.NextSoundTime_OnKilledEnemy = VJ_Set(6, 9)
ENT.NextSoundTime_DamageByPlayer = VJ_Set(5, 8)

ENT.SoundTbl_FootStep = {
	"cpthazama/fnafsb/common/step.wav"
}
ENT.SoundTbl_Idle = {
	"cpthazama/fnafsb/vanessa/VANESSA_00019_pref.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_00020_pref.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_00021_pref.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_00028_pref.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_00029_pref.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_00030_pref.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_00030b.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_00031_pref.ogg",
}
ENT.SoundTbl_CombatIdle = {}
ENT.SoundTbl_Investigate = {
	"cpthazama/fnafsb/vanessa/VANESSA_00024.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_GASP_001.ogg",
	"cpthazama/fnafsb/vanessa/Vanessa_VO_Searching_Hello_01.ogg",
	"cpthazama/fnafsb/vanessa/Vanessa_VO_Searching_HeretoHelp_01.ogg",
	"cpthazama/fnafsb/vanessa/Vanessa_VO_Searching_IsThatYou_01.ogg",
	"cpthazama/fnafsb/vanessa/Vanessa_VO_Searching_PleaseComeOut_01.ogg",
	"cpthazama/fnafsb/vanessa/Vanessa_VO_Searching_SomeoneThere_01.ogg",
	"cpthazama/fnafsb/vanessa/Vanessa_VO_Searching_TrustMe_01.ogg"
}
ENT.SoundTbl_LostEnemy = {
	"cpthazama/fnafsb/vanessa/VANESSA_00014.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_00017.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_00022_pref01.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_00023_pref.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_00026_pref01.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_00027.ogg",
}
ENT.SoundTbl_Alert = {
	"cpthazama/fnafsb/vanessa/VANESSA_00005.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_00007.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_00016.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_00025.ogg",
}
ENT.SoundTbl_CallForHelp = {
	"cpthazama/fnafsb/vanessa/VANESSA_00010.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_00011.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_00015.ogg",
}
ENT.SoundTbl_Pain = {
	"cpthazama/fnafsb/vanessa/VANESSA_EXERT_001.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_EXERT_002.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_EXERT_003.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_EXERT_004.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_EXERT_005.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_EXERT_006.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_EXERT_007.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_EXERT_008.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_EXERT_009.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_EXERT_010.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_EXERT_011.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_EXERT_012.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_EXERT_013.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_EXERT_014.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_EXERT_015.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_EXERT_016.ogg"
}
ENT.SoundTbl_Death = {
	"cpthazama/fnafsb/vanessa/VANESSA_OOF_001.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_OOF_002.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_OOF_003.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_OOF_004.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_OOF_005.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_OOF_006.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_OOF_007.ogg"
}
ENT.SoundTbl_Shock = {
	"cpthazama/fnafsb/vanessa/VANESSA_LIGHT_FLASH_001.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_LIGHT_FLASH_002.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_LIGHT_FLASH_003.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_LIGHT_FLASH_004.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_LIGHT_FLASH_005.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_LIGHT_FLASH_006.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_LIGHT_FLASH_007.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_LIGHT_FLASH_008.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_LIGHT_FLASH_009.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_LIGHT_FLASH_010.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_LIGHT_FLASH_011.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_LIGHT_FLASH_012.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_LIGHT_FLASH_013.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_LIGHT_FLASH_014.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_LIGHT_FLASH_015.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_LIGHT_FLASH_016.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_LIGHT_FLASH_017.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_LIGHT_FLASH_018.ogg",
	"cpthazama/fnafsb/vanessa/VANESSA_LIGHT_FLASH_019.ogg"
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetSightDirection()
	return self:GetAttachment(self:LookupAttachment("eyes")).Ang:Forward()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnShocked()
	self:StopAllCommonSounds()
	self.ShockSound = VJ_CreateSound(self,self.SoundTbl_Shock)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.InAttack = false

	local noSpawn = false
	for _,v in pairs(ents.FindByClass("npc_vj_fnafsb_vanny")) do
		if IsValid(v) then
			PrintMessage(HUD_PRINTTALK, "How strange...Vanessa did not appear...")
			self:Remove()
			noSpawn = true
			break
		end
	end
	if noSpawn then return end

	local envLight = ents.Create("env_projectedtexture")
	envLight:SetLocalPos(self:GetPos())
	envLight:SetLocalAngles(self:GetAngles())
	envLight:SetKeyValue("lightcolor","255 255 255")
	envLight:SetKeyValue("lightfov","40")
	envLight:SetKeyValue("farz","1000")
	envLight:SetKeyValue("nearz","10")
	envLight:SetKeyValue("shadowquality","1")
	envLight:Input("SpotlightTexture",NULL,NULL,"effects/flashlight001")
	envLight:SetOwner(self)
	envLight:SetParent(self)
	envLight:Spawn()
	envLight:Fire("setparentattachment","flashlight1")
	self:DeleteOnRemove(envLight)

	local glow1 = ents.Create("env_sprite")
	glow1:SetKeyValue("model","sprites/light_ignorez.vmt")
	glow1:SetKeyValue("scale","2")
	glow1:SetKeyValue("rendermode","9")
	glow1:SetKeyValue("rendercolor","255 255 255")
	glow1:SetKeyValue("spawnflags","0.1")
	glow1:SetParent(self)
	glow1:SetOwner(self)
	glow1:Fire("SetParentAttachment","flashlight1",0)
	glow1:Spawn()
	self:DeleteOnRemove(glow1)

	local glowLight = ents.Create("light_dynamic")
	glowLight:SetKeyValue("brightness","4")
	glowLight:SetKeyValue("distance","30")
	glowLight:SetLocalPos(self:GetPos() +self:OBBCenter())
	glowLight:SetLocalAngles(self:GetAngles())
	glowLight:Fire("Color", "255 255 255")
	glowLight:SetParent(self)
	glowLight:SetOwner(self)
	glowLight:Spawn()
	glowLight:Fire("TurnOn","",0)
	glowLight:Fire("SetParentAttachment","flashlight1",0)
	self:DeleteOnRemove(glowLight)

	self.Light = envLight
	self.LightGlow = glow1
	self.LightGlowDynamic = glowLight

	for i = 87,93 do
		self:ManipulateBoneJiggle(i,1)
	end
	for i = 94,98 do
		self:ManipulateBoneJiggle(i,1)
	end
	-- for i = 1,123 do -- What fucking horror is this???????
	-- 	self:ManipulateBoneJiggle(i,1)
	-- end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local matStepSounds = {
	[MAT_ANTLION] = {
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_concrete_walk_01.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_concrete_walk_02.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_concrete_walk_03.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_concrete_walk_04.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_concrete_walk_05.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_concrete_walk_06.ogg",
	},
	[MAT_BLOODYFLESH] = {
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_01.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_02.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_03.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_04.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_05.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_06.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_07.ogg",
	},
	[MAT_CONCRETE] = {
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_concrete_walk_01.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_concrete_walk_02.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_concrete_walk_03.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_concrete_walk_04.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_concrete_walk_05.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_concrete_walk_06.ogg",
	},
	[MAT_DIRT] = {
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_01.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_02.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_03.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_04.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_05.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_06.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_07.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_08.ogg",
	},
	[MAT_FLESH] = {
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_01.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_02.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_03.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_04.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_05.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_06.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_07.ogg",
	},
	[MAT_GRATE] = {
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_metal_walk_01.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_metal_walk_02.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_metal_walk_03.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_metal_walk_04.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_metal_walk_05.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_metal_walk_06.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_metal_walk_07.ogg",
	},
	[MAT_ALIENFLESH] = {
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_01.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_02.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_03.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_04.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_05.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_06.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_07.ogg",
	},
	[74] = { -- Snow
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_playmat_walk_01.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_playmat_walk_02.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_playmat_walk_03.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_playmat_walk_04.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_playmat_walk_05.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_playmat_walk_06.ogg",
	},
	[MAT_PLASTIC] = {
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_hardPlastic_walk_01.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_hardPlastic_walk_02.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_hardPlastic_walk_03.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_hardPlastic_walk_04.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_hardPlastic_walk_05.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_hardPlastic_walk_06.ogg",
	},
	[MAT_METAL] = {
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_metal_walk_01.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_metal_walk_02.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_metal_walk_03.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_metal_walk_04.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_metal_walk_05.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_metal_walk_06.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_metal_walk_07.ogg",
	},
	[MAT_SAND] = {
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_01.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_02.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_03.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_04.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_05.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_06.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_07.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_08.ogg",
	},
	[MAT_FOLIAGE] = {
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_01.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_02.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_03.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_04.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_05.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_06.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_07.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_08.ogg",
	},
	[MAT_COMPUTER] = {
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_hardPlastic_walk_01.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_hardPlastic_walk_02.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_hardPlastic_walk_03.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_hardPlastic_walk_04.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_hardPlastic_walk_05.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_hardPlastic_walk_06.ogg",
	},
	[MAT_SLOSH] = {
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_01.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_02.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_03.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_04.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_05.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_06.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_mud_run_07.ogg",
	},
	[MAT_TILE] = {
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_hardTile_walk_01.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_hardTile_walk_02.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_hardTile_walk_03.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_hardTile_walk_04.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_hardTile_walk_05.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_hardTile_walk_06.ogg",
	},
	[85] = { -- Grass
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_01.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_02.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_03.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_04.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_05.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_06.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_07.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_dirt_run_08.ogg",
	},
	[MAT_VENT] = {
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_metal_walk_01.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_metal_walk_02.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_metal_walk_03.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_metal_walk_04.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_metal_walk_05.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_metal_walk_06.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_metal_walk_07.ogg",
	},
	[MAT_WOOD] = {
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_wood_run_01.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_wood_run_02.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_wood_run_03.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_wood_run_04.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_wood_run_05.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_wood_run_06.ogg",
	},
	[MAT_GLASS] = {
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_hardTile_walk_01.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_hardTile_walk_02.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_hardTile_walk_03.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_hardTile_walk_04.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_hardTile_walk_05.ogg",
		"cpthazama/fnafsb/vanessa/fx/fly_vanessa_hardTile_walk_06.ogg",
	}
}
--
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "step" then
		if !self:IsOnGround() then return end
		local tr = util.TraceLine({
			start = self:GetPos(),
			endpos = self:GetPos() +Vector(0,0,-32),
			filter = self
		})
		local matTable = matStepSounds[tr.MatType]
		local waterLVL = self:WaterLevel()
		local vol = self.FootStepSoundLevel or 70
		local pit = self:VJ_DecideSoundPitch(self.FootStepPitch1 or 95,self.FootStepPitch2 or 105) or 100
		if tr.Hit && matTable then
			VJ_EmitSound(self,matTable,75,math.random(90,110))
		end
		if waterLVL > 0 && waterLVL < 3 then
			VJ_EmitSound(self,"player/footsteps/wade" .. math.random(1,8) .. ".wav",vol,pit)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert(ent)
	self:VJ_FNAF_Stinger(ent)
	self:SetIdleAnimation({ACT_IDLE_ANGRY},true)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnResetEnemy()
	self:SetIdleAnimation({ACT_IDLE},true)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local string_find = string.find
local string_lower = string.lower
--
function ENT:OnPlayCreateSound(SoundData,SoundFile)
	if string_find(string_lower(SoundFile),"jumpscare") then return end
	if string_find(SoundFile,"fx") then return end
	if SoundFile == "cpthazama/fnafsb/flashlight.wav" then return end
	self.NextMouthT = CurTime() +VJ_SoundDuration(SoundFile)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	self:VJ_FNaF_MouthCode()
	if self:GetSequenceName(self:GetSequence()) == "jumpscare" then
		self.LightGlow:Input("ToggleSprite")
		self.LightGlow:Input("SetScale",nil,nil,"0.3")
		self.LightGlowDynamic:Input("Toggle")
		VJ_CreateSound(self,"cpthazama/fnafsb/flashlight.wav",40,math.random(95,115))
	else
		self.LightGlow:Input("ShowSprite")
		self.LightGlow:Input("SetScale",nil,nil,"2")
		self.LightGlowDynamic:Input("TurnOn")
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt,isProp)
	if isProp then
		return true
	end
	VJ_CreateSound(self,"cpthazama/fnafsb/vanessa/VANESSA_00006.ogg")
	self:VJ_FNAF_Attack(hitEnt,VJ_GetSequenceDuration(self,ACT_MELEE_ATTACK1),2,nil,"cpthazama/fnafsb/sfx_jumpScare_scream.wav")
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDoKilledEnemy(ent,attacker,inflictor)
	if ent:IsPlayer() && attacker == self then
		net.Start("VJ_FNaF_DeathScreen_End")
			net.WriteEntity(ent)
		net.Send(ent)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	if self.ShockSound then self.ShockSound:Stop() end
end