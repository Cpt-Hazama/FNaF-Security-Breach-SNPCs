AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2022 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/fnaf_sb/freddy.mdl"}
ENT.StartHealth = 600

ENT.VJ_NPC_Class = {"CLASS_FNAF_ANIMATRONIC","CLASS_FNAF_ANIMATRONIC_BLOB"}

ENT.VJC_Data = {
	CameraMode = 2, -- Sets the default camera mode | 1 = Third Person, 2 = First Person
	ThirdP_Offset = Vector(0, 30, -40), -- The offset for the controller when the camera is in third person
	FirstP_Bone = "Head_jnt", -- If left empty, the base will attempt to calculate a position for first person
	FirstP_Offset = Vector(8, 0, 4), -- The offset for the controller when the camera is in first person
	FirstP_ShrinkBone = false, -- Should the bone shrink? Useful if the bone is obscuring the player's view
	FirstP_UseBoneAng = true, -- Should the camera's angle be affected by the bone's angle?
	FirstP_BoneAngAdjust = 0, -- How much should the camera's angle be rotated by? (Useful for weird bone angles, this is the roll angle)
}

ENT.Bleeds = false

ENT.HullType = HULL_HUMAN

ENT.FollowPlayer = false
ENT.BecomeEnemyToPlayer = true
ENT.OnPlayerSightDistance = 600
ENT.OnPlayerSightOnlyOnce = false

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
	"cpthazama/fnafsb/freddy/fx/fly_freddy_run_m_01.wav",
	"cpthazama/fnafsb/freddy/fx/fly_freddy_run_m_02.wav",
	"cpthazama/fnafsb/freddy/fx/fly_freddy_run_m_03.wav",
	"cpthazama/fnafsb/freddy/fx/fly_freddy_run_m_04.wav",
	"cpthazama/fnafsb/freddy/fx/fly_freddy_run_m_05.wav",
	"cpthazama/fnafsb/freddy/fx/fly_freddy_run_m_06.wav",
	"cpthazama/fnafsb/freddy/fx/fly_freddy_run_m_07.wav",
	"cpthazama/fnafsb/freddy/fx/fly_freddy_run_m_08.wav",
	"cpthazama/fnafsb/freddy/fx/fly_freddy_run_m_09.wav",
	"cpthazama/fnafsb/freddy/fx/fly_freddy_run_m_10.wav",
	"cpthazama/fnafsb/freddy/fx/fly_freddy_run_m_11.wav"
}
ENT.SoundTbl_Servo = {
	"cpthazama/fnafsb/freddy/fx/sfx_freddy_servo_small_03_m.wav",
	"cpthazama/fnafsb/freddy/fx/sfx_freddy_servo_small_05_m.wav",
}
ENT.SoundTbl_Idle = {}
ENT.SoundTbl_Pain = {
	"cpthazama/fnafsb/freddy/FREDDY_00175b_02.ogg",
	"cpthazama/fnafsb/freddy/FREDDY_00175b_03.ogg"
}
ENT.SoundTbl_Death = {
	"cpthazama/fnafsb/freddy/FREDDY_00171_pref.ogg"
}
ENT.SoundTbl_Shock = {
	"cpthazama/fnafsb/freddy/FREDDY_00199.ogg",
	"cpthazama/fnafsb/freddy/FREDDY_00201.ogg",
	"cpthazama/fnafsb/freddy/FREDDY_00202.ogg",
}
ENT.SoundTbl_Hack = {
	"cpthazama/fnafsb/freddy/FREDDY_00160.ogg",
	"cpthazama/fnafsb/freddy/FREDDY_00161_pref.ogg",
}

ENT.StartMode = 0
ENT.MaxHackLevel = 30

local nwName = "VJ_FNaF_Freddy_Controller"
util.AddNetworkString(nwName)
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Controller_Initialize(ply)
	if ply != self.Gregory then
		local cont = self.VJ_TheControllerEntity
		VJ_CreateSound(self,"cpthazama/fnafsb/freddy/supershit.mp3")
		timer.Simple(0,function()
			cont:StopControlling()
		end)
		timer.Simple(3.5,function()
			if IsValid(ply) then
				ply:Say("Freddy stop being mean to me I am like 12!")
			end
		end)
		return
	end
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
function ENT:CustomOnPlayerSight(ply)
	if !self:IsBusy() && !self:IsMoving() then
		self:VJ_ACT_PLAYACTIVITY("wave",true,false,false)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.InAttack = false
	self.Mode = 0
	self.DetectedLightness = 0
	self.HackLevel = 0
	self.InHack = false
	self.LastHackT = 0
	self.NextHackSoundT = 0
	self.NextFlashLightT = CurTime() +3
	self.NextControlT = CurTime()
	self.Grergory = NULL
	self.ToUnlock = NULL

	self:SetCollisionBounds(Vector(13,13,84),Vector(-13,-13,0))

	self.HackSound = CreateSound(self,"cpthazama/fnafsb/burntrap/fx/sfx_burntrap_hackFreddy_lp.wav")

	self:SetMode(self.StartMode)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:ChestCode(enter,ply)
	if enter then
		self:StopMoving()
		self:ClearSchedule()
		self:ClearGoal()
		self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
		for _,v in pairs(ents.GetAll()) do
			if v:IsNPC() && v:GetEnemy() == ply then
				v:ClearEnemyMemory(ply)
				v:SetEnemy(NULL)
			end
		end
		ply:AddFlags(FL_NOTARGET)
		ply:DrawViewModel(false)
		ply:Lock()
		self.ToUnlock = ply
		VJ_CreateSound(self,"cpthazama/fnafsb/freddy/fx/sfx_char_freddy_chestopen.wav")
		self:VJ_ACT_PLAYACTIVITY("vjges_chest_open",true,false,false,0,{OnFinish=function(interrupted,anim)
			-- if interrupted then return end
			VJ_CreateSound(self,"cpthazama/fnafsb/freddy/fx/sfx_char_freddy_chestenter.wav")
			VJ_CreateSound(ply,"cpthazama/fnafsb/freddy/fx/fly_gregory_freddy_enter_0" .. math.random(1,5) .. ".wav")
			local time = VJ_GetSequenceDuration(self,"enter")
			net.Start("VJ_FNaF_FreddyScreen")
				net.WriteEntity(ply)
				net.WriteEntity(self)
				net.WriteInt(time,14)
			net.Send(ply)
			timer.Simple(time -0.5,function()
				if IsValid(ply) then
					ply:UnLock()
					ply:DrawViewModel(true)
					if IsValid(self) then
						local cont = ents.Create("obj_vj_npccontroller")
						cont.VJCE_Player = ply
						cont:SetControlledNPC(self)
						cont:Spawn()
						cont:StartControlling()
						ply:SetEyeAngles(self:GetAngles())
						self.ToUnlock = NULL
					end
				end
			end)
			self:VJ_ACT_PLAYACTIVITY("vjges_enter",true,false,false,0,{OnFinish=function(interrupted,anim)
				if interrupted then return end
				self:SetState()
			end})
		end})
	else
		self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
		VJ_CreateSound(self,"cpthazama/fnafsb/freddy/fx/sfx_char_freddy_chestopen.wav")
		VJ_CreateSound(ply,"cpthazama/fnafsb/freddy/fx/fly_gregory_freddy_exit_0" .. math.random(1,5) .. ".wav")
		net.Start("VJ_FNaF_FreddyScreen")
			net.WriteEntity(ply)
			net.WriteEntity(self)
			net.WriteInt(VJ_GetSequenceDuration(self,"exit"),14)
		net.Send(ply)
		if IsValid(self.VJ_TheControllerEntity) then
			self.VJ_TheControllerEntity:StopControlling()
			ply:SetPos(self:GetPos() +self:GetForward() *25)
			ply:SetAngles(self:GetAngles())
			ply:AddFlags(FL_NOTARGET)
			ply:DrawViewModel(false)
			timer.Simple(0,function() ply:Lock() self.ToUnlock = ply end)
		end
		self:VJ_ACT_PLAYACTIVITY("vjges_exit",true,false,false,0,{OnFinish=function(interrupted,anim)
			-- if interrupted then return end
			VJ_CreateSound(self,"cpthazama/fnafsb/freddy/fx/sfx_char_freddy_chestclose.wav")
			if IsValid(ply) then
				ply:RemoveFlags(FL_NOTARGET)
				ply:DrawViewModel(true)
				ply:UnLock()
				self.ToUnlock = NULL
			end
			self:VJ_ACT_PLAYACTIVITY("vjges_chest_close",true,false,false,0,{OnFinish=function(interrupted,anim)
				if interrupted then return end
				self:SetState()
			end})
		end})
		self.Gregory = NULL
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAcceptInput(key, ply, caller, data)
	if key == "Use" then
		if IsValid(ply) && ply:IsPlayer() && ply:Alive() then
			if self.Mode == 1 then return end
			if self.InHack then return end
			if self:GetState() == VJ_STATE_ONLY_ANIMATION_NOATTACK then return end
			if self:Disposition(ply) == D_HT or self:Disposition(ply) == D_NU then return end
			if IsValid(self.Gregory) && ply == self.Gregory then
				self:ChestCode(false,ply)
				return
			end
			if !((self:GetSightDirection():Dot((ply:GetPos() -self:GetPos()):GetNormalized()) > math.cos(math.rad(self.SightAngle)))) then return end
			self.Gregory = ply
			self:ChestCode(true,ply)
		end
	elseif key == "step" then
		VJ_EmitSound(self,self.SoundTbl_FootStep,75,math.random(90,110))
		VJ_EmitSound(self,self.SoundTbl_Servo,80,math.random(100,130))
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnShocked()
	if self.Mode == 1 then return end
	self:StopAllCommonSounds()
	self.ShockSound = VJ_CreateSound(self,self.SoundTbl_Shock)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnAlert(ent)
	if self.Mode == 1 then
		self:VJ_FNAF_Stinger(ent)
		return
	end
	if math.random(1,2) == 1 && ent:IsNPC() then
		if ent:GetClass() == "npc_vj_fnafsb_chica" or ent:GetClass() == "npc_vj_fnafsb_chica_shattered" then
			self:PlaySoundSystem("Alert", {"cpthazama/fnafsb/freddy/FREDDY_00162.ogg"})
			return
		elseif ent:GetClass() == "npc_vj_fnafsb_roxy" or ent:GetClass() == "npc_vj_fnafsb_roxy_shattered" then
			self:PlaySoundSystem("Alert", {"cpthazama/fnafsb/freddy/FREDDY_00164.ogg"})
			return
		elseif ent:GetClass() == "npc_vj_fnafsb_monty" or ent:GetClass() == "npc_vj_fnafsb_monty_shattered" then
			self:PlaySoundSystem("Alert", {"cpthazama/fnafsb/freddy/FREDDY_00165b.ogg"})
			return
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetMode(m)
	if m == 0 then
		self.CallForHelp = false
		self.HasOnPlayerSight = true
		self.PlayerFriendly = true
		self.FriendsWithAllPlayerAllies = true
		self:SetEnemy(NULL)

		self:SetSkin(0)

		self.SoundTbl_CombatIdle = {}
		self.SoundTbl_OnPlayerSight = {
			"cpthazama/fnafsb/freddy/FREDDY_00051_goodNews_Pref.ogg",
		}
		self.SoundTbl_LostEnemy = {
			"cpthazama/fnafsb/freddy/FREDDY_00128a.ogg",
			"cpthazama/fnafsb/freddy/FREDDY_00247_pref.ogg",
		}
		self.SoundTbl_DamageByPlayer = {
			"cpthazama/fnafsb/freddy/FREDDY_00116a_pref.ogg",
		}
	elseif m == 1 then
		if IsValid(self.Grergory) then
			self.VJ_TheControllerEntity:StopControlling()
		end
		table.insert(self.VJ_NPC_Class,"CLASS_FNAF_BURNTRAP")
		self.CallForHelp = true
		self.HasOnPlayerSight = false
		self.PlayerFriendly = false
		self.FriendsWithAllPlayerAllies = false
		self:SetEnemy(NULL)

		self.SoundTbl_CombatIdle = {
			"cpthazama/fnafsb/freddy/FREDDY_00175b_01.ogg",
		}
		self.SoundTbl_OnPlayerSight = {}
		self.SoundTbl_LostEnemy = {}
		self.SoundTbl_DamageByPlayer = {}

		for _, x in ipairs(ents.GetAll()) do
			if (x:GetClass() != self:GetClass() && x:GetClass() != "npc_grenade_frag") && x:IsNPC() then
				x:AddEntityRelationship(self,D_NU,99)
				if x.IsVJBaseSNPC == true then
					x.MyEnemy = NULL
					x:SetEnemy(NULL)
					x:ClearEnemyMemory()
				end
			end
		end

		for i = 1,2 do
			local att = i == 2 && "eyeR" or "eyeL"
			local eyeGlow = ents.Create("env_sprite")
			eyeGlow:SetKeyValue("model","sprites/cpthazama/fnafsb/eye_flare2.vmt")
			eyeGlow:SetKeyValue("scale","0.026")
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
			util.SpriteTrail(self,i +1,Color(183,0,255,240),false,stWidth,edWidth,time,resolution,"VJ_Base/sprites/vj_trial1.vmt")
		end

		self:SetFlashlight(false)
		self:SetSkin(2)
	end
	self.Mode = m
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:SetFlashlight(b)
	if CurTime() < self.NextFlashLightT then return end
	if b then
		if IsValid(self.FlashLight1) && IsValid(self.FlashLight2) then return end
		for i = 1,2 do
			local att = i == 2 && "eyeR" or "eyeL"
			local envLight = ents.Create("env_projectedtexture")
			envLight:SetLocalPos(self:GetPos())
			envLight:SetLocalAngles(self:GetAngles())
			envLight:SetKeyValue("lightcolor","255 255 255")
			envLight:SetKeyValue("lightfov","75")
			envLight:SetKeyValue("farz","1000")
			envLight:SetKeyValue("nearz","10")
			envLight:SetKeyValue("shadowquality","1")
			envLight:Input("SpotlightTexture",NULL,NULL,"effects/flashlight001")
			envLight:SetOwner(self)
			envLight:SetParent(self)
			envLight:Spawn()
			envLight:Fire("setparentattachment",att)
			self:DeleteOnRemove(envLight)

			if i == 1 then
				self.FlashLight1 = envLight
			else
				self.FlashLight2 = envLight
			end
		end
		self:SetSkin(1)
	else
		self:SetSkin(0)
		SafeRemoveEntity(self.FlashLight1)
		SafeRemoveEntity(self.FlashLight2)
	end
	self.NextFlashLightT = CurTime() +3
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:Hack(hacker)
	if self.Mode == 1 then
		hacker:SetEnemy(NULL)
		hacker:ClearEnemyMemory()
		hacker:AddEntityRelationship(self,D_LI,99)
		if self:GetEnemy() == hacker then
			self:SetEnemy(NULL)
			self:AddEntityRelationship(hacker,D_LI,99)
		end
		return
	end
	self.LastHackT = CurTime() +1
	self.HackLevel = math.Clamp(self.HackLevel +1,0,self.MaxHackLevel)
	if !self.InHack then
		self.InHack = true
		if IsValid(self.Gregory) then
			self:ChestCode(false,self.Gregory)
		end
		self.HackSound:Play()
		VJ_CreateSound(self,"cpthazama/fnafsb/burntrap/fx/sfx_burntrap_hackFreddy_complete_leadIn_0" .. math.random(1,3) .. ".wav",80)
		self.AnimTbl_IdleStand = {ACT_IDLE_ANGRY}
		self:SetState(VJ_STATE_ONLY_ANIMATION_NOATTACK)
		self:VJ_ACT_PLAYACTIVITY("vjseq_shock_in",true,false,false)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:OnPlayCreateSound(SoundData,SoundFile)
	if string.find(string.lower(SoundFile),"jumpscare") then return end
	if string.find(SoundFile,"fx") then return end
	self.NextMouthT = CurTime() +VJ_SoundDuration(SoundFile)
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnThink()
	self:VJ_FNaF_MouthCode()

	if self.Mode == 1 then return end
	self:SetNW2Int("HackLevel",self.HackLevel)
	local lum = self.DetectedLightness
	self:SetFlashlight(lum <= 70)

	if CurTime() > self.LastHackT && self.Mode == 0 then
		self.HackLevel = math.Clamp(self.HackLevel -1,0,self.MaxHackLevel)
		if self.InHack && !self.IsShocked then
			self.InHack = false
			self.HackSound:Stop()
			self.AnimTbl_IdleStand = {ACT_IDLE}
			self:VJ_ACT_PLAYACTIVITY("vjseq_shock_out",true,false,false,0,{OnFinish=function(interrupted,anim)
				if interrupted then return end
				self:SetState()
			end})
		end
	elseif self.InHack then
		if self.Mode == 1 then return end
		if self:GetSequenceName(self:GetSequence()) != "shock" then
			self:VJ_ACT_PLAYACTIVITY("vjseq_shock",true,false,false)
		end
		if CurTime() > self.NextHackSoundT then
			self.HackVoiceSound = VJ_CreateSound(self,self.SoundTbl_Hack)
			self.NextHackSoundT = CurTime() +math.Rand(10,15)
		end
		if self.HackLevel >= self.MaxHackLevel then
			self.AnimTbl_IdleStand = {ACT_IDLE}
			self.InHack = false
			self:SetMode(1)
			self.HackSound:Stop()
			VJ_CreateSound(self,"cpthazama/fnafsb/burntrap/fx/sfx_burntrap_hackFreddy_complete_end.wav")
			VJ_CreateSound(self,"cpthazama/fnafsb/freddy/FREDDY_00122a.ogg")
			self:VJ_ACT_PLAYACTIVITY("vjseq_shock_out",true,false,false,0,{OnFinish=function(interrupted,anim)
				if interrupted then return end
				self:SetState()
			end})
		end
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnMeleeAttack_AfterChecks(hitEnt, isProp)
	if isProp then
		return true
	end
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
function ENT:CustomOnRemove()
	self.HackSound:Stop()
	if IsValid(self.ToUnlock) then
		self.ToUnlock:UnLock()
		self.ToUnlock:DrawViewModel(true)
		self.ToUnlock:RemoveFlags(FL_NOTARGET)
	end
	if self.ShockSound then self.ShockSound:Stop() end
	if self.HackVoiceSound then self.HackVoiceSound:Stop() end
end