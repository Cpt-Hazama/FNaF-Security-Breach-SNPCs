AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2022 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/fnaf_sb/custom/bonnie.mdl"}
ENT.StartHealth = 500

ENT.VJ_NPC_Class = {"CLASS_FNAF_ANIMATRONIC","CLASS_FNAF_BURNTRAP"}

ENT.VJC_Data = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(0, 30, -40), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "Head_jnt", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(8, 0, 8), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = false, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	FirstP_CameraBoneAng = 3, -- Should the camera's angle be affected by the bone's angle?
	FirstP_CameraBoneAng_Offset = 0, -- How much should the camera's angle be rotated by? (Useful for weird bone angles, this is the roll angle)
}

ENT.Bleeds = false

ENT.HullType = HULL_HUMAN

ENT.MaxJumpLegalDistance = VJ_Set(500,800)

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
	"cpthazama/fnafsb/monty/fx/fly_monty_run_01.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_run_02.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_run_03.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_run_04.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_run_05.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_run_06.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_run_07.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_run_08.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_run_09.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_run_10.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_run_11.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_run_12.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_run_13.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_run_14.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_run_15.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_run_16.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_run_17.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_run_18.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_run_19.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_run_20.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_run_21.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_run_22.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_run_23.wav"
}
ENT.SoundTbl_JumpFx = {
	"cpthazama/fnafsb/monty/fx/fly_monty_leap_01.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_leap_02.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_leap_03.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_leap_04.wav"
}
ENT.SoundTbl_LandFx = {
	"cpthazama/fnafsb/monty/fx/fly_monty_land_01.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_land_02.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_land_03.wav"
}

local nwName = "VJ_FNaF_Bonnie_Controller"
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
function ENT:CustomOnAlert(ent)
	self:VJ_FNAF_Stinger(ent)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.InAttack = false
	self.LeapState = 0 -- 0 = Init, 1 = In-Air
	self.NextLeapT = CurTime()

	if !IsFNaFGamemode() then
		self:SetCollisionBounds(Vector(13,13,80),Vector(-13,-13,0))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "step" then
		VJ_EmitSound(self,self.SoundTbl_FootStep,75,math.random(90,110))
		if self.Shattered then
			VJ_EmitSound(self,self.SoundTbl_Add,80)
			return
		end
		local servo = math.random(1,14)
		VJ_EmitSound(self,"cpthazama/fnafsb/chica/fx/sfx_chica_servo_short_" .. (servo < 10 && ("0" .. servo) or servo) .. ".wav",80,math.random(90,110))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomAttack()
	local ent = self:GetEnemy()
	local dist = self.NearestPointToEnemyDistance
	local leapState = self.LeapState
	if !self:IsOnGround() then
		if self:GetActivity() == ACT_GLIDE && leapState == 0 then
			self.LeapState = 1
		elseif leapState == 1 && self:GetActivity() != ACT_GLIDE then
			self:VJ_ACT_PLAYACTIVITY(ACT_GLIDE,true,false,false)
		end
		if dist <= self.MeleeAttackDistance && leapState == 1 then
			self:StopAttacks(true)
			self.NextChaseTime = 0
			self.NextIdleTime = 0
			self.LeapState = 0
			self:SetState()
			self:SetVelocity(Vector(0,0,0))
			self:VJ_ACT_PLAYACTIVITY(ACT_MELEE_ATTACK1,true,false,true)
			self:VJ_FNAF_Attack(ent,VJ_GetSequenceDuration(self,ACT_MELEE_ATTACK1),2,nil,"cpthazama/fnafsb/sfx_jumpScare_monty.wav")
			self.NextLeapT = CurTime() +5
		end
		self.NextLeapT = CurTime() +(self.LeapState == 1 && 5 or 1)
	else
		if self.LeapState == 1 then
			self.LeapState = 0
			if !self:IsBusy() && self:GetActivity() != ACT_MELEE_ATTACK1 then
				self:SetState()
				self:VJ_ACT_PLAYACTIVITY(ACT_LAND,true,false,false)
			end
			self.NextLeapT = CurTime() +5
		end
	end
	local cont = self.VJ_TheController
	if IsValid(cont) && cont:KeyDown(IN_ATTACK2) or !IsValid(cont) && IsValid(ent) then
		if self.LeapState == 0 && self:IsOnGround() && !self:IsBusy() && CurTime() > self.NextLeapT && dist <= 1000 && dist > 600 && self:Visible(ent) then
			self:VJ_ACT_PLAYACTIVITY(ACT_JUMP,true,false,true,0,{OnFinish=function(interrupted,anim)
				self:SetGroundEntity(NULL)
				self:SetState(VJ_STATE_ONLY_ANIMATION)
				self:SetVelocity(self:CalculateProjectile("Curve", self:GetPos(), ent:GetPos() +(ent:GetPos() -self:GetPos()):GetNormalized() *100,900))
				self:VJ_ACT_PLAYACTIVITY(ACT_GLIDE,true,false,false)
				self.LeapState = 1
			end})
			self.NextLeapT = CurTime() +1
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt, isProp)
	if isProp then
		return true
	end
	-- self:VJ_FNAF_Attack(hitEnt,VJ_GetSequenceDuration(self,ACT_MELEE_ATTACK1),2,nil,"cpthazama/fnafsb/bonnie/Bonnie-Jumpscare.ogg")
	self:VJ_FNAF_Attack(hitEnt,VJ_GetSequenceDuration(self,ACT_MELEE_ATTACK1),2,nil,"cpthazama/fnafsb/sfx_jumpscare_pas_freddy.wav")
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
function ENT:CustomOnChangeActivity(newAct)
	if newAct == ACT_JUMP then
		VJ_CreateSound(self,self.SoundTbl_JumpFx,75)
		VJ_EmitSound(self,"cpthazama/fnafsb/common/fly_bot_leap_prep_0" .. math.random(1,3) .. ".wav",78)
	end
	if newAct == ACT_LAND then
		VJ_CreateSound(self,self.SoundTbl_LandFx,75)
	end
end