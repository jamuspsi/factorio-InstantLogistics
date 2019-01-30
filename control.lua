
script.on_event(defines.events.on_tick, function(event)
    local extracts = {}
    if event.tick % 60 == 0 then
        for index, force in pairs(game.forces) do
            for li, surface in pairs(force.logistic_networks) do
                for _, ln in pairs(surface) do
                    -- log(serpent.block(ln))
                    for _, req_point in pairs(ln.requester_points)  do
                        local owner = req_point.owner
                        if req_point.filters then 
                            for _, filter in pairs(req_point.filters) do
                                local inv = owner.get_inventory(defines.inventory.chest)
                                if inv then
                                    local has = inv.get_item_count(filter.name)
                                    if has < filter.count then
                                        --log('Someone is short ' .. (filter.count - has) .. ' of ' .. filter.name)
                                        if extracts[filter.name] == nil then
                                            extracts[filter.name] = 0
                                        end
                                        extracts[filter.name] = extracts[filter.name] + filter.count - has
                                    end
                                end
                            end
                        end
                    end

                    -- now extracts is a list of items to counts.
                    for name, demand in pairs(extracts) do
                        local prototype = game.item_prototypes[name]
                        local stacksize = prototype.stack_size
                        --log('Asking for ' .. demand .. ' of ' .. name)
                        local took = ln.remove_item({name=name, count=demand})
                        --log('Got ' .. took .. ' of ' .. name)
                        if took > 0 then
                            ln.insert({name=name, count=took}, 'requester')
                            --log('Inserting ' .. took .. ' of ' .. name)
                        end
                        -- local placed = 1
                        -- while took > 0 and placed != 0 do
                        --     local to_place = math.floor(took, stacksize)

                        -- end
                    end
                end
            end
        end
    end
end)

-- okay so I can't piggy-back on the robot's routing, which would have been nice.
-- or maybe I can
-- okay, so I can:
-- tell the logistics network to consume x items, and see how many it did.
-- tell the logistics network to put x items into the requester chests, and see how many it did
-- Leftovers are key.  I need to figure out how many to ask for first.  If I get them, then I need to insert them.  The network should handle
-- which exact things it goes into, which is probably not balanced AT ALL.  I kinda like that.
-- but that does leave the first issue.  I need to know how many things to extract.