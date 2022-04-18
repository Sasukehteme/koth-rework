Citizen.CreateThread(function()
	Citizen.Wait(1000)
	while true do
		local mpGamerTags = {}
		for _, i in ipairs(GetActivePlayers()) do
			if NetworkIsPlayerActive(i) and i ~= PlayerId() then --and i ~= PlayerId()
				local ped = GetPlayerPed(i)

				-- change the ped, because changing player models may recreate the ped
				if not mpGamerTags[i] or mpGamerTags[i].ped ~= ped then
				  local nameTag = ('%s [%d]'):format(GetPlayerName(i), GetPlayerServerId(i))

				  if mpGamerTags[i] then
				    RemoveMpGamerTag(mpGamerTags[i].tag)
				  end

				  mpGamerTags[i] = {
				    tag = CreateMpGamerTagForNetPlayer(i, nameTag, false, false, '', 0, 0, 0, 0),
				    ped = ped
				  }
				end

				if playerTeams[GetPlayerServerId(i)].name == playerTeams[GetPlayerServerId(PlayerId())].name then
					SetMpGamerTagVisibility(mpGamerTags[i].tag, 0, true)
					SetMpGamerTagHealthBarColor(mpGamerTags[i].tag, 172)
					SetMpGamerTagAlpha(mpGamerTags[i].tag, 2, 255)
					SetMpGamerTagVisibility(mpGamerTags[i].tag, 2, true)
					SetMpGamerTagVisibility(mpGamerTags[i].tag, 4, NetworkIsPlayerTalking(i))
				else
					SetMpGamerTagVisibility(mpGamerTags[i].tag, 0, false)
					SetMpGamerTagVisibility(mpGamerTags[i].tag, 2, false)
					SetMpGamerTagVisibility(mpGamerTags[i].tag, 4, false)
				end

			elseif mpGamerTags[i] then
				RemoveMpGamerTag(mpGamerTags[i].tag)

				mpGamerTags[i] = nil
			end
		end
		Citizen.Wait(1000)
	end
end)