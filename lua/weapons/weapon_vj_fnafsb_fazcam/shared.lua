if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_base"
SWEP.PrintName					= "Faz-Cam"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "Five Nights At Freddy's"
	-- Client Settings ---------------------------------------------------------------------------------------------------------------------------------------------
if CLIENT then
	SWEP.Slot						= 1 -- Which weapon slot you want your SWEP to be in? (1 2 3 4 5 6) 
	SWEP.SlotPos					= 1 -- Which part of that slot do you want the SWEP to be in? (1 2 3 4 5 6)
	SWEP.SwayScale 					= 2 -- Default is 1, The scale of the viewmodel sway
	SWEP.UseHands					= true
	SWEP.ViewModelFOV				= 40
end
	-- NPC Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.NPC_NextPrimaryFire 		= 0.9 -- Next time it can use primary fires
	-- Main Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.ViewModel					= "models/cpthazama/fnaf_sb/weapons/c_fazcam.mdl"
SWEP.WorldModel					= "models/cpthazama/fnaf_sb/weapons/w_fazcam.mdl"
SWEP.HoldType 					= "camera"
SWEP.Spawnable					= true
SWEP.AdminSpawnable				= false
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.Damage				= 0 -- Damage
SWEP.Primary.ClipSize			= 1 -- Max amount of bullets per clip
SWEP.Primary.Recoil				= 1 -- How much recoil does the player get?
SWEP.Primary.Delay				= 20 -- Time until it can shoot again
SWEP.Primary.Automatic			= false -- Is it automatic?
SWEP.Primary.Tracer				= 0 -- Is it automatic?
-- SWEP.Primary.TracerName			= "VJ_FNaF_Laser" -- Is it automatic?
SWEP.Primary.Ammo				= "CombineHeavyCannon" -- Ammo type
SWEP.Primary.Sound				= {
	"cpthazama/fnafsb/weapons/sfx_fazcam_activate_01.wav",
	"cpthazama/fnafsb/weapons/sfx_fazcam_activate_02.wav",
	"cpthazama/fnafsb/weapons/sfx_fazcam_activate_03.wav",
}
SWEP.Primary.DisableBulletCode	= true -- The bullet won't spawn, this can be used when creating a projectile-based weapon
SWEP.PrimaryEffects_MuzzleAttachment = 1
SWEP.PrimaryEffects_SpawnShells = false
SWEP.PrimaryEffects_MuzzleFlash = false
SWEP.PrimaryEffects_SpawnDynamicLight = false
	-- Deployment Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.DelayOnDeploy 				= 0.6 -- Time until it can shoot again after deploying the weapon
	-- Idle Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.HasIdleAnimation			= true -- Does it have a idle animation?
SWEP.AnimTbl_Idle				= {ACT_VM_IDLE}
SWEP.NextIdle_Deploy			= 0.5 -- How much time until it plays the idle animation after the weapon gets deployed
SWEP.NextIdle_PrimaryAttack		= 0.5 -- How much time until it plays the idle animation after attacking(Primary)

SWEP.WorldModel_UseCustomPosition = true -- Should the gun use custom position? This can be used to fix guns that are in the crotch
SWEP.WorldModel_CustomPositionAngle = Vector(0,0,180)
SWEP.WorldModel_CustomPositionOrigin = Vector(-5,5,0)
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.ChargeT = 0
SWEP.ViewModelAdjust = {
	Pos = {x=0,y=5,z=-3},
	Ang = {r=5,p=0,y=0},
}
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:GetViewModelPosition(pos,ang)
	pos:Add(ang:Right() *(self.ViewModelAdjust.Pos.x))
	pos:Add(ang:Forward() *(self.ViewModelAdjust.Pos.y))
	pos:Add(ang:Up() *(self.ViewModelAdjust.Pos.z))
	ang:RotateAroundAxis(ang:Right(),self.ViewModelAdjust.Ang.r)
	ang:RotateAroundAxis(ang:Forward(),self.ViewModelAdjust.Ang.p)
	ang:RotateAroundAxis(ang:Up(),self.ViewModelAdjust.Ang.y)

	return pos,ang
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttack_BeforeShoot()
	self.ChargeT = CurTime() +8

	if SERVER then
		local vPos = self.Owner:GetShootPos()
		local vForward = self.Owner:GetAimVector()

		local trace = {}
		trace.start = vPos
		trace.endpos = vPos +vForward *256
		trace.filter = self.Owner
		local tr = util.TraceLine(trace)

		local effectdata = EffectData()
		effectdata:SetOrigin(tr.HitPos)
		util.Effect("camera_flash",effectdata,true)

		if GetConVar("vj_fnaf_cam_pic"):GetInt() == 1 then
			self.Owner:ConCommand("jpeg")
		end

		VJ_FNaF_FlashScreen(self.Owner)

		for _,v in pairs(ents.FindInSphere(vPos,400)) do
			local vSight = v.GetSightDirection && v:GetSightDirection() or v:GetForward()
			if v.VJ_FNaF_CanBeStunned && !v.VJ_FNaF_CamProtection && (vForward:Dot((v:GetPos() -vPos):GetNormalized()) > math.cos(math.rad(80))) && (vSight:Dot((vPos -v:GetPos()):GetNormalized()) > math.cos(math.rad(80))) then
				v:VJ_FNaF_Stun(self.Owner)
			end
		end

		local delay = self.Primary.Delay
		timer.Simple(delay -SoundDuration("cpthazama/fnafsb/weapons/sfx_fazcam_recharge_01.wav"),function()
			if IsValid(self) then
				VJ_CreateSound(self,"cpthazama/fnafsb/weapons/sfx_fazcam_recharge_0" .. math.random(1,3) .. ".wav")
			end
		end)
		timer.Simple(delay,function()
			if IsValid(self) then
				self:SetClip1(self.Primary.ClipSize)
			end
		end)
	end
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnThink()
	self.Primary.Delay = IsValid(self.Owner) && self.Owner:HasGodMode() && 3 or 20
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:Reload()
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CustomOnPrimaryAttackEffects()
	return false
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CalcView(ply,pos,ang,fov)
	if !IsFNaFGamemode() then return pos, ang, fov end
	if ply != self.Owner then return pos, ang, fov end

	local realspeed = ply:GetVelocity():Length2D() /ply:GetRunSpeed()
	local bobspeed = math.Clamp(realspeed *1.1, 0, 1)
	local speed = math.Clamp(ply:GetVelocity():Length2DSqr() /ply:GetRunSpeed(), 0.25, 1)
	local bob_x = math.sin((CurTime() *6) *speed *1.25) *speed *bobspeed
	ang[3] = bob_x *1.35

	return pos, ang, fov
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:CalcViewModelView(ViewModel, OldEyePos, OldEyeAng, EyePos, EyeAng) -- Credits to Rex for the sway code, he did a really good job on it. Used without permission but he loves Daddy so I'm sure he won't mind ;)
	local EyePos, EyeAng = self:GetViewModelPosition(OldEyePos, OldEyeAng)
	local ply = self:GetOwner()
	local EyePos = OldEyePos
	local EyeAng = OldEyeAng

	local realspeed = ply:GetVelocity():Length2D() /ply:GetRunSpeed()
	local speed = math.Clamp(ply:GetVelocity():Length2DSqr() /ply:GetRunSpeed(), 0.25, 1)

	local bob_x_val = CurTime()*8
	local bob_y_val = CurTime()*16
	
	local bob_x = math.sin(bob_x_val*0.15)*0.1
	local bob_y = math.sin(bob_y_val*0.15)*0.05
	EyePos = EyePos + EyeAng:Right()*bob_x
	EyePos = EyePos + EyeAng:Up()*bob_y
	EyeAng:RotateAroundAxis(EyeAng:Forward(), 5 *bob_x)
	
	local speed_mul = 3
	if self:GetOwner():IsOnGround() && realspeed > 0.1 then
		local bobspeed = math.Clamp(realspeed*1.1, 0, 1)
		local bob_x = math.sin(bob_x_val*1*speed)*0.2*bobspeed
		local bob_y = math.cos(bob_y_val*1*speed)*0.1*bobspeed
		EyePos = EyePos + EyeAng:Right()*bob_x*speed_mul *0.65
		EyePos = EyePos + EyeAng:Up() *bob_y *speed_mul *1.5
	end

	if FrameTime() < 0.04 then
		if !self.SwayPos then self.SwayPos = Vector() end
		local vel = ply:GetVelocity()
		vel.x = math.Clamp(vel.x/1000, -0.5, 0.5)
		vel.y = math.Clamp(vel.y/1000, -0.5, 0.5)
		vel.z = math.Clamp(vel.z/750, -1, 0.5)
		
		self.SwayPos = LerpVector(FrameTime()*25, self.SwayPos, -vel)
		EyePos = EyePos + self.SwayPos
	end

	local EyePos, EyeAng = self:GetViewModelPosition(EyePos, EyeAng)
	return EyePos, EyeAng
end