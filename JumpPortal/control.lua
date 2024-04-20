require "util"


local function tick_event(event)

    if global.portals == nil then
        global.portals = {}
    end
    if global.gui_tick == nil then
        global.gui_tick = 0
    end

    global.gui_tick = global.gui_tick + 1

    -- draw the main gui if there was no one

   if global.gui_tick > 600 then
       global.gui_tick = 0

       for index, player in pairs(game.connected_players) do

          -- check the inventory of thr player to find

          if player.gui.top.portal_gui == nil then
             player.gui.top.add{type="frame", name="portal_gui", caption="Portals", direction="vertical"}
             player.gui.top.portal_gui.add{type="table", name="portal_table", column_count=10}
             player.gui.top.portal_gui.add{type="button", name="hide_button", caption="Hide", button="left"}
             player.gui.top.add{type="button", name="show_button", caption="Portals", button="left"}
             player.gui.top.portal_gui.visible = true
             player.gui.top.show_button.visible = false
         end
         -- clear the table
         player.gui.top.portal_gui.portal_table.clear()
       end

   -- this code recreates all table elements
   for index, player in pairs(game.connected_players) do
         local btn=0
         for key,portal_red in pairs(global.portals) do

            local b = portal_red["layer"].get_control_behavior()
            local s = b.get_signal(1)

            if s.signal ~= nil then

                   local typ = s.signal.type
                   if typ == "virtual" then
                      typ = "virtual-signal"
                   end
                   player.gui.top.portal_gui.portal_table.add{type="sprite-button", sprite=typ .. "/" .. s.signal.name, number=s.count, name="portal_btn_" .. btn}
                   btn = btn + 1

            end
         end
      end
   end

end


function guiClick(event)

   for index, player in pairs(game.connected_players) do

      if event.element.type == "button" and event.element.name == "hide_button" then
         if player.gui.top.portal_gui ~= nil then
            player.gui.top.portal_gui.visible = false
            player.gui.top.show_button.visible = true
         end
      end

      if event.element.type == "button" and event.element.name == "show_button" then
         if player.gui.top.portal_gui ~= nil then
            player.gui.top.portal_gui.visible = true
            player.gui.top.show_button.visible = false
         end
      end

      if player.gui.top.portal_gui ~= nil and event.element.type == "sprite-button" then
         -- now find the portal
         for key,portal_red in pairs(global.portals) do

            local b = portal_red["layer"].get_control_behavior()
            local s = b.get_signal(1)

            local e = portal_red["portal"]

            if s.signal ~= nil and e.energy>10000000 then
                   local typ = s.signal.type
                   if typ == "virtual" then
                      typ = "virtual-signal"
                   end
                   typ = typ .. "/" .. s.signal.name
                   if typ == event.element.sprite and event.element.number == s.count then
                   -- jump to portal!

                   e.energy = e.energy - 10000000
                   player.teleport({portal_red["layer"].position.x, portal_red["layer"].position.y+2.4}, portal_red["layer"].surface)
                   player.surface.play_sound({path="portal-enter", position=player.position})
               end
            end
         end
      end
   end
end

function on_creation(event)
    if event.created_entity.name == "portal" then
        local entity = event.created_entity
        local ent = entity.surface.create_entity{name="portal-fg-layer", position=entity.position, force=entity.force}
        ent.minable = false

        table.insert(global.portals, { portal = entity, layer = ent })
    end
end

function on_mined(event)
    local entity = event.entity
    if entity.name == "portal" then
        for key,portal_red in pairs(global.portals) do
            if portal_red["portal"].position.x == entity.position.x and portal_red["portal"].position.y == entity.position.y then
                portal_red["layer"].destroy()
                table.remove(global.portals, key)
                break
            end
        end
    end
end

function on_destroyed(event)
    on_mined(event)
    local entity = event.entity
    if entity.name == "portal-fg-layer" then
        for key,portal_red in pairs(global.portals) do
            if portal_red["layer"].position.x == entity.position.x and portal_red["layer"].position.y == entity.position.y then
                portal_red["portal"].destroy()
                table.remove(global.portals, key)
                break
            end
        end
    end
end

script.on_event(defines.events.on_tick, tick_event)
script.on_event(defines.events.on_built_entity, on_creation)
script.on_event(defines.events.on_robot_built_entity, on_creation)
script.on_event(defines.events.on_pre_player_mined_item, on_mined)
script.on_event(defines.events.on_gui_click, guiClick)
script.on_event(defines.events.on_entity_died, on_destroyed)
