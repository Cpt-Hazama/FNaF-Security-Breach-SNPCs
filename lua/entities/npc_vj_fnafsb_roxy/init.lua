AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2022 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/fnaf_sb/roxy.mdl"}
ENT.StartHealth = 500

ENT.FindEnemy_CanSeeThroughWalls = true

ENT.VJ_NPC_Class = {"CLASS_FNAF_ANIMATRONIC","CLASS_FNAF_BURNTRAP"}

ENT.VJC_Data = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(0, 30, -40), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "Head_jnt", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(8, 0, 8), -- The offset for the controller when the camera is in first person
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
ENT.SoundTbl_Idle = {
	"cpthazama/fnafsb/roxy/ROXY_00009.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00010_pref.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00011.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00012.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00013.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00022.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00031_pref.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00030.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00032_pref.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00033.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00044_pref.ogg",
}
ENT.SoundTbl_CombatIdle = {
	"cpthazama/fnafsb/roxy/ROXY_00016_pref.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00017_pref.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00018_pref.ogg",
}
ENT.SoundTbl_Investigate = {
	"cpthazama/fnafsb/roxy/ROXY_00021.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00038_pref.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00055.ogg",
}
ENT.SoundTbl_LostEnemy = {
	"cpthazama/fnafsb/roxy/ROXY_00014.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00034.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00035_pref.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00037_pref.ogg",
}
ENT.SoundTbl_Alert = {
	"cpthazama/fnafsb/roxy/ROXY_00029.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00036.ogg"
}
ENT.SoundTbl_CallForHelp = {
	"cpthazama/fnafsb/roxy/ROXY_00019_pref.ogg",
	"cpthazama/fnafsb/roxy/ROXY_00020.ogg",
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

local nwName = "VJ_FNaF_Roxy_Controller"
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

	self:SetCollisionBounds(Vector(13,13,80),Vector(-13,-13,0))
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "step" then
		VJ_EmitSound(self,self.SoundTbl_FootStep,75,math.random(90,110))
		local servo = math.random(1,14)
		VJ_EmitSound(self,"cpthazama/fnafsb/chica/fx/sfx_chica_servo_short_" .. (servo < 10 && ("0" .. servo) or servo) .. ".wav",80,math.random(90,110))
	elseif key == "smell" then
		VJ_CreateSound(self,"cpthazama/fnafsb/roxy/ROXY_00039_0" .. math.random(1,9) .. ".ogg",75)
	elseif key == "pep1" then
		VJ_CreateSound(self,"cpthazama/fnafsb/roxy/ROXY_00001_YourPerformance.ogg",75)
	elseif key == "pep2" then
		VJ_CreateSound(self,"cpthazama/fnafsb/roxy/ROXY_00002_YourFansAreWatchingYou.ogg",75)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnPlayCreateSound(SoundData,SoundFile)
	if string.find(string.lower(SoundFile),"jumpscare") then return end
	if string.find(SoundFile,"fx") then return end
	if SoundFile == "cpthazama/fnafsb/roxy/ROXY_00001_YourPerformance.ogg" or SoundFile == "cpthazama/fnafsb/roxy/ROXY_00002_YourFansAreWatchingYou.ogg" then return end
	self.NextMouthT = CurTime() +VJ_SoundDuration(SoundFile)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	self:VJ_FNaF_MouthCode()
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
			self:VJ_FNAF_Attack(ent,VJ_GetSequenceDuration(self,ACT_MELEE_ATTACK1),2,nil,"cpthazama/fnafsb/sfx_jumpScare_roxy.wav")
			self.NextLeapT = CurTime() +5
		end
		self.NextLeapT = CurTime() +(self.LeapState == 1 && 5 or 1)
	else
		if self.LeapState == 1 then
			self.LeapState = 0
			if self:GetActivity() != ACT_MELEE_ATTACK1 then
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
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_BeforeCorpseSpawned(dmginfo,hitgroup)
	if GetConVar("vj_fnaf_witherspawn"):GetBool() then
		self.DeathCorpseModel = {"models/cpthazama/fnaf_sb/roxy_shattered.mdl"}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDeath_AfterCorpseSpawned(dmginfo,hitgroup,corpse)
	corpse.VJ_FNaF_AnimatronicRespawn = true

	if GetConVar("vj_fnaf_witherspawn"):GetBool() then
		undo.ReplaceEntity(self,corpse)
		corpse.VJ_FNaF_UnSeenT = CurTime() +math.random(GetConVar("vj_fnaf_witherspawnrand1"):GetInt(),GetConVar("vj_fnaf_witherspawnrand2"):GetInt())
		corpse.VJ_FNaF_SpawnClass = self:GetClass() .. "_shattered"
		local hookName = "VJ_FNaF_Wither_" .. corpse:EntIndex()
		hook.Add("Think",hookName,function()
			if !IsValid(corpse) then
				hook.Remove("Think",hookName)
				return
			end
			for _,v in pairs(ents.GetAll()) do
				if (GetConVar("ai_ignoreplayers"):GetBool() == false && v:IsPlayer() && v:Alive() && !VJ_HasValue(v.VJ_NPC_Class or {},"CLASS_FNAF_ANIMATRONIC")) or (v:IsNPC() && !VJ_HasValue(v.VJ_NPC_Class or {},"CLASS_FNAF_ANIMATRONIC")) then
					if !corpse:Visible(v) then continue end
					corpse.VJ_FNaF_UnSeenT = CurTime() +math.random(GetConVar("vj_fnaf_witherspawnrand1"):GetInt(),GetConVar("vj_fnaf_witherspawnrand2"):GetInt())
					break
				end
			end
			if CurTime() > corpse.VJ_FNaF_UnSeenT then
				local ent = ents.Create(corpse.VJ_FNaF_SpawnClass)
				if IsValid(ent) then
					local navArea = VJ_FNaF_FindHiddenNavArea(true,true)
					-- print(navArea && "Spawned in Nav Area" or "Spawned")
					ent:SetPos(navArea != false && navArea or corpse:GetPos() +Vector(0,0,5))
					ent:SetAngles(Angle(0,navArea != false && math.random(0,360) or corpse:GetAngles().y,0))
					ent:Spawn()
					if navArea == false then
						ent:VJ_ACT_PLAYACTIVITY(ACT_DISARM,true,false,false)
					end
					undo.ReplaceEntity(corpse,ent)
					corpse:Remove()
				else
					print("Failed to create Withered Animatronic! (Invalid Entity Type)")
				end
				hook.Remove("Think",hookName)
			end
		end)
	end
end