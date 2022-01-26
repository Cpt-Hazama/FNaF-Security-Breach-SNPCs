ENT.Base 			= "npc_vj_creature_base"
ENT.Type 			= "ai"
ENT.PrintName 		= ""
ENT.Author 			= "Cpt. Hazama"
ENT.Contact 		= "http://steamcommunity.com/groups/vrejgaming"
ENT.Purpose 		= "Spawn it and fight with it!"
ENT.Instructions 	= "Click on the spawnicon to spawn it."
ENT.Category		= ""

if CLIENT then
    local hookAnim = "Blob"
    local eyeMat = Material("hud/fnaf/char/HUD_Generic.png")

	net.Receive("VJ_FNaF_" .. hookAnim .. "_Controller",function(len,pl)
		local delete = net.ReadBool()
		local ent = net.ReadEntity()
		local class = net.ReadString()
		local ply = net.ReadEntity()
		local cent = net.ReadEntity()

		if !IsValid(ent) then delete = true end

        local hookName = "VJ_FNaF_" .. hookAnim .. "_HUD_" .. ent:EntIndex()

        if !delete then
            local col = Color(math.random(0,255),math.random(0,255),math.random(0,255))
            hook.Add("RenderScreenspaceEffects",hookName,function()
                if !IsValid(ent) then
                    hook.Remove("RenderScreenspaceEffects",hookName)
                    return
                end

                local tab = {
                    ["$pp_colour_addr"] = math.abs(math.sin(CurTime() *0.5) *1),
                    ["$pp_colour_addg"] = math.abs(math.sin(CurTime() *0.9) *0.4),
                    ["$pp_colour_addb"] = math.abs(math.sin(CurTime() *0.3) *0.1),
                    ["$pp_colour_brightness"] = -0.4,
                    ["$pp_colour_contrast"] = 2,
                    ["$pp_colour_colour"] = 0.6,
                    ["$pp_colour_mulr"] = 0,
                    ["$pp_colour_mulg"] = 0,
                    ["$pp_colour_mulb"] = 0
                }
				DrawColorModify(tab)

                surface.SetDrawColor(255,0,0,100)
                surface.SetMaterial(Material("hud/fnaf/static_vanny"))
                surface.DrawTexturedRect(0,0,ScrW(),ScrH())

                surface.SetDrawColor(247,0,255)
                surface.SetMaterial(eyeMat)
                surface.DrawTexturedRect(0,0,ScrW(),ScrH() *0.65)
            end)
		else
            hook.Remove("RenderScreenspaceEffects",hookName)
        end
    end)
end