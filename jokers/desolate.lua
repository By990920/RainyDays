SMODS.Joker {
  key = 'desolate',
  atlas = 'Jokers',
  rarity = 3,
  cost = 8,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = true,
  pos = RainyDays.GetJokersAtlasTable('desolate'),
  soul_pos = RainyDays.GetJokersAtlasTable('indicator_hands'),
  RD_soul_draw_as_highlight = true,
  RD_soul_draw_as_highlight_shader = 'RainyDays_indicator',
  RD_soul_draw_always = true,
  attributes = { 'xmult', 'discard', 'hand_type' },
  
  config = { 
    extra = { 
      Xmult = 3,
      hands = 9
    }
  },
  
  loc_vars = function(self, info_queue, card)
    local count = 0
    for _, value in ipairs(G.handlist) do
      if G.GAME.hands[value].rd_discarded and G.GAME.hands[value].rd_discarded > 0 then
        count = count + 1
      end
    end
    
    return {
      vars = {
        colours = {
          count >= card.ability.extra.hands and G.C.FILTER or G.C.UI.TEXT_INACTIVE
        },
        card.ability.extra.Xmult,
        card.ability.extra.hands,
        count >= card.ability.extra.hands and localize('rainydays_activated') or (card.ability.extra.hands - count) .. ' ' .. localize('rainydays_more')
      }
    }
  end,
  
  calculate = function(self, card, context)
    if context.joker_main then
      local count = 0
      for _, value in ipairs(G.handlist) do
        if G.GAME.hands[value].rd_discarded and G.GAME.hands[value].rd_discarded > 0 then
          count = count + 1
        end
      end
      
      if count >= card.ability.extra.hands then
        return {
          xmult = card.ability.extra.Xmult
        }
      end
    end
  end
}