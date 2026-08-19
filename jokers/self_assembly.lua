SMODS.Joker {
  key = 'self_assembly',
  atlas = 'Jokers',
  rarity = 2,
  cost = 6,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  pos = RainyDays.GetJokersAtlasTable('self_assembly'),
  attributes = { 'scaling', 'mult', 'enhancements' },
  config = {
    extra = {
      mult = 0,
      mult_gain = 3
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.mult_gain,
        card.ability.extra.mult
      }
    }
  end,
  
  calculate = function(self, card, context)
    if context.joker_main then
      return {
        mult = card.ability.extra.mult
      }
    end
    
    if context.setting_ability and not context.blueprint and context.old ~= context.new and context.new ~= 'c_base' then
      card.ability.extra.trigger = (card.ability.extra.trigger or 0) + 1
      if card.ability.extra.trigger <= 1 then
        G.E_MANAGER:add_event(Event({
          func = function()
            if card.ability.extra.trigger then
              SMODS.scale_card(card, {
                ref_table = card.ability.extra,
                ref_value = 'mult',
                scalar_value = 'mult_gain',
                operation = function(ref_table, ref_value, initial, modifier)
                  ref_table[ref_value] = initial + modifier * card.ability.extra.trigger
                end,
                no_message = true
              })
              RD_card_eval_status_text(card, { message = localize('k_upgrade_ex'), colour = G.C.MULT })
              card.ability.extra.trigger = nil
            end
            return true
          end
        }))
      end
    end
  end
}

function RD_card_eval_status_text(card, extra)
  G.E_MANAGER:add_event(Event({
    trigger = 'before',
    delay = 0.9375,
    func = function()
      attention_text({
        text = extra.message or '',
        scale = 0.7,
        hold = 0.7375,
        backdrop_colour = extra and extra.colour or G.C.FILTER,
        align = 'bm',
        major = card,
        offset = { x = 0, y = 0.05 * card.T.h }
      })
      play_sound('generic1', 0.98 + 0.04 * math.random(), 1)
      
      if not extra or not extra.no_juice then
        card:juice_up(0.6, 0.1)
        G.ROOM.jiggle = G.ROOM.jiggle + 0.7
      end
      return true
    end
  }), nil, true)
end