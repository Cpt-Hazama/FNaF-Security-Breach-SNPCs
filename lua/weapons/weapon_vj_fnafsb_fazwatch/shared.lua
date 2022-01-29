if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_base"
SWEP.PrintName					= "Faz-Watch"
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
SWEP.ViewModel					= "models/cpthazama/fnaf_sb/weapons/c_fazwatch.mdl"
SWEP.WorldModel					= "models/cpthazama/fnaf_sb/weapons/w_fazwatch.mdl"
SWEP.HoldType 					= "knife"
SWEP.Spawnable					= true
SWEP.AdminSpawnable				= false
	-- Primary Fire ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Primary.ClipSize			= 0 -- Max amount of bullets per clip
SWEP.Primary.DisableBulletCode	= true -- The bullet won't spawn, this can be used when creating a projectile-based weapon
SWEP.PrimaryEffects_SpawnShells = false
SWEP.PrimaryEffects_MuzzleFlash = false
SWEP.PrimaryEffects_SpawnDynamicLight = false
	-- Deployment Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.DelayOnDeploy 				= 0.6 -- Time until it can shoot again after deploying the weapon
	-- Idle Settings ---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.HasIdleAnimation			= true -- Does it have a idle animation?
SWEP.AnimTbl_Idle				= {ACT_VM_IDLE}
SWEP.NextIdle_Deploy			= 0.5 -- How much time until it plays the idle animation after the weapon gets deployed
SWEP.NextIdle_PrimaryAttack		= 1.8 -- How much time until it plays the idle animation after attacking(Primary)

SWEP.WorldModel_UseCustomPosition = true -- Should the gun use custom position? This can be used to fix guns that are in the crotch
SWEP.WorldModel_CustomPositionAngle = Vector(90,0,-90)
SWEP.WorldModel_CustomPositionOrigin = Vector(2,0,0.3)
SWEP.WorldModel_CustomPositionBone = "ValveBiped.Bip01_L_Hand"
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.ChargeT = 0
SWEP.ViewModelAdjust = {
	Pos = {x=0,y=5,z=-3},
	Ang = {r=5,p=0,y=0},
}
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:GetViewModelPosition(pos,ang)
	local vel = self:GetOwner():GetVelocity():Length2D()
	local sprint = self:GetOwner():KeyDown(IN_SPEED) && vel > 60
	local FT = FrameTime() *2
	self.ViewModelAdjust.Pos.x = Lerp(FT,self.ViewModelAdjust.Pos.x,sprint && -2 or 0)
	self.ViewModelAdjust.Pos.y = Lerp(FT,self.ViewModelAdjust.Pos.y,sprint && 2 or 5)
	self.ViewModelAdjust.Pos.z = Lerp(FT,self.ViewModelAdjust.Pos.z,sprint && -4 or -3)
	self.ViewModelAdjust.Ang.r = Lerp(FT,self.ViewModelAdjust.Ang.r,sprint && 0 or 5)

	pos:Add(ang:Right() *(self.ViewModelAdjust.Pos.x))
	pos:Add(ang:Forward() *(self.ViewModelAdjust.Pos.y))
	pos:Add(ang:Up() *(self.ViewModelAdjust.Pos.z))
	ang:RotateAroundAxis(ang:Right(),self.ViewModelAdjust.Ang.r)
	ang:RotateAroundAxis(ang:Forward(),self.ViewModelAdjust.Ang.p)
	ang:RotateAroundAxis(ang:Up(),self.ViewModelAdjust.Ang.y)

	return pos,ang
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:IsEquiped(owner)
	return IsValid(owner) && owner:GetActiveWeapon() == self
end
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PrimaryAttack()
	if (self:GetNextPrimaryFire() > CurTime()) then return end
	local owner = self:GetOwner()

	if owner:IsPlayer() then
		self:SendWeaponAnim(VJ_PICK(self.AnimTbl_PrimaryFire))
		timer.Simple(1,function()
			if IsValid(self) && self:IsEquiped(owner) && SERVER then
				local broughtFreddy = VJ_FNAF_BringFreddy(owner)
				local vm = owner:GetViewModel()
				if broughtFreddy then
					VJ_CreateSound(owner,"cpthazama/fnafsb/freddy/fx/sfx_freddy_call_succesful.wav")
					vm:SetSkin(1)
				else
					VJ_CreateSound(owner,"cpthazama/fnafsb/freddy/fx/sfx_freddy_call_unsuccesful.wav")
					vm:SetSkin(2)
					self.NextFreddySoundT = self.NextFreddySoundT or 0
					if math.random(1,5) == 1 && CurTime() > self.NextFreddySoundT then
						local snd = VJ_PICK({
							"cpthazama/fnafsb/freddy/FREDDY_00065_GregoryGregory.ogg",
						})
						VJ_CreateSound(self,snd)
						self.NextFreddySoundT = CurTime() +VJ_SoundDuration(snd) +math.random(2,8)
					end
				end
				timer.Simple(0.5,function()
					if IsValid(self) && self:IsEquiped(owner) then
						vm:SetSkin(0)
					end
				end)
			end
		end)
	end
	self:SetNextPrimaryFire(CurTime() +self.NextIdle_PrimaryAttack +0.1)
	timer.Simple(self.NextIdle_PrimaryAttack, function() if IsValid(self) then self:DoIdleAnimation() end end)
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