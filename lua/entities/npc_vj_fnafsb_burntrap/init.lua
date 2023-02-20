AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2022 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/fnaf_sb/burntrap.mdl"}
ENT.StartHealth = 750

ENT.VJ_NPC_Class = {/*"CLASS_FNAF_ANIMATRONIC",*/"CLASS_FNAF_BURNTRAP"}

ENT.VJC_Data = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(0, 30, -40), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "Head_jnt", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(8, 0, 0), -- The offset for the controller when the camera is in first person
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
}
ENT.SoundTbl_FootStepAdd = {
	"cpthazama/fnafsb/roxy/fx/fly_roxy_shattered_add_01.wav",
	"cpthazama/fnafsb/roxy/fx/fly_roxy_shattered_add_02.wav",
	"cpthazama/fnafsb/roxy/fx/fly_roxy_shattered_add_03.wav",
	"cpthazama/fnafsb/roxy/fx/fly_roxy_shattered_add_04.wav",
	"cpthazama/fnafsb/roxy/fx/fly_roxy_shattered_add_05.wav",
	"cpthazama/fnafsb/roxy/fx/fly_roxy_shattered_add_06.wav"
}
ENT.SoundTbl_Idle = {
	"cpthazama/fnafsb/burntrap/ICanTasteFear.ogg",
	"cpthazama/fnafsb/burntrap/I_mHereToClaim.ogg",
	"cpthazama/fnafsb/burntrap/ItIsNotYour (3).ogg",
	"cpthazama/fnafsb/burntrap/YouWillNotBe.ogg",
}
ENT.SoundTbl_CombatIdle = {
	"cpthazama/fnafsb/burntrap/IAmHereToClaim.ogg",
	"cpthazama/fnafsb/burntrap/IWillMakeYou.ogg",
	"cpthazama/fnafsb/burntrap/ItIsTime.ogg",
	"cpthazama/fnafsb/burntrap/YouWillNotBe (3).ogg",
}
ENT.SoundTbl_Investigate = {
	"cpthazama/fnafsb/burntrap/LetsSeeHowMany.ogg",
	"cpthazama/fnafsb/burntrap/YouWillNotBe (2).ogg",
	"cpthazama/fnafsb/burntrap/YourFearWill.ogg",
	"cpthazama/fnafsb/burntrap/YourTime.ogg",
}
ENT.SoundTbl_LostEnemy = {
	"cpthazama/fnafsb/burntrap/HideIfYouWant.ogg",
	"cpthazama/fnafsb/burntrap/Sigh.ogg",
	"cpthazama/fnafsb/burntrap/Sigh (2).ogg",
	"cpthazama/fnafsb/burntrap/Sigh (3).ogg",
	"cpthazama/fnafsb/burntrap/YourFearWill (2).ogg",
}
ENT.SoundTbl_Alert = {
	"cpthazama/fnafsb/burntrap/GotYou.ogg",
	"cpthazama/fnafsb/burntrap/I_mBack.ogg",
	"cpthazama/fnafsb/burntrap/Let_sSeeHowMany.ogg",
	"cpthazama/fnafsb/burntrap/Spring-Revised-AndNowYouAre-2.ogg",
	"cpthazama/fnafsb/burntrap/Spring-Revised-AndNowYouAre-3.ogg",
	"cpthazama/fnafsb/burntrap/Spring-Revised-AndNowYouAre.ogg",
	"cpthazama/fnafsb/burntrap/SufferNow (2).ogg",
	"cpthazama/fnafsb/burntrap/SufferNow.ogg",
}
ENT.SoundTbl_CallForHelp = {

}
ENT.SoundTbl_BecomeEnemyToPlayer = {

}
ENT.SoundTbl_Pain = {

}
ENT.SoundTbl_Death = {
	-- "cpthazama/fnafsb/burntrap/YouWillNotBe (2).ogg"
}
ENT.SoundTbl_Attack = {
	"cpthazama/fnafsb/burntrap/GotYou.ogg",
	"cpthazama/fnafsb/burntrap/ItIsTime (2).ogg",
	"cpthazama/fnafsb/burntrap/Spring-Revised-AndNowYouAre.ogg",
	"cpthazama/fnafsb/burntrap/YourTime.ogg"
}

util.AddNetworkString("VJ_FNAF_BurnTrap_Damage")

local nwName = "VJ_FNaF_Burntrap_Controller"
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
	self.NextDamageT = 0

	if !IsFNaFGamemode() then
		self:SetCollisionBounds(Vector(13,13,82),Vector(-13,-13,0))
	end
	
	for i = 1,2 do
		local att = i == 2 && "eyeR" or "eyeL"
		local eyeGlow = ents.Create("env_sprite")
		eyeGlow:SetKeyValue("model","sprites/cpthazama/fnafsb/eye_flare2.vmt")
		eyeGlow:SetKeyValue("scale","0.02")
		eyeGlow:SetKeyValue("rendermode","5")
		eyeGlow:SetKeyValue("rendercolor","183 0 255")
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
		util.SpriteTrail(self,i,Color(183,0,255,240),false,stWidth,edWidth,time,resolution,"VJ_Base/sprites/vj_trial1.vmt")
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "step" then
		VJ_EmitSound(self,self.SoundTbl_FootStep,75,math.random(90,110))
		VJ_EmitSound(self,self.SoundTbl_FootStepAdd,75,math.random(90,110))
		VJ_EmitSound(self,"physics/flesh/flesh_squishy_impact_hard1.wav",60,math.random(90,120))
		local servo = math.random(1,14)
		VJ_EmitSound(self,"cpthazama/fnafsb/chica/fx/sfx_chica_servo_short_" .. (servo < 10 && ("0" .. servo) or servo) .. ".wav",80,math.random(90,110))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:DoRangeDamage()
	net.Start("VJ_FNAF_BurnTrap_Damage")
		net.WriteEntity(self)
		net.WriteEntity(self:GetEnemy())
	net.Broadcast()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_BeforeDamage(dmginfo, hitgroup)
	if dmginfo:GetDamageType() == DMG_BURN then
		dmginfo:ScaleDamage(2.35)
		if !self:IsOnFire() then
			self:Ignite(15)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPriorToKilled(dmginfo, hitgroup)
	local type = dmginfo:GetDamageType()
	local attacker = dmginfo:GetAttacker()
	if dmginfo:GetDamageType() == DMG_BURN or IsValid(attacker) && attacker:GetClass() == "entityflame" && self:IsOnFire() then
		self.HasDeathAnimation = true
		self.AnimTbl_Death = {ACT_DIESIMPLE}
		if !self:IsOnFire() then
			self:Ignite(15)
		end
		timer.Simple(10.5,function()
			if IsValid(self) then
				VJ_CreateSound(self,"cpthazama/fnafsb/burntrap/YouWillNotBe (2).ogg",75)
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local string_find = string.find
local string_lower = string.lower
--
function ENT:OnPlayCreateSound(SoundData,SoundFile)
	if string_find(string_lower(SoundFile),"jumpscare") then return end
	if string_find(SoundFile,"fx") then return end
	self.NextMouthT = CurTime() +VJ_SoundDuration(SoundFile)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	self:VJ_FNaF_MouthCode()
	if !IsValid(self:GetEnemy()) && self:GetActivity() == ACT_IDLE_ANGRY then
		self:VJ_ACT_PLAYACTIVITY(ACT_DISARM,true,false,true,0,{OnFinish=function(interrupted,anim)
			self:SetState()
			self:SetIdleAnimation({ACT_IDLE},true)
		end})
	elseif self:GetActivity() == ACT_IDLE_ANGRY && IsValid(self:GetEnemy()) then
		self:FaceCertainEntity(self:GetEnemy())
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	local ent = self:GetEnemy()
	local anim = self:GetActivity()
	local dist = self.NearestPointToEnemyDistance
	local cont = self.VJ_TheController
	if IsValid(cont) then
		for _,v in pairs(ents.FindInSphere(ent:GetPos(),10)) do
			if v != self && v != ent && (v:IsNPC() or v:IsPlayer()) then
				ent = v
				break
			end
		end
	end
	if (IsValid(cont) && cont:KeyDown(IN_ATTACK2) or !IsValid(cont) && IsValid(ent)) && dist > 300 && dist <= 1250 && self:Visible(ent) && anim != ACT_DISARM then
		if anim == ACT_IDLE_ANGRY && CurTime() > self.NextDamageT then
			if ent:IsPlayer() then
				ent:TakeDamage(5,self,self)
				self:DoRangeDamage()
			elseif ent.VJ_FNaF_IsFreddy then
				ent:Hack(self)
			else
				ent:TakeDamage(3,self,self)
			end
			self.NextDamageT = CurTime() +0.5
		elseif anim != ACT_IDLE_ANGRY && anim != ACT_ARM then
			self:VJ_ACT_PLAYACTIVITY(ACT_ARM,true,false,true,0,{OnFinish=function(interrupted,anim)
				self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
				self:SetIdleAnimation({ACT_IDLE_ANGRY},true)
				self:VJ_ACT_PLAYACTIVITY(ACT_IDLE_ANGRY,true,false,false)
			end})
			self:StopAllCommonSounds()
			VJ_CreateSound(self,self.SoundTbl_Attack,80)
			-- VJ_CreateSound(self,"cpthazama/fnafsb/burntrap/fx/sfx_burntrap_hackFreddy_complete_leadIn_0" .. math.random(1,3) .. ".wav",80)
			VJ_EmitSound(self,"cpthazama/fnafsb/burntrap/fx/sfx_burntrap_hackFreddy_activate_0" .. math.random(1,3) .. ".wav",80)
		end
	else
		if anim == ACT_IDLE_ANGRY then
			self:VJ_ACT_PLAYACTIVITY(ACT_DISARM,true,false,true,0,{OnFinish=function(interrupted,anim)
				self:SetState()
				self:SetIdleAnimation({ACT_IDLE},true)
			end})
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt, isProp)
	if isProp then
		return true
	end
	self:VJ_FNAF_Attack(hitEnt,VJ_GetSequenceDuration(self,ACT_MELEE_ATTACK1),2,nil,"cpthazama/fnafsb/sfx_jumpScare_BurnTrap.mp3")
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