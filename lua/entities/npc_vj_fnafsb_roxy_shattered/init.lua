AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2022 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/fnaf_sb/roxy_shattered.mdl"}
ENT.StartHealth = 500
ENT.SightDistance = 20
ENT.LastSeenEnemyTimeUntilReset = 5

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

ENT.HasMeleeAttack = true
ENT.MeleeAttackDistance = 40
ENT.MeleeAttackDamageDistance = 110
ENT.AnimTbl_MeleeAttack = {ACT_MELEE_ATTACK1}
-- ENT.MeleeAttackAnimationDecreaseLengthAmount = 3
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
ENT.IdleSoundLevel = 85
ENT.CombatIdleSoundLevel = 85
ENT.InvestigateSoundLevel = 85
ENT.LostEnemySoundLevel = 85
ENT.AlertSoundLevel = 85

local defIdle = {
	"cpthazama/fnafsb/roxy/ROXY_00005.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00023_pref.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00027.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00052.ogg",
}
local defIdleSad = {
	"cpthazama/fnafsb/roxy/ROXY_00046.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00047.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00048.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00049.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00050a.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00051.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00050.ogg"
}

ENT.SoundTbl_FootStepAdd = {
	"cpthazama/fnafsb/roxy/fx/fly_roxy_shattered_add_01.wav",
	"cpthazama/fnafsb/roxy/fx/fly_roxy_shattered_add_02.wav",
	"cpthazama/fnafsb/roxy/fx/fly_roxy_shattered_add_03.wav",
	"cpthazama/fnafsb/roxy/fx/fly_roxy_shattered_add_04.wav",
	"cpthazama/fnafsb/roxy/fx/fly_roxy_shattered_add_05.wav",
	"cpthazama/fnafsb/roxy/fx/fly_roxy_shattered_add_06.wav"
}
ENT.SoundTbl_FootStep = {
	"cpthazama/fnafsb/roxy/fx/fly_roxy_run_01.wav",
	"cpthazama/fnafsb/roxy/fx/fly_roxy_run_02.wav",
	"cpthazama/fnafsb/roxy/fx/fly_roxy_run_03.wav",
	"cpthazama/fnafsb/roxy/fx/fly_roxy_run_04.wav",
	"cpthazama/fnafsb/roxy/fx/fly_roxy_run_05.wav",
	"cpthazama/fnafsb/roxy/fx/fly_roxy_run_06.wav",
	"cpthazama/fnafsb/roxy/fx/fly_roxy_run_07.wav",
	"cpthazama/fnafsb/roxy/fx/fly_roxy_run_08.wav",
	"cpthazama/fnafsb/roxy/fx/fly_roxy_run_09.wav",
	"cpthazama/fnafsb/roxy/fx/fly_roxy_run_10.wav",
	"cpthazama/fnafsb/roxy/fx/fly_roxy_run_11.wav",
	"cpthazama/fnafsb/roxy/fx/fly_roxy_run_12.wav"
}
ENT.SoundTbl_Idle = {}
ENT.SoundTbl_CombatIdle = {
	"cpthazama/fnafsb/roxy/ROXY_00007_01.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00007_02.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00007_03.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00008_01.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00008_02.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00008_03.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00008_04.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00008_05.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00008_06.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00008_07.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00008_08.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00008_09.ogg",
}
ENT.SoundTbl_Investigate = {
	"cpthazama/fnafsb/roxy/ROXY_00024.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00025.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00026.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00028_pref.ogg",
}
ENT.SoundTbl_LostEnemy = {
	"cpthazama/fnafsb/roxy/ROXY_00027.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00036.ogg",
}
ENT.SoundTbl_Alert = {
	"cpthazama/fnafsb/roxy/ROXY_00006.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00007_01.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00007_02.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00007_03.ogg",
}
ENT.SoundTbl_Pain = {
	"cpthazama/fnafsb/roxy/ROXY_00043_01.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00043_02.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00043_03.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00043_04.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00043_05.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00043_06.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00043_07.ogg",
}
ENT.SoundTbl_Death = {
	"cpthazama/fnafsb/roxy/ROXY_00043_02.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00043_03.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00043_06.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00043_07.ogg",
}
ENT.SoundTbl_Jump = {
	"cpthazama/fnafsb/roxy/ROXY_00040_01.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00040_02.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00040_03.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00040_04.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00040_05.ogg",
}
ENT.SoundTbl_Land = {
	"cpthazama/fnafsb/roxy/ROXY_00041_01.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00041_02.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00041_03.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00041_04.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00041_05.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00041_06.ogg",
}
ENT.SoundTbl_ShockEnd = {
	"cpthazama/fnafsb/roxy/ROXY_00042_01.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00042_02.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00042_03.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00042_04.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00042_05.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00042_06.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00042_07.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00042_08.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00042_09.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00042_10.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00042_11.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00042_12.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00042_13.ogg"
}

local nwName = "VJ_FNaF_Roxy_Shattered_Controller"
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
function ENT:OnShocked()
	VJ_CreateSound(self,self.SoundTbl_Pain,80)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnEndShock()
	VJ_CreateSound(self,self.SoundTbl_ShockEnd,80)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.InAttack = false
	self.LeapState = 0 -- 0 = Init, 1 = In-Air
	self.NextLeapT = CurTime()
	self.IdleState = 0 -- 0 = Default, 1 = Sad
	self.IdleStateT = CurTime() +5
	self.LastHeardEntity = nil
	self.LastHeardT = 0

	if !IsFNaFGamemode() then
		self:SetCollisionBounds(Vector(13,13,80),Vector(-13,-13,0))
	end

	local hookName = "VJ_FNaF_Roxanne_" .. self:EntIndex()
	hook.Add("EntityEmitSound",hookName,function(data)
		if !IsValid(self) or IsValid(self) && self:GetClass() != "npc_vj_fnafsb_roxy_shattered" then
			hook.Remove("EntityEmitSound",hookName)
			return
		end
		local ent = data.Entity
		if IsValid(ent) && ent != self then
			if (SERVER) && data.SoundLevel >= 50 then
				self:OnSoundDetected(data,ent)
			end
		end
	end)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "step" then
		VJ_EmitSound(self,self.SoundTbl_FootStep,75,math.random(90,110))
		VJ_EmitSound(self,self.SoundTbl_FootStepAdd,75,math.random(90,110))
		local servo = math.random(1,14)
		VJ_EmitSound(self,"cpthazama/fnafsb/chica/fx/sfx_chica_servo_short_" .. (servo < 10 && ("0" .. servo) or servo) .. ".wav",80,math.random(90,110))
	elseif key == "smell" then
		VJ_CreateSound(self,"cpthazama/fnafsb/roxy/ROXY_00039_0" .. math.random(1,9) .. ".ogg",75)
	elseif key == "confidence1" then
		VJ_CreateSound(self,"cpthazama/fnafsb/roxy/ROXY_00001_YourPerformance.ogg",75)
	elseif key == "confidence2" then
		VJ_CreateSound(self,"cpthazama/fnafsb/roxy/ROXY_00002_YourFansAreWatchingYou.ogg",75)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInvestigate(argent)
	if (argent:IsNPC() || argent:IsPlayer()) && self:GetPos():Distance(argent:GetPos()) <= 500 then
		self.LastHeardEntity = argent
		self:SetEnemy(self.LastHeardEntity)
		self.LastHeardT = CurTime() +5
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnSoundDetected(data,ent)
	-- print(ent,data.SoundLevel,self:GetPos():Distance(ent:GetPos()),self.InvestigateSoundDistance *data.SoundLevel,self:GetPos():Distance(ent:GetPos()) < (self.InvestigateSoundDistance *data.SoundLevel))
	if ent != self && self:GetPos():Distance(ent:GetPos()) < (self.InvestigateSoundDistance *data.SoundLevel) then
		ent:SetNW2Int("VJ_FNaF_InvestigateT",CurTime() +2)
		-- print(ent,"Added time")
		if IsValid(self:GetEnemy()) then return end
		if ((ent:IsNPC() or ent:IsPlayer() && GetConVarNumber("ai_ignoreplayers") == 0) && self:DoRelationshipCheck(ent) == true) or string.find(ent:GetClass(),"prop_") then
			if self.NextInvestigateSoundMove < CurTime() then
				-- self:VJ_FNAF_Stinger(ent)
				self:CustomOnInvestigate(ent)
				self:StopAllCommonSounds()
				if self:Visible(ent) then
					self:SetLastPosition(ent:GetPos())
					self:VJ_TASK_GOTO_LASTPOS("TASK_RUN_PATH")
				else
					self:SetLastPosition(ent:GetPos())
					self:VJ_TASK_GOTO_LASTPOS("TASK_WALK_PATH")
				end
				self:PlaySoundSystem("InvestigateSound")
				self.NextInvestigateSoundMove = CurTime() +2
			end
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert(ent)
	self:VJ_FNAF_Stinger(ent)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	if CurTime() > self.IdleStateT then
		local state = self.IdleState
		if state == 0 then
			self.SoundTbl_Idle = defIdleSad
			self.AnimTbl_IdleStand = {ACT_IDLE_STIMULATED}
			self.AnimTbl_Walk = {ACT_WALK_STIMULATED}
			self.AnimTbl_Run = {ACT_WALK_STIMULATED}
			self.IdleState = 1
			self.IdleStateT = CurTime() +math.Rand(45,60)
		end
	end
	if IsValid(self.LastHeardEntity) then
		self.SightDistance = 500
	else
		self.SightDistance = 0
	end
	if !self.VJ_IsBeingControlled then
		if CurTime() > self.LastHeardT or (IsValid(self:GetEnemy()) && self:GetEnemy() != self.LastHeardEntity) then
			self:SetEnemy(NULL)
			self.LastHeardEntity = NULL
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomAttack()
	local ent = self:GetEnemy()
	local dist = self.NearestPointToEnemyDistance
	local leapState = self.LeapState

	if self.IdleState == 1 then
		self.SoundTbl_Idle = defIdle
		self.AnimTbl_IdleStand = {ACT_IDLE}
		self.AnimTbl_Walk = {ACT_WALK}
		self.AnimTbl_Run = {ACT_RUN}
		self.IdleState = 0
	end
	self.IdleStateT = CurTime() +math.Rand(20,30)

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
			self:VJ_FNAF_Attack(ent,VJ_GetSequenceDuration(self,ACT_MELEE_ATTACK1),2,nil,"cpthazama/fnafsb/sfx_jumpScare_roxy.wav")
			self.NextLeapT = CurTime() +5
		end
		self.NextLeapT = CurTime() +(self.LeapState == 1 && 5 or 1)
	else
		if self.LeapState == 1 then
			self.LeapState = 0
			if !self.InAttack && !self.IsShocked && self:GetActivity() != ACT_MELEE_ATTACK1 then
				self:SetState()
				self:VJ_ACT_PLAYACTIVITY(ACT_LAND,true,false,false)
			end
			self.NextLeapT = CurTime() +5
		end
	end
	local cont = self.VJ_TheController
	if IsValid(cont) && cont:KeyDown(IN_ATTACK2) or !IsValid(cont) && IsValid(ent) then
		if self.LeapState == 0 && self:IsOnGround() && !self:IsBusy() && CurTime() > self.NextLeapT && dist <= 300 && dist > 160 && self:Visible(ent) then
			VJ_CreateSound(self,self.SoundTbl_Jump,78)
			self:VJ_ACT_PLAYACTIVITY(ACT_JUMP,true,false,true,0,{OnFinish=function(interrupted,anim)
				self:SetGroundEntity(NULL)
				self:SetState(VJ_STATE_ONLY_ANIMATION)
				self:SetVelocity(self:CalculateProjectile("Line", self:GetPos(), ent:EyePos() +(ent:EyePos() -self:EyePos()):GetNormalized() *100,600))
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
	self:VJ_FNAF_Attack(hitEnt,VJ_GetSequenceDuration(self,ACT_MELEE_ATTACK1),2,nil,"cpthazama/fnafsb/sfx_jumpScare_roxy.wav")
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
		VJ_EmitSound(self,"cpthazama/fnafsb/common/fly_bot_leap_prep_0" .. math.random(1,3) .. ".wav",78)
	end
	if newAct == ACT_LAND then
		VJ_EmitSound(self,self.SoundTbl_FootStep,78)
	end
end