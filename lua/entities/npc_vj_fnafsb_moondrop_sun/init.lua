AddCSLuaFile("shared.lua")
include("shared.lua")
/*-----------------------------------------------
	*** Copyright (c) 2012-2022 by Cpt. Hazama,All rights reserved. ***
	No parts of this code or any of its contents may be reproduced,copied,modified or adapted,
	without the prior written consent of the author,unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/fnaf_sb/moondrop.mdl"}
ENT.StartHealth = 400

ENT.VJ_NPC_Class = {"CLASS_FNAF_ANIMATRONIC","CLASS_FNAF_BURNTRAP"}

ENT.VJC_Data = {
	CameraMode = 1,-- Sets the default camera mode | 1 = Third Person,2 = First Person
	ThirdP_Offset = Vector(0,30,-40),-- The offset for the controller when the camera is in third person
	FirstP_Bone = "Head2_jnt",-- If left empty,the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(8,0,0),-- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = false,-- Should the bone shrink? Useful if the bone is obscuring the player"s view
	FirstP_UseBoneAng = true, -- Should the camera's angle be affected by the bone's angle?
	FirstP_BoneAngAdjust = 0, -- How much should the camera's angle be rotated by? (Useful for weird bone angles, this is the roll angle)
}

ENT.Aerial_FlyingSpeed_Calm = 200
ENT.Aerial_FlyingSpeed_Alerted = 200
ENT.Aerial_AnimTbl_Calm = {ACT_FLY}
ENT.Aerial_AnimTbl_Alerted = {ACT_FLY}

ENT.Bleeds = false

ENT.BecomeEnemyToPlayer = true
ENT.OnPlayerSightDistance = 1000
ENT.OnPlayerSightOnlyOnce = false

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

ENT.StartMode = 0 -- 0 = Sun, 1 = Moon

local nwName = "VJ_FNaF_Moon_Controller"
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
	self.IsCrawling = false
	self.TargetPlayer = NULL
	self.NextAnnoyingT = 0
	self.NextChangeCrawlT = 0
	self.NextChangeMovementT = 0

	-- local ply = Entity(1)
    -- net.Start(nwName)
	-- 	net.WriteBool(false)
	-- 	net.WriteEntity(self)
	-- 	net.WriteString(self:GetClass())
	-- 	net.WriteEntity(ply)
    -- net.Send(ply)

	self:SetCollisionBounds(Vector(13,13,76),Vector(-13,-13,0))
	
	self:SetMode(self.StartMode)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:JumpscareOffset(ent)
	return self:GetPos() +self:GetForward() *60
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnTakeDamage_AfterDamage(dmginfo, hitgroup)
	if self.Mode == 1 then return end
	local attacker = dmginfo:GetAttacker()
	if attacker:IsNPC() then
		if math.random(1,3) == 1 then
			self.RunAwayOnUnknownDamage = false
			self.TargetPlayer = NULL
			self:SetMode(1)
			-- self:SetEnemy(attacker)
			self.RunAwayOnUnknownDamage = true
			timer.Simple(0.1,function()
				if IsValid(self) then
					self:DoChaseAnimation()
					self:SetArrivalActivity(ACT_IDLE)
				end
			end)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomWhenBecomingEnemyTowardsPlayer(dmginfo, hitgroup)
	if self.Mode == 0 then
		self.RunAwayOnUnknownDamage = false
		self.TargetPlayer = NULL
		self:SetMode(1)
		-- self:SetEnemy(dmginfo:GetAttacker())
		self.RunAwayOnUnknownDamage = true
		timer.Simple(0.1,function()
			if IsValid(self) then
				self:DoChaseAnimation()
				self:SetArrivalActivity(ACT_IDLE)
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetMode(m)
	self.Mode = m
	self:SetNW2Int("SunMode",m)
	if m == 0 then
		self:SetSkin(1)
		self:SetBodygroup(2,1)
		self:SetBodygroup(7,1)

		self.AnimTbl_IdleStand = {ACT_IDLE_STIMULATED}
		self.AnimTbl_Walk = {ACT_WALK_AGITATED}
		self.AnimTbl_Run = {ACT_RUN_AGITATED}

		self.HasOnPlayerSight = true
		self.PlayerFriendly = true
		self.MoveOutOfFriendlyPlayersWay = false
		self.FriendsWithAllPlayerAllies = true
		self.Behavior = VJ_BEHAVIOR_PASSIVE
		self.DisableFindEnemy = true
		self.DisableMakingSelfEnemyToNPCs = true

		self.SoundTbl_FootStep = {
			"cpthazama/fnafsb/moondrop/sun/fx/fly_sunMan_walk_01.wav",
			"cpthazama/fnafsb/moondrop/sun/fx/fly_sunMan_walk_02.wav",
			"cpthazama/fnafsb/moondrop/sun/fx/fly_sunMan_walk_03.wav",
			"cpthazama/fnafsb/moondrop/sun/fx/fly_sunMan_walk_04.wav",
			"cpthazama/fnafsb/moondrop/sun/fx/fly_sunMan_walk_05.wav",
			"cpthazama/fnafsb/moondrop/sun/fx/fly_sunMan_walk_06.wav"
		}
		self.SoundTbl_Idle = {}
		self.SoundTbl_CombatIdle = {
			"cpthazama/fnafsb/sun/SUN_00002_AreYouHavingFun.ogg",
		}
		self.SoundTbl_Investigate = {
			"cpthazama/fnafsb/sun/SUN_00006a.ogg",
		}
		-- self.SoundTbl_OnPlayerSight = {
			-- "cpthazama/fnafsb/sun/SUN_Hi.wav",
		-- }
		self.SoundTbl_LostEnemy = {
			"cpthazama/fnafsb/sun/SUN_00004_NewFriendThisArea.ogg",
			"cpthazama/fnafsb/sun/SUN_00004a.ogg",
		}
		self.SoundTbl_CallForHelp = {
			"cpthazama/fnafsb/sun/SUN_00007_pref.ogg",
		}
		self.SoundTbl_Alert = {}
	elseif m == 1 then
		self:SetSkin(0)
		self:SetBodygroup(2,0)
		self:SetBodygroup(7,0)

		self.AnimTbl_IdleStand = {ACT_IDLE}
		self.AnimTbl_Walk = {ACT_WALK}
		self.AnimTbl_Run = {ACT_RUN}

		self.HasOnPlayerSight = false
		self.PlayerFriendly = false
		self.MoveOutOfFriendlyPlayersWay = true
		self.FriendsWithAllPlayerAllies = false
		self.Behavior = VJ_BEHAVIOR_AGGRESSIVE
		self.DisableFindEnemy = false
		self.DisableMakingSelfEnemyToNPCs = false

		if self.AnnoyingSound then self.AnnoyingSound:Stop() end

		for i = 1,2 do
			local att = i == 2 && "eyeR" or "eyeL"
			local eyeGlow = ents.Create("env_sprite")
			eyeGlow:SetKeyValue("model","sprites/cpthazama/fnafsb/eye_flare2.vmt")
			eyeGlow:SetKeyValue("scale","0.03")
			eyeGlow:SetKeyValue("rendermode","5")
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
			util.SpriteTrail(self,i +1,Color(255,0,0,240),false,stWidth,edWidth,time,resolution,"VJ_Base/sprites/vj_trial1.vmt")

			hook.Remove("Think","VJ_FNaF_SunDrop_Look_" .. self:EntIndex())
		end

		self.SoundTbl_FootStep = {
			"cpthazama/fnafsb/moondrop/fx/fly_moonMan_walk_01.wav",
			"cpthazama/fnafsb/moondrop/fx/fly_moonMan_walk_02.wav",
			"cpthazama/fnafsb/moondrop/fx/fly_moonMan_walk_03.wav",
			"cpthazama/fnafsb/moondrop/fx/fly_moonMan_walk_04.wav",
			"cpthazama/fnafsb/moondrop/fx/fly_moonMan_walk_05.wav",
			"cpthazama/fnafsb/moondrop/fx/fly_moonMan_walk_06.wav",
			"cpthazama/fnafsb/moondrop/fx/fly_moonMan_walk_07.wav",
			"cpthazama/fnafsb/moondrop/fx/fly_moonMan_walk_08.wav"
		}
		self.SoundTbl_Idle = {
			"cpthazama/fnafsb/moondrop/MOON_00004.ogg",
			"cpthazama/fnafsb/moondrop/MOON_00005.ogg",
		}
		self.SoundTbl_CombatIdle = {
			"cpthazama/fnafsb/moondrop/MOON_00001.ogg",
			"cpthazama/fnafsb/moondrop/MOON_00001b.ogg",
			"cpthazama/fnafsb/moondrop/MOON_00009.ogg",
		}
		self.SoundTbl_Investigate = {
			"cpthazama/fnafsb/moondrop/MOON_00006_01.ogg",
			"cpthazama/fnafsb/moondrop/MOON_00006_02.ogg",
			"cpthazama/fnafsb/moondrop/MOON_00006_03.ogg",
			"cpthazama/fnafsb/moondrop/MOON_00006_04.ogg",
			"cpthazama/fnafsb/moondrop/MOON_00006_05.ogg",
			"cpthazama/fnafsb/moondrop/MOON_00006_06.ogg",
			"cpthazama/fnafsb/moondrop/MOON_00006_07.ogg",
			"cpthazama/fnafsb/moondrop/MOON_00006_08.ogg",
		}
		self.SoundTbl_LostEnemy = {
			"cpthazama/fnafsb/moondrop/MOON_00002.ogg",
		}
		self.SoundTbl_Alert = {
			"cpthazama/fnafsb/moondrop/MOON_00001c.ogg",
			"cpthazama/fnafsb/moondrop/MOON_00003.ogg",
			"cpthazama/fnafsb/moondrop/MOON_00007_pref.ogg",
			"cpthazama/fnafsb/moondrop/MOON_00008_pref.ogg",
		}
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key,activator,caller,data)
	if key == "step" then
		VJ_EmitSound(self,self.SoundTbl_FootStep,75)
	elseif key == "head_360" then
		VJ_EmitSound(self,"cpthazama/fnafsb/moondrop/fx/sfx_moonman_mech_head_spin_01.wav",75)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnPlayerSight(ply)
	if !IsValid(self.TargetPlayer) then
		self.AnnoyingSound = VJ_CreateSound(self,"cpthazama/fnafsb/sun/SUN_Hi.wav",80)
		self.TargetPlayer = ply
		local hookName = "VJ_FNaF_SunDrop_Look_" .. self:EntIndex()
		hook.Add("Think",hookName,function()
			if !IsValid(self) or IsValid(self) && (self:Health() <= 0 or !IsValid(ply)) or !IsValid(ply) or IsValid(ply) && (ply:Health() <= 0 or ply:IsFlagSet(FL_NOTARGET) or ply.IsControlingNPC) then
				hook.Remove("Think",hookName)
				ply:SetEyeAngles(Angle(ply:EyeAngles().p,ply:EyeAngles().y,0))
				return
			end
			if self:GetPos():Distance(ply:GetPos()) < 150 then
				ply.VJ_FNaF_SunLook = LerpAngle(FrameTime() *2,ply:EyeAngles(),(self:GetAttachment(self:LookupAttachment("eyes")).Pos -ply:GetShootPos()):Angle())
				ply:SetEyeAngles(ply.VJ_FNaF_SunLook)
			else
				if ply.VJ_FNaF_SunLook != 0 then
					ply.VJ_FNaF_SunLook = 0
					ply:SetEyeAngles(Angle(ply:EyeAngles().p,ply:EyeAngles().y,0))
				end
			end
		end)
		self.NextAnnoyingT = CurTime() +SoundDuration("cpthazama/fnafsb/sun/SUN_Hi.wav") +math.Rand(10,15)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:IsHittingSky()
	local tr = util.TraceLine({
		start = self:GetPos(),
		endpos = self:GetPos() +Vector(0,0,10000000),
		filter = self
	})
	if tr.HitSky then
		return true
	end
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetCrawl(b)
	if b then
		self:VJ_ACT_PLAYACTIVITY(ACT_DISARM,true,false,true)
		self.AnimTbl_IdleStand = {ACT_IDLE_SMG1}
		self.AnimTbl_Walk = {ACT_WALK_STIMULATED}
		self.AnimTbl_Run = {ACT_RUN_STIMULATED}
	else
		self:VJ_ACT_PLAYACTIVITY(ACT_ARM,true,false,true)
		self.AnimTbl_IdleStand = {ACT_IDLE}
		self.AnimTbl_Walk = {ACT_WALK}
		self.AnimTbl_Run = {ACT_RUN}
	end
	self.NextIdleTime = 0
	self.IsCrawling = b
	self.NextChangeCrawlT = CurTime() +math.Rand(10,15)
end
---------------------------------------------------------------------------------------------------------------------------------------------
-- function ENT:CustomOnAlert(ent)
-- 	if self.Mode == 0 then return end
-- 	self:VJ_FNAF_Stinger(ent)
-- end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	local ply = self.TargetPlayer
	local mode = self.Mode
	local cont = self.VJ_TheController

	if mode == 1 then
		local ent = self:GetEnemy()
		local isFlying = self.MovementType == VJ_MOVETYPE_AERIAL
		if IsValid(ent) then
			local dist = self.NearestPointToEnemyDistance
			if ((IsValid(cont) && cont:KeyReleased(IN_ATTACK2)) or (!IsValid(cont) && dist > 800 && math.abs(ent:GetPos().z -self:GetPos().z) > 300 && math.random(1,20) == 1)) && !isFlying && CurTime() > self.NextChangeMovementT then
				if self:IsHittingSky() then return end
				self:DoChangeMovementType(VJ_MOVETYPE_AERIAL)
				self:StopMoving()
				self.NextIdleStandTime = 0
				self:SetBodygroup(4,1)
				self:SetBodygroup(9,1)
				if self.IsCrawling then
					self:SetCrawl(false)
				end
				self.AnimTbl_IdleStand = {ACT_FLY}
				self.NextChangeMovementT = CurTime() +3
			elseif isFlying then
				local tr = util.TraceLine({
					start = self:GetPos(),
					endpos = self:GetPos() +Vector(0,0,-20),
					filter = self
				})
				if (((IsValid(cont) && cont:KeyReleased(IN_ATTACK2)) or (!IsValid(cont) && tr.Hit)) or self:IsHittingSky()) && CurTime() > self.NextChangeMovementT then
					self:DoChangeMovementType(VJ_MOVETYPE_GROUND)
					self:AA_StopMoving()
					self.NextIdleStandTime = 0
					self:SetBodygroup(4,0)
					self:SetBodygroup(9,0)
					self.AnimTbl_IdleStand = {ACT_IDLE}
					self.NextChangeMovementT = CurTime() +2
				end
			-- else
			-- 	if CurTime() > self.NextChangeCrawlT && math.random(1,50) == 1 then
			-- 		self:SetCrawl(!self.IsCrawling) -- Weird animation issues, most likely caused by Source itself
			-- 	end
			end
		end
	end

	self.DisableWandering = IsValid(ply)
	self:SetNW2Entity("SunEntity",ply)
	if IsValid(ply) then
		if !IsValid(ply) or IsValid(ply) && (ply:Health() <= 0 or ply:IsFlagSet(FL_NOTARGET) or (self:GetPos():Distance(ply:GetPos()) > 1000 && !self:Visible(ply))) or GetConVarNumber("ai_ignoreplayers") == 1 or mode == 1 then
			self.TargetPlayer = NULL
			self.NextAnnoyingT = CurTime() +math.Rand(10,15)
			return
		end
		local vel = ply:GetVelocity()
		-- vel.x = vel.x *2
		local tr = util.TraceLine({
			start = ply:GetPos(),
			endpos = ply:GetPos() +ply:GetForward() *80 +vel,
			filter = {self,ply}
		})
		local tPos = tr.HitPos
		local dist = self:GetPos():Distance(tPos)
		if !IsValid(cont) then
			self:SetAngles(Angle(0,(ply:GetPos() -self:GetPos()):Angle().y,0))
		end
		if CurTime() > self.NextAnnoyingT then
			VJ_CreateSound(self,self.SoundTbl_CombatIdle,75)
			self.NextAnnoyingT = CurTime() +math.Rand(7,13)
		end
		if self:BusyWithActivity() == false && dist > 35 && !IsValid(cont) then
			self:SetLastPosition(tPos)
			local movet = "TASK_WALK_PATH"
			-- local movet = ((dist < 220) and "TASK_WALK_PATH") or "TASK_RUN_PATH"
			self:VJ_TASK_GOTO_LASTPOS(movet)
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt,isProp)
	if isProp then
		return true
	end
	self:VJ_FNAF_Attack(hitEnt,VJ_GetSequenceDuration(self,ACT_MELEE_ATTACK1),2,nil,"cpthazama/fnafsb/sfx_jumpScare_scream.wav")
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnRemove()
	if self.AnnoyingSound then self.AnnoyingSound:Stop() end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnDoKilledEnemy(ent,attacker,inflictor)
	if ent:IsPlayer() && attacker == self then
		net.Start("VJ_FNaF_DeathScreen_End")
			net.WriteEntity(ent)
		net.Send(ent)
	end
end