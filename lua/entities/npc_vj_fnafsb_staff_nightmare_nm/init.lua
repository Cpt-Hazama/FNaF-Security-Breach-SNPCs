AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2022 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/fnaf_sb/staff_nightmare.mdl"}
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

ENT.BloodColor = "Oil"

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

local defSounds = {"cpthazama/fnafsb/nm/nm1.mp3","cpthazama/fnafsb/nm/nm2.mp3","cpthazama/fnafsb/nm/nm3.mp3","cpthazama/fnafsb/nm/nm4.mp3","cpthazama/fnafsb/nm/nm5.mp3"}
ENT.SoundTbl_Idle = defSounds
ENT.SoundTbl_Alert = defSounds
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetSightDirection()
	return self:GetAttachment(self:LookupAttachment("eyes")).Ang:Forward()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnShocked()
	self:StopAllCommonSounds()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.InAttack = false

	self:SetCollisionBounds(Vector(13,13,82),Vector(-13,-13,0))

	self.MoveLoopSound = CreateSound(self,"cpthazama/fnafsb/bot/sfx_staffBot_wheels_lp_0" .. math.random(1,3) .. ".wav")
	self.MoveLoopSound:SetSoundLevel(60)
	self.LoopSound = CreateSound(self,"cpthazama/fnafsb/nm/Distortion.wav")
	self.LoopSound:SetSoundLevel(60)
	self.LoopSound:Play()

	ParticleEffectAttach("vj_fnaf_nightmare_aura",PATTACH_POINT_FOLLOW,self,self:LookupAttachment("origin"))

	for i = 1,2 do
		local att = i == 2 && "eyeR" or "eyeL"
		local eyeGlow = ents.Create("env_sprite")
		eyeGlow:SetKeyValue("model","sprites/cpthazama/fnafsb/eye_flare3.vmt")
		eyeGlow:SetKeyValue("scale","0.08")
		eyeGlow:SetKeyValue("rendermode","9")
		eyeGlow:SetKeyValue("rendercolor","255 255 255")
		eyeGlow:SetKeyValue("spawnflags","1")
		eyeGlow:SetParent(self)
		eyeGlow:Fire("SetParentAttachment",att,0)
		eyeGlow:Spawn()
		eyeGlow:Activate()
		self:DeleteOnRemove(eyeGlow)

		local eyeGlow = ents.Create("env_sprite")
		eyeGlow:SetKeyValue("model","sprites/cpthazama/fnafsb/eye_flare2.vmt")
		eyeGlow:SetKeyValue("scale","0.02")
		eyeGlow:SetKeyValue("rendermode","9")
		eyeGlow:SetKeyValue("rendercolor","255 255 255")
		eyeGlow:SetKeyValue("spawnflags","1")
		eyeGlow:SetParent(self)
		eyeGlow:Fire("SetParentAttachment",att,0)
		eyeGlow:Spawn()
		eyeGlow:Activate()
		self:DeleteOnRemove(eyeGlow)

		-- local stWidth = 2
		-- local edWidth = 0
		-- local time = 0.1
		-- local resolution = 1 /(10 +1) *0.5
		-- util.SpriteTrail(self,i +2,Color(255,255,255,240),false,stWidth,edWidth,time,resolution,"VJ_Base/sprites/vj_trial1.vmt")
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink_AIEnabled()
	local movingFast = self:GetMovementActivity() == ACT_RUN
	self.MoveLoopSound:ChangePitch(movingFast && 115 or 100)
	self.MoveLoopSound:ChangeVolume(movingFast && 1 or 0.6)
	if self:IsMoving() then
		if !self.MoveLoopPlaying then
			self.MoveLoopPlaying = true
			self:PlayMoveLoop()
		end
	else
		self:StopMovementSound()
		self.MoveLoopPlaying = false
	end

	self.LoopSound:Play()

	local ent = self:GetEnemy()
	local anim = self:GetActivity()
	local dist = self.NearestPointToEnemyDistance
	local viewers = self:VJ_FNaF_GetViewers()
	for _,v in pairs(viewers) do
		if IsValid(v) then
			v.VJ_FNAF_NightmareDMGT = v.VJ_FNAF_NightmareDMGT or 0
			if CurTime() < v.VJ_FNAF_NightmareDMGT then continue end
			v:TakeDamage(1,self,self)
			v.VJ_FNAF_NightmareDMGT = CurTime() +0.25
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt,isProp)
	if isProp then
		return true
	end
	self:VJ_FNAF_Attack(hitEnt,VJ_GetSequenceDuration(self,ACT_MELEE_ATTACK1),2,nil,"cpthazama/fnafsb/nm/Scream.mp3")
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
function ENT:PlayMoveLoop()
	self.MoveLoopSound:Stop()
	self.MoveLoopSound:Play()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:StopMovementSound()
	self.MoveLoopSound:Stop()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:PlayMovementSound()
	if self:IsMoving() then
		self.MoveLoopPlaying = true
		self:PlayMoveLoop()
	else
		self.MoveLoopPlaying = false
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	self.LoopSound:Stop()
	self.MoveLoopSound:Stop()
end