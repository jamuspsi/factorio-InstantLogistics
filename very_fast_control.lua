
script.on_event(defines.events.on_player_created, function(event)
local items
local armor
if game.active_mods["Modular-Armor"] ~= nil then
    items = {
            {"deconstruction-planner", 1},
            {"blueprint", 1},
            {"blueprint", 1},
            {"blueprint", 1},
            {"blueprint", 1},
            {"blueprint", 1},
            {"blueprint", 1},
            {"blueprint", 1},
            {"blueprint", 1},
            {"blueprint", 1},
            {"blueprint", 1},
            {"blueprint-book", 1},
            {"modular-armor-starter", 1},
            {"construction-robot", 20},
            {"solar-panel", 40},
            {"accumulator", 40},
            {"replicator-5", 1},
            {"medium-electric-pole", 20},
    }

	armor = {
        {"personal-roboport-equipment"},
        {"personal-roboport-equipment"},
        {"personal-roboport-equipment"},
        {"personal-roboport-equipment"},
        {"personal-roboport-equipment"},
        {"personal-roboport-equipment"},
        {"personal-roboport-equipment"},
        {"personal-roboport-equipment"},
        {"personal-roboport-equipment"},
        {"personal-roboport-equipment"},
        {"battery-mk2-equipment"},
        {"battery-mk2-equipment"},
        {"battery-mk2-equipment"},
        {"fusion-reactor-equipment"},
        {"fusion-reactor-equipment"},
        {"fusion-reactor-equipment"},
	}

end
	local player = game.players[event.player_index]
	for i, v in pairs(items) do
		player.insert{name = v[1], count = v[2]}
	end

	local grid = player.get_inventory(defines.inventory.player_armor)[1].grid
	for  i, v in pairs(armor) do
		grid.put({name = v[1]})
	end

    local tech = {
        "logistics",
        "steel-processing",
        "construction-robotics",
        "automated-construction",
        "logistic-robotics",
        "logistic-system",
        "character-logistic-slots-1",
        "toolbelt",
        "landfill",
        "waterfill",
        "repl-replication-1",
        "repl-26-ore-iron",
        "repl-26-iron",
        "repl-29-ore-copper",
        "repl-29-copper",
        "repl-tenemut",
        "repl-stone",
        "repl-water",
        "repl-wood",
        "repl-crude-oil",
        "repl-replicator-1",
        "repl-steel-plate",
        "solar-energy",
        "repl-sulfuric-acid",
        "electric-energy-accumulators-1",
        "electric-energy-distribution-1",
        "dark-matter-scoop",
        "dark-matter-transducer",
        "matter-conduit",
        "repl-roboport",
        "repl-logistic-robot",
        "repl-construction-robot",
        "automation",
        "automation-2",
        "logistics-2",
        "repl-iron",
        "repl-copper",
    }
    for i, v in pairs(tech) do
        player.print("Trying to learn " .. v)
        if player.force.technologies[v] ~= nil then
            player.force.technologies[v].researched = true
        else
            player.print("Couldn't learn " .. v)
        end
    end
end)
