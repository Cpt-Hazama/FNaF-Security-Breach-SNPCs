ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= ""
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= ""

include("vj_base/addons/fnaf_music.lua")

ENT.VJ_FNaF_CanBeStunned = true

function ENT:SetupDataTables()
	self:NetworkVar("Int",0,"Mouth")
end

if CLIENT then
    function ENT:CustomOnDraw()
        self.Mouth = Lerp(FrameTime() *30,self.Mouth or 0,self:GetMouth())
        self:ManipulateBoneAngles(self:LookupBone("Jaw_jnt"),Angle(self.Mouth *0.18,0,0))
        self:ManipulateBoneAngles(self:LookupBone("L_CornerLip_jnt"),Angle(self.Mouth *0.2,0,-self.Mouth))
        self:ManipulateBoneAngles(self:LookupBone("R_CornerLip_jnt"),Angle(self.Mouth *0.2,0,-self.Mouth))
    end
end