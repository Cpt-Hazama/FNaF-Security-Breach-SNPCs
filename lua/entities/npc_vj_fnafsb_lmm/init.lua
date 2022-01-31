AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2022 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/fnaf_sb/lmm.mdl"}
ENT.StartHealth = 50

ENT.VJ_NPC_Class = {"CLASS_FNAF_ANIMATRONIC"}

ENT.VJC_Data = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(0, 30, -10), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "Head_jnt", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(8, 0, 5), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = false, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	FirstP_CameraBoneAng = 3, -- Should the camera's angle be affected by the bone's angle?
	FirstP_CameraBoneAng_Offset = -90, -- How much should the camera's angle be rotated by? (Useful for weird bone angles, this is the roll angle)
}

ENT.Bleeds = false

ENT.HullType = HULL_TINY

ENT.HasMeleeAttack = true
ENT.MeleeAttackDistance = 20
ENT.MeleeAttackDamageDistance = 75
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
ENT.TimeUntilMeleeAttackDamage = 0
ENT.DisableDefaultMeleeAttackDamageCode = true
ENT.StopMeleeAttackAfterFirstHit = true

ENT.CallForHelp = false

ENT.AttackProps = false
ENT.PushProps = false

ENT.GibOnDeathDamagesTable = {"All"}

ENT.FootStepTimeRun = 0.05
ENT.FootStepTimeWalk = 0.15
ENT.GeneralSoundPitch1 = 100
ENT.GeneralSoundPitch2 = 100

ENT.NextSoundTime_Idle = VJ_Set(9, 15)
ENT.NextSoundTime_Investigate = VJ_Set(6, 8)
ENT.NextSoundTime_LostEnemy = VJ_Set(8, 15)
ENT.NextSoundTime_Alert = VJ_Set(7, 15)
ENT.NextSoundTime_OnKilledEnemy = VJ_Set(6, 9)
ENT.NextSoundTime_DamageByPlayer = VJ_Set(5, 8)

ENT.SoundTbl_FootStep = {
	"cpthazama/fnafsb/lmm/fx/fly_lmm_walk_01.wav",
	"cpthazama/fnafsb/lmm/fx/fly_lmm_walk_02.wav",
	"cpthazama/fnafsb/lmm/fx/fly_lmm_walk_03.wav",
	"cpthazama/fnafsb/lmm/fx/fly_lmm_walk_04.wav",
	"cpthazama/fnafsb/lmm/fx/fly_lmm_walk_07.wav",
	"cpthazama/fnafsb/lmm/fx/fly_lmm_walk_08.wav",
	"cpthazama/fnafsb/lmm/fx/fly_lmm_walk_10.wav"
}

ENT.FootStepSoundLevel = 50

local nwName = "VJ_FNaF_LMM_Controller"
util.AddNetworkString(nwName)
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_Initialize(ply)
	local opt1, opt2, opt3 = self, self:GetClass(), self.VJ_TheControllerEntity
    net.Start(nwName)
		net.WriteBool(false)
		net.WriteEntity(opt1)
		net.WriteString(opt2)
		net.WriteEntity(ply)
		net.WriteEntity(opt3)
    net.Send(ply)

	function self.VJ_TheControllerEntity:CustomOnStopControlling()
		net.Start(nwName)
			net.WriteBool(true)
			net.WriteEntity(opt1)
			net.WriteString(opt2)
			net.WriteEntity(ply)
			net.WriteEntity(opt3)
		net.Send(ply)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetSightDirection()
	return self:GetAttachment(self:LookupAttachment("eyes")).Ang:Forward()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.InAttack = false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "mus" then
		VJ_EmitSound(self,"cpthazama/fnafsb/lmm/fx/fly_lmm_cymbal_smash_0" .. math.random(1,5) .. ".wav",80)
	elseif key == "teeth" then
		VJ_CreateSound(self,"cpthazama/fnafsb/lmm/fx/fly_lmm_teeth_chomp_scrape_0" .. math.random(1,5) .. ".wav",55)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt, isProp)
	if isProp then
		return true
	end
	self:VJ_FNAF_Attack(hitEnt,VJ_GetSequenceDuration(self,ACT_MELEE_ATTACK1),2,nil,"cpthazama/fnafsb/sfx_jumpScare_scream.wav")
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
---------------------------------------------------------------------------------------------------------------------------------------------
local defAng = Angle(0, 0, 0)
--
function ENT:CustomOnKilled(dmginfo, hitgroup)
	local startPos = self:GetPos() + self:OBBCenter()
	ParticleEffect("explosion_turret_break_fire", startPos, defAng, NULL)
	ParticleEffect("explosion_turret_break_flash", startPos, defAng, NULL)
	ParticleEffect("explosion_turret_break_pre_smoke Version #2", startPos, defAng, NULL)
	ParticleEffect("explosion_turret_break_sparks", startPos, defAng, NULL)
end
---------------------------------------------------------------------------------------------------------------------------------------------
local sdGibCollide = {"physics/metal/metal_box_impact_hard1.wav", "physics/metal/metal_box_impact_hard2.wav", "physics/metal/metal_box_impact_hard3.wav"}
--
function ENT:SetUpGibesOnDeath(dmginfo, hitgroup)
	self.HasDeathSounds = false
	self:CreateGibEntity("obj_vj_gib","models/gibs/metal_gib1.mdl", {BloodType="",Pos=self:LocalToWorld(Vector(0,0,10)), CollideSound=sdGibCollide})
	self:CreateGibEntity("obj_vj_gib","models/gibs/metal_gib1.mdl", {BloodType="",Pos=self:LocalToWorld(Vector(0,0,14)), CollideSound=sdGibCollide})
	self:CreateGibEntity("obj_vj_gib","models/gibs/metal_gib1.mdl", {BloodType="",Pos=self:LocalToWorld(Vector(0,0,6)), CollideSound=sdGibCollide})
	self:CreateGibEntity("obj_vj_gib","models/gibs/metal_gib4.mdl", {BloodType="",Pos=self:LocalToWorld(Vector(0,0,18)), CollideSound=sdGibCollide})
	self:CreateGibEntity("obj_vj_gib","models/gibs/metal_gib4.mdl", {BloodType="",Pos=self:LocalToWorld(Vector(0,0,15)), CollideSound=sdGibCollide})
	self:CreateGibEntity("obj_vj_gib","models/gibs/metal_gib4.mdl", {BloodType="",Pos=self:LocalToWorld(Vector(0,0,13)), CollideSound=sdGibCollide})
	self:CreateGibEntity("obj_vj_gib","models/gibs/shield_scanner_gib1.mdl", {BloodType="",Pos=self:LocalToWorld(Vector(0,0,20)), CollideSound=sdGibCollide})
	self:CreateGibEntity("obj_vj_gib","models/gibs/metal_gib5.mdl", {BloodType="",Pos=self:LocalToWorld(Vector(0,0,25)), CollideSound=sdGibCollide})
	self:CreateGibEntity("obj_vj_gib","models/gibs/metal_gib5.mdl", {BloodType="",Pos=self:LocalToWorld(Vector(0,0,5)), CollideSound=sdGibCollide})
	return true -- Return to true if it gibbed!
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomGibOnDeathSounds(dmginfo, hitgroup)
	VJ_EmitSound(self, "npc/turret_floor/detonate.wav", 90, 100)
	return false
end