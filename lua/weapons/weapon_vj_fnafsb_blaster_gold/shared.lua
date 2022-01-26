if (!file.Exists("autorun/vj_base_autorun.lua","LUA")) then return end
---------------------------------------------------------------------------------------------------------------------------------------------
SWEP.Base 						= "weapon_vj_fnafsb_blaster"
SWEP.PrintName					= "Faz-Blaster (Golden)"
SWEP.Author 					= "Cpt. Hazama"
SWEP.Contact					= "http://steamcommunity.com/groups/vrejgaming"
SWEP.Purpose					= "This weapon is made for Players and NPCs"
SWEP.Instructions				= "Controls are like a regular weapon."
SWEP.Category					= "Five Nights At Freddy's"
SWEP.Spawnable					= true
SWEP.AdminSpawnable				= false

SWEP.Primary.ClipSize			= 8

SWEP.BlasterDamage = 15
SWEP.BlasterChargeDelay = 7.5
SWEP.PrimaryPitch = 125
---------------------------------------------------------------------------------------------------------------------------------------------
function SWEP:PreDrawViewModel(vm, weapon, ply)
	vm:SetSkin(1)
	self:SetSkin(1)
end