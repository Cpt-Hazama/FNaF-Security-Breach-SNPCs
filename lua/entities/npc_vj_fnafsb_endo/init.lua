AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2022 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/fnaf_sb/endo.mdl"}
ENT.StartHealth = 450

ENT.VJ_NPC_Class = {"CLASS_FNAF_ANIMATRONIC","CLASS_FNAF_BURNTRAP"}

ENT.VJC_Data = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(0, 30, -40), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "Head_jnt", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(8, 0, 0), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = false, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	FirstP_UseBoneAng = true, -- Should the camera's angle be affected by the bone's angle?
	FirstP_BoneAngAdjust = 0, -- How much should the camera's angle be rotated by? (Useful for weird bone angles, this is the roll angle)
}

ENT.Bleeds = false

ENT.HullType = HULL_HUMAN

ENT.HasMeleeAttack = true
ENT.MeleeAttackDistance = 40
ENT.MeleeAttackDamageDistance = 110
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
ENT.TimeUntilMeleeAttackDamage = 0
ENT.DisableDefaultMeleeAttackDamageCode = true
ENT.StopMeleeAttackAfterFirstHit = true

ENT.CallForHelp = false

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
	"cpthazama/fnafsb/endo/fly_endo_walk_01.wav",
	"cpthazama/fnafsb/endo/fly_endo_walk_02.wav",
	"cpthazama/fnafsb/endo/fly_endo_walk_03.wav",
	"cpthazama/fnafsb/endo/fly_endo_walk_04.wav",
	"cpthazama/fnafsb/endo/fly_endo_walk_05.wav",
	"cpthazama/fnafsb/endo/fly_endo_walk_06.wav",
	"cpthazama/fnafsb/endo/fly_endo_walk_07.wav",
	"cpthazama/fnafsb/endo/fly_endo_walk_08.wav",
	-- "cpthazama/fnafsb/endo/fly_endo_walk_09.wav"
}

ENT.EndoType = 0

local nwName = "VJ_FNaF_Endo_Controller"
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
	self.WasSeen = false
	self.PlayingDead = false
	self.PlayDeadT = 0
	self.NextPlayDeadT = CurTime() +math.random(8,25)
	self.EyeFX = {}

	self:SetCollisionBounds(Vector(13,13,80),Vector(-13,-13,0))

	if self.EndoType == 1 then
		self.VJ_NPC_Class = {"CLASS_FNAF_ANIMATRONIC_BLOB"}
		self:SetHealth(300)
		self:SetMaxHealth(300)
	end

	self:CreateEyeFX()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "step" then
		if self:GetState() == VJ_STATE_FREEZE then return end
		VJ_EmitSound(self,self.SoundTbl_FootStep,75,math.random(90,110))
		local servo = math.random(1,14)
		VJ_EmitSound(self,"cpthazama/fnafsb/chica/fx/sfx_chica_servo_short_" .. (servo < 10 && ("0" .. servo) or servo) .. ".wav",80,math.random(90,110))
		-- VJ_EmitSound(self,"cpthazama/fnafsb/endo/sfx_endo_wake_0" .. math.random(1,6) .. ".wav",80)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CreateEyeFX()
	for i = 1,2 do
		local att = i == 2 && "eyeR" or "eyeL"
		local eyeGlow = ents.Create("env_sprite")
		eyeGlow:SetKeyValue("model","vj_base/sprites/vj_glow1.vmt")
		eyeGlow:SetKeyValue("scale","0.05")
		eyeGlow:SetKeyValue("rendermode","9")
		eyeGlow:SetKeyValue("rendercolor","255 0 0")
		eyeGlow:SetKeyValue("spawnflags","1")
		eyeGlow:SetParent(self)
		eyeGlow:Fire("SetParentAttachment",att,0)
		eyeGlow:Spawn()
		eyeGlow:Activate()
		self:DeleteOnRemove(eyeGlow)

		local stWidth = 4
		local edWidth = 0
		local time = 0.175
		local resolution = 1 /(10 +1) *0.5
		local sprite = util.SpriteTrail(self,i +2,Color(255,0,0,240),false,stWidth,edWidth,time,resolution,"VJ_Base/sprites/vj_trial1.vmt")

		table.insert(self.EyeFX,eyeGlow)
		table.insert(self.EyeFX,sprite)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnSeen()
	for _,v in pairs(self.EyeFX) do
		if IsValid(v) then
			v:Remove()
		end
	end
	table.Empty(self.EyeFX)
	self:AddFlags(FL_NOTARGET)
	self.SoundTbl_Idle = {}
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnUnSeen()
	self:CreateEyeFX()
	self:RemoveFlags(FL_NOTARGET)
	self.SoundTbl_Idle = {
		"cpthazama/fnafsb/endo/sfx_endo_mode_patrol_01.wav",
		"cpthazama/fnafsb/endo/sfx_endo_mode_patrol_02.wav",
		"cpthazama/fnafsb/endo/sfx_endo_mode_patrol_03.wav",
		"cpthazama/fnafsb/endo/sfx_endo_mode_patrol_04.wav",
		"cpthazama/fnafsb/endo/sfx_endo_mode_patrol_05.wav",
		"cpthazama/fnafsb/endo/sfx_endo_mode_patrol_06.wav"
	}
	self.PlayDeadT = self.PlayDeadT -math.random(4,10)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if self.EndoType == 1 then return end
	local isSeen = self.InAttack && false or (self.PlayingDead or self:VJ_FNaF_CanBeSeen())
	local cont = self.VJ_TheController
	if IsValid(cont) then
		self.PlayDeadT = 0
		self.NextPlayDeadT = CurTime() +math.random(15,60)
	end
	if CurTime() > self.PlayDeadT && self.PlayingDead then
		self.PlayingDead = false
		VJ_CreateSound(self,"cpthazama/fnafsb/endo/sfx_endo_mode_hunt.wav")
	elseif CurTime() > self.NextPlayDeadT && !self.PlayingDead && math.random(1,50) == 1 then
		local t = math.random(6,30)
		self.PlayDeadT = CurTime() +t
		self.NextPlayDeadT = CurTime() +t +math.random(15,60)
		self.PlayingDead = true
	end
	if isSeen == true then
		if self:GetState() == VJ_STATE_FREEZE && !self.InAttack then
			self:SetArrivalActivity(VJ_SequenceToActivity(self,self.LastSequence))
			self:ClearSchedule()
			self:ClearGoal()
			self:StopMoving()
			self:SetPlaybackRate(0)
			self:SetSequence(self.LastSequence)
			self:SetCycle(self.LastSequenceCycle)
			return
		end
		if self.WasSeen == false then
			self:OnSeen()
			self.WasSeen = true
		end
		self.LastSequence = self:GetSequenceName(self:GetSequence())
		self.LastSequenceCycle = self:GetCycle()
		self:SetMaxYawSpeed(0)
		self:SetState(VJ_STATE_FREEZE)
	else
		if self:GetState() != VJ_STATE_FREEZE then return end
		if self.WasSeen == true then
			self:OnUnSeen()
			self.WasSeen = false
		end
		self:SetMaxYawSpeed(self.TurningSpeed)
		self:SetState()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt, isProp)
	if isProp then
		return true
	end
	self:VJ_FNAF_Attack(hitEnt,VJ_GetSequenceDuration(self,ACT_MELEE_ATTACK1),2,nil,"cpthazama/fnafsb/sfx_jumpScare_endo.wav")
	if self:GetActivity() != ACT_MELEE_ATTACK1 then
		self:VJ_ACT_PLAYACTIVITY(ACT_MELEE_ATTACK1,true,false,false)
	end
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