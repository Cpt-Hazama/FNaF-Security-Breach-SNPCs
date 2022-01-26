AddCSLuaFile("shared.lua")
include('shared.lua')
/*-----------------------------------------------
	*** Copyright (c) 2012-2022 by Cpt. Hazama, All rights reserved. ***
	No parts of this code or any of its contents may be reproduced, copied, modified or adapted,
	without the prior written consent of the author, unless otherwise indicated for stand-alone materials.
-----------------------------------------------*/
ENT.Model = {"models/cpthazama/fnaf_sb/monty_shattered.mdl"}
ENT.StartHealth = 150

ENT.MaxJumpLegalDistance = VJ_Set(300,800)

ENT.Shattered = true

ENT.SoundTbl_Add = {
	"cpthazama/fnafsb/monty/fx/fly_monty_shattered_add_01.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_shattered_add_02.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_shattered_add_03.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_shattered_add_04.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_shattered_add_05.wav",
	"cpthazama/fnafsb/monty/fx/fly_monty_shattered_add_06.wav"
}
---------------------------------------------------------------------------------------------------------------------------------------------
function ENT:CustomOnInitialize()
	self.InAttack = false
	self.LeapState = 0 -- 0 = Init, 1 = In-Air
	self.NextLeapT = CurTime()

	self:SetCollisionBounds(Vector(13,13,35),Vector(-13,-13,0))

	-- self:ManipulateBoneJiggle(51,1)
	self:ManipulateBoneJiggle(54,1)
	self:ManipulateBoneJiggle(55,1)

	self.SoundTbl_FootStep = {
		"cpthazama/fnafsb/monty/fx/fly_monty_shattered_handTouch_01.wav",
		"cpthazama/fnafsb/monty/fx/fly_monty_shattered_handTouch_02.wav",
		"cpthazama/fnafsb/monty/fx/fly_monty_shattered_handTouch_03.wav",
		"cpthazama/fnafsb/monty/fx/fly_monty_shattered_handTouch_04.wav",
		"cpthazama/fnafsb/monty/fx/fly_monty_shattered_handTouch_05.wav",
		"cpthazama/fnafsb/monty/fx/fly_monty_shattered_handTouch_06.wav"
	}
end