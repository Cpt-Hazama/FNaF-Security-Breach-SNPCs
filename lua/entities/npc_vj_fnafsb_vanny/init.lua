AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2022 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/fnaf_sb/vanny.mdl"}
ENT.StartHealth = 60

ENT.VJ_NPC_Class = {"CLASS_FNAF_ANIMATRONIC","CLASS_FNAF_BURNTRAP"}

ENT.VJC_Data = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(0, 30, -40), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "Head_jnt", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(8, 0, 0), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = false, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	FirstP_CameraBoneAng = 3, -- Should the camera's angle be affected by the bone's angle?
	FirstP_CameraBoneAng_Offset = 0, -- How much should the camera's angle be rotated by? (Useful for weird bone angles, this is the roll angle)
}

ENT.BloodColor = "Red"

ENT.HullType = HULL_HUMAN

ENT.HasMeleeAttack = true
ENT.MeleeAttackDistance = 40
ENT.MeleeAttackDamageDistance = 110
ENT.MeleeAttackAnimationFaceEnemy = false
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
	"cpthazama/fnafsb/vanessa/fx_vanny/fly_vanny_walk_01.wav",
	"cpthazama/fnafsb/vanessa/fx_vanny/fly_vanny_walk_02.wav",
	"cpthazama/fnafsb/vanessa/fx_vanny/fly_vanny_walk_03.wav",
	"cpthazama/fnafsb/vanessa/fx_vanny/fly_vanny_walk_04.wav",
	"cpthazama/fnafsb/vanessa/fx_vanny/fly_vanny_walk_05.wav",
	"cpthazama/fnafsb/vanessa/fx_vanny/fly_vanny_walk_06.wav"
}
ENT.SoundTbl_Idle = {}
ENT.SoundTbl_CombatIdle = {
	"cpthazama/fnafsb/vanessa/Vanny_Laugh_01.ogg",
	"cpthazama/fnafsb/vanessa/Vanny_Laugh_02.ogg",
	"cpthazama/fnafsb/vanessa/Vanny_Laugh_03.ogg",
	"cpthazama/fnafsb/vanessa/Vanny_Laugh_04.ogg",
	"cpthazama/fnafsb/vanessa/Vanny_Laugh_05.ogg",
	"cpthazama/fnafsb/vanessa/Vanny_Laugh_06.ogg",
}
ENT.SoundTbl_Investigate = {
	"cpthazama/fnafsb/vanessa/Vanny_VO_Fun.ogg",
	"cpthazama/fnafsb/vanessa/Vanny_VO_ISeeYou.ogg"
}
ENT.SoundTbl_LostEnemy = {
	"cpthazama/fnafsb/vanessa/VANNY_00003_001.ogg",
	"cpthazama/fnafsb/vanessa/VANNY_00003_002.ogg",
	"cpthazama/fnafsb/vanessa/VANNY_00003_003.ogg",
}
ENT.SoundTbl_Alert = {
	"cpthazama/fnafsb/vanessa/VANNY_00001.ogg",
	"cpthazama/fnafsb/vanessa/VANNY_00002_001.ogg",
	"cpthazama/fnafsb/vanessa/VANNY_00002_002.ogg",
	"cpthazama/fnafsb/vanessa/VANNY_00002_003.ogg",
	"cpthazama/fnafsb/vanessa/VANNY_00002_004.ogg",
}
ENT.SoundTbl_Pain = {}
ENT.SoundTbl_Death = {}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetSightDirection()
	return self:GetAttachment(self:LookupAttachment("eyes")).Ang:Forward()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:JumpscareOffset(ent)
	return self:GetPos() +select(2,self:GetBonePosition(1)):Forward() *30
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert(ent)
	self:VJ_FNAF_Stinger(ent,"cpthazama/fnafsb/vanessa/fx_vanny/Vanny_Chase_Stinger.wav")
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.InAttack = false

	local noSpawn = false
	for _,v in pairs(ents.FindByClass("npc_vj_fnafsb_vanessa")) do
		if IsValid(v) then
			PrintMessage(HUD_PRINTTALK, "How strange...Vanny did not appear...")
			self:Remove()
			noSpawn = true
			break
		end
	end
	if noSpawn then return end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "step" then
		VJ_EmitSound(self,self.SoundTbl_FootStep,75,math.random(90,110))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	self:SetNW2Entity("Enemy",self:GetEnemy())
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt, isProp)
	if isProp then
		return true
	end
	self:VJ_FNAF_Attack(hitEnt,VJ_GetSequenceDuration(self,ACT_MELEE_ATTACK1) -1,2,nil,"cpthazama/fnafsb/sfx_jumpScare_vanny.wav")
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDoKilledEnemy(ent, attacker, inflictor)
	if ent:IsPlayer() && attacker == self then
		net.Start("VJ_FNaF_DeathScreen_End")
			net.WriteEntity(ent)
		net.Send(ent)
	end
end