AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2022 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/fnaf_sb/chica.mdl"}
ENT.StartHealth = 500

ENT.VJ_NPC_Class = {"CLASS_FNAF_ANIMATRONIC","CLASS_FNAF_BURNTRAP"}

ENT.VJC_Data = {
	CameraMode = 1, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(0, 30, -40), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "Head_jnt", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(12, 0, 5), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = false, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	FirstP_CameraBoneAng = 3, -- Should the camera's angle be affected by the bone's angle?
	FirstP_CameraBoneAng_Offset = -12, -- How much should the camera's angle be rotated by? (Useful for weird bone angles, this is the roll angle)
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
	"cpthazama/fnafsb/chica/fx/fly_chica_run_01.wav",
	"cpthazama/fnafsb/chica/fx/fly_chica_run_02.wav",
	"cpthazama/fnafsb/chica/fx/fly_chica_run_03.wav",
	"cpthazama/fnafsb/chica/fx/fly_chica_run_04.wav",
	"cpthazama/fnafsb/chica/fx/fly_chica_run_05.wav",
	"cpthazama/fnafsb/chica/fx/fly_chica_run_06.wav",
	"cpthazama/fnafsb/chica/fx/fly_chica_run_07.wav",
	"cpthazama/fnafsb/chica/fx/fly_chica_run_08.wav",
	"cpthazama/fnafsb/chica/fx/fly_chica_run_09.wav",
	"cpthazama/fnafsb/chica/fx/fly_chica_run_10.wav",
	"cpthazama/fnafsb/chica/fx/fly_chica_run_11.wav",
	"cpthazama/fnafsb/chica/fx/fly_chica_run_12.wav"
}
ENT.SoundTbl_Idle = {
	"cpthazama/fnafsb/chica/gregooryyyy.wav",
	"cpthazama/fnafsb/chica/ill_take_you_to_your_parents.wav",
	"cpthazama/fnafsb/chica/let_me_take_you_to_your_parents.wav",
	"cpthazama/fnafsb/chica/promo.wav",
	"cpthazama/fnafsb/chica/who_wants_canddyy.wav",
	"cpthazama/fnafsb/chica/where_are_you.wav",
	"cpthazama/fnafsb/chica/your_family_is_looking_for_you.wav",
	"cpthazama/fnafsb/chica/your_parents_want_you_to_follow_me.wav",
	"cpthazama/fnafsb/chica/youre_safe_with_me.wav",
}
ENT.SoundTbl_CombatIdle = {
	"cpthazama/fnafsb/chica/i_am_just_trying_to_help.wav",
	"cpthazama/fnafsb/chica/laugh1.wav",
	"cpthazama/fnafsb/chica/laugh2.wav",
	"cpthazama/fnafsb/chica/no_more_games.wav",
}
ENT.SoundTbl_Investigate = {
	"cpthazama/fnafsb/chica/friendly_staff_can_help.wav",
	"cpthazama/fnafsb/chica/there_you_arrreee.wav",
}
ENT.SoundTbl_LostEnemy = {
	"cpthazama/fnafsb/chica/come_out_come_out_whever.wav",
	"cpthazama/fnafsb/chica/where_are_you.wav",
}
ENT.SoundTbl_Alert = {
	"cpthazama/fnafsb/chica/NO_MORE_GAMES!.wav",
	"cpthazama/fnafsb/chica/are_you_lost.wav",
	"cpthazama/fnafsb/chica/employees_only.wav",
	"cpthazama/fnafsb/chica/gregory.wav",
	"cpthazama/fnafsb/chica/i_found_you.wav",
	"cpthazama/fnafsb/chica/staff_only.wav",
	"cpthazama/fnafsb/chica/this_area_is_off_limits.wav",
}
ENT.SoundTbl_CallForHelp = {
	"cpthazama/fnafsb/chica/lost_boy_over_here.wav",
}
ENT.SoundTbl_BecomeEnemyToPlayer = {
	"cpthazama/fnafsb/chica/stop.wav",
}
ENT.SoundTbl_Pain = {
	"cpthazama/fnafsb/chica/bawk1.wav",
	"cpthazama/fnafsb/chica/bawk2.wav",
}
ENT.SoundTbl_Death = {
	"cpthazama/fnafsb/chica/death.wav"
}
ENT.SoundTbl_Shock = {
	"cpthazama/fnafsb/chica/CHICA_00001_01.ogg",
	"cpthazama/fnafsb/chica/CHICA_00001_02.ogg",
	"cpthazama/fnafsb/chica/CHICA_00001_03.ogg",
	"cpthazama/fnafsb/chica/CHICA_00001_04.ogg",
}
ENT.SoundTbl_SmellPizza = {
	"cpthazama/fnafsb/chica/CHICA_00025_01.ogg",
	"cpthazama/fnafsb/chica/CHICA_00025_02.ogg",
	"cpthazama/fnafsb/chica/CHICA_00025_03.ogg"
}
ENT.SoundTbl_SeePizza = {
	"cpthazama/fnafsb/chica/CHICA_PIZZA_01.ogg",
	"cpthazama/fnafsb/chica/CHICA_PIZZA_02.ogg",
	"cpthazama/fnafsb/chica/CHICA_PIZZA_03.ogg"
}

local nwName = "VJ_FNaF_Chica_Controller"
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
function ENT:CustomOnAlert(ent)
	self:VJ_FNAF_Stinger(ent)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:GetSightDirection()
	return self:GetAttachment(self:LookupAttachment("eyes")).Ang:Forward()
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:EatPizza(ent)
	self.Pizza = ent
	self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
	self.EatLoop:Play()
	self:VJ_ACT_PLAYACTIVITY("dig_idle",true,false,false,0,{OnFinish=function(interrupted,anim)
		if interrupted then return end
		self:SetState()
		self.EatLoop:Stop()
		if IsValid(ent) then
			ent.BeenEaten = true
			ent:EmitSound("physics/cardboard/cardboard_box_break" .. math.random(1,3) .. ".wav")
			ent:Remove()
		end
	end})
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnShocked()
	VJ_CreateSound(self,self.SoundTbl_Shock)
	local pizza = self.Pizza
	if self:GetActivity() == ACT_IDLE_STIMULATED then
		self:StopAttacks(true)
		self.EatLoop:Stop()
	end
	self.Pizza = NULL
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.InAttack = false

	self.EatLoop = CreateSound(self,"cpthazama/fnafsb/chica/eat_loop.wav")
	self.NextPizzaSmellT = CurTime()
	self.NextPizzaSeeT = CurTime()
	self.NextScreamT = CurTime()

	if !IsFNaFGamemode() then
		self:SetCollisionBounds(Vector(13,13,80),Vector(-13,-13,0))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "step" then
		VJ_EmitSound(self,self.SoundTbl_FootStep,75,math.random(90,110))
		local servo = math.random(1,14)
		VJ_EmitSound(self,"cpthazama/fnafsb/chica/fx/sfx_chica_servo_short_" .. (servo < 10 && ("0" .. servo) or servo) .. ".wav",80,math.random(90,110))
	elseif key == "song" then
		if self.Song then
			self.Song:Stop()
		end
		self.Song = VJ_CreateSound(self,"cpthazama/fnafsb/common/sfx_chicajam_guitarsolo_loop_b.wav")
		self.Song:SetSoundLevel(95)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
local string_find = string.find
local string_lower = string.lower
--
function ENT:OnPlayCreateSound(SoundData,SoundFile)
	if string_find(string_lower(SoundFile),"jumpscare") then return end
	if string_find(SoundFile,"fx") then return end
	if SoundFile == "cpthazama/fnafsb/common/sfx_chicajam_guitarsolo_loop_b.wav" then return end
	self.NextMouthT = CurTime() +VJ_SoundDuration(SoundFile)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	self:VJ_FNaF_MouthCode()
	local pizza = self.Pizza
	if (!IsValid(pizza) && self:GetActivity() == ACT_IDLE_STIMULATED or IsValid(pizza) && IsValid(self:GetEnemy())) then
		self:StopAttacks(true)
		self.NextChaseTime = 0
		self.NextIdleTime = 0
		self.EatLoop:Stop()
		self:SetState()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	local ent = self:GetEnemy()
	local anim = self:GetActivity()
	local dist = self.NearestPointToEnemyDistance
	local cont = self.VJ_TheController

	if (IsValid(cont) && cont:KeyDown(IN_ATTACK2) or !IsValid(cont) && IsValid(ent) && dist > 180 && dist <= 700 && self:Visible(ent) && math.random(1,20) == 1) && !self:IsBusy() && CurTime() > self.NextScreamT then
		self:VJ_FNAF_ChicaScreamAttack(nil,true,true)
		self.NextScreamT = CurTime() +math.Rand(12,20)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	if self.Song then
		self.Song:Stop()
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt, isProp)
	if isProp then
		return true
	end
	self:VJ_FNAF_Attack(hitEnt,VJ_GetSequenceDuration(self,ACT_MELEE_ATTACK1) -1,2,nil,"cpthazama/fnafsb/sfx_jumpScare_scream.wav")
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
function ENT:CustomOnDeath_BeforeCorpseSpawned(dmginfo,hitgroup)
	if GetConVar("vj_fnaf_witherspawn"):GetBool() then
		self.DeathCorpseModel = {"models/cpthazama/fnaf_sb/chica_shattered.mdl"}
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
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnChangeActivity(newAct)
	if newAct != ACT_IDLE_RELAXED then
		if self.Song then
			self.Song:Stop()
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	self.EatLoop:Stop()
end