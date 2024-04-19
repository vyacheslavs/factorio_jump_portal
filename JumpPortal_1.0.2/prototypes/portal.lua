
local portal = table.deepcopy(data.raw.item["storage-tank"])
portal.name = "portal"
portal.order = "a[items]-c[portal]"
portal.place_result = "portal"

local portal_recipe = table.deepcopy(data.raw.recipe["storage-tank"])
portal_recipe.name = "portal"
portal_recipe.ingredients = { {"storage-tank", 1}, {"constant-combinator", 1}, {"advanced-circuit", 100}, {"electronic-circuit", 100}, {"processing-unit", 100} }
portal_recipe.enabled = false
portal_recipe.result = "portal"

data:extend({portal, portal_recipe})

data:extend({
    {
        type = "accumulator",
        name = "portal",
        order = "a[items]-c[portal]",
        minable = {mining_time = 1.5, result = "portal"},
        picture = {
          filename = "__JumpPortal__/graphics/portal.png",
          width=110,
          height=108,
          direction_count = 1
        },
        selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
        collision_box = {{-1.4, -1.4}, {1.4, 1.4}},
        energy_source =
        {
          type = "electric",
          buffer_capacity = "100MJ",
          usage_priority = "tertiary",
          input_flow_limit = "300kW",
          output_flow_limit = "1kW"
        },
        charge_cooldown = 30,
        discharge_cooldown = 60

    }
})

data:extend({

  {
    type = "technology",
    name = "portals",
    icon_size = 256, icon_mipmaps = 4,
    icon = "__JumpPortal__/graphics/portal_icon.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "portal"
      }
    },
    unit =
    {
      count = 100,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1}
      },
      time = 30
    },
    prerequisites = {"advanced-electronics-2", "low-density-structure", "chemical-science-pack"},
    order = "c-a"
  }
})

function generate_constant_combinator(combinator)
  combinator.sprites =
    make_4way_animation_from_spritesheet({ layers =
      {
        {
          filename = "__base__/graphics/entity/combinator/constant-combinator.png",
          width = 58,
          height = 52,
          frame_count = 1,
          shift = util.by_pixel(0, 5),
          hr_version =
          {
            scale = 0.5,
            filename = "__base__/graphics/entity/combinator/hr-constant-combinator.png",
            width = 114,
            height = 102,
            frame_count = 1,
            shift = util.by_pixel(0, 5)
          }
        },
        {
          filename = "__base__/graphics/entity/combinator/constant-combinator-shadow.png",
          width = 50,
          height = 34,
          frame_count = 1,
          shift = util.by_pixel(9, 6),
          draw_as_shadow = true,
          hr_version =
          {
            scale = 0.5,
            filename = "__base__/graphics/entity/combinator/hr-constant-combinator-shadow.png",
            width = 98,
            height = 66,
            frame_count = 1,
            shift = util.by_pixel(8.5, 5.5),
            draw_as_shadow = true
          }
        }
      }
    })
  combinator.activity_led_sprites =
  {
    north = util.draw_as_glow
    {
      filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-N.png",
      width = 8,
      height = 6,
      frame_count = 1,
      shift = util.by_pixel(9, -12),
      hr_version =
      {
        scale = 0.5,
        filename = "__base__/graphics/entity/combinator/activity-leds/hr-constant-combinator-LED-N.png",
        width = 14,
        height = 12,
        frame_count = 1,
        shift = util.by_pixel(9, -11.5)
      }
    },
    east = util.draw_as_glow
    {
      filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-E.png",
      width = 8,
      height = 8,
      frame_count = 1,
      shift = util.by_pixel(8, 0),
      hr_version =
      {
        scale = 0.5,
        filename = "__base__/graphics/entity/combinator/activity-leds/hr-constant-combinator-LED-E.png",
        width = 14,
        height = 14,
        frame_count = 1,
        shift = util.by_pixel(7.5, -0.5)
      }
    },
    south = util.draw_as_glow
    {
      filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-S.png",
      width = 8,
      height = 8,
      frame_count = 1,
      shift = util.by_pixel(-9, 2),
      hr_version =
      {
        scale = 0.5,
        filename = "__base__/graphics/entity/combinator/activity-leds/hr-constant-combinator-LED-S.png",
        width = 14,
        height = 16,
        frame_count = 1,
        shift = util.by_pixel(-9, 2.5)
      }
    },
    west = util.draw_as_glow
    {
      filename = "__base__/graphics/entity/combinator/activity-leds/constant-combinator-LED-W.png",
      width = 8,
      height = 8,
      frame_count = 1,
      shift = util.by_pixel(-7, -15),
      hr_version =
      {
        scale = 0.5,
        filename = "__base__/graphics/entity/combinator/activity-leds/hr-constant-combinator-LED-W.png",
        width = 14,
        height = 16,
        frame_count = 1,
        shift = util.by_pixel(-7, -15)
      }
    }
  }
  combinator.circuit_wire_connection_points =
  {
    {
      shadow =
      {
        red = util.by_pixel(7, -6),
        green = util.by_pixel(23, -6)
      },
      wire =
      {
        red = util.by_pixel(-8.5, -17.5),
        green = util.by_pixel(7, -17.5)
      }
    },
    {
      shadow =
      {
        red = util.by_pixel(32, -5),
        green = util.by_pixel(32, 8)
      },
      wire =
      {
        red = util.by_pixel(16, -16.5),
        green = util.by_pixel(16, -3.5)
      }
    },
    {
      shadow =
      {
        red = util.by_pixel(25, 20),
        green = util.by_pixel(9, 20)
      },
      wire =
      {
        red = util.by_pixel(9, 7.5),
        green = util.by_pixel(-6.5, 7.5)
      }
    },
    {
      shadow =
      {
        red = util.by_pixel(1, 11),
        green = util.by_pixel(1, -2)
      },
      wire =
      {
        red = util.by_pixel(-15, -0.5),
        green = util.by_pixel(-15, -13.5)
      }
    }
  }
  return combinator
end

-- minable = {mining_time = 0.1, result = "portal"},

data:extend({
  generate_constant_combinator {
    type = "constant-combinator",
    name = "portal-fg-layer",
    icon = "__base__/graphics/icons/storage-tank.png",
    icon_size = 64, icon_mipmaps = 4,
    flags = {"placeable-neutral", "player-creation"},
    minable = {mining_time = 0.1, result = "portal"},
    max_health = 120,
    corpse = "constant-combinator-remnants",
    dying_explosion = "constant-combinator-explosion",
    collision_box = {{-1.5, -1.5}, {1.5, 1.5}},
    selection_box = {{-0.6, 0.2}, {0.6, 1.4}},
    fast_replaceable_group = "constant-combinator",

    item_slot_count = 1,

    activity_led_light =
    {
      intensity = 0,
      size = 1,
      color = {r = 1.0, g = 1.0, b = 1.0}
    },

    activity_led_light_offsets =
    {
      {0.296875, -0.40625},
      {0.25, -0.03125},
      {-0.296875, -0.078125},
      {-0.21875, -0.46875}
    },

    circuit_wire_max_distance = 9
  }
})

data:extend(
{
  {
    type = "sound",
    name = "portal-enter",
    filename = "__JumpPortal__/sounds/portal_enter.ogg",
    volume = 0.42
  }
})


