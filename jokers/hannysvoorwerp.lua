SMODS.Joker {
  key = 'hannysvoorwerp',
  atlas = 'Jokers',
  rarity = 2,
  cost = 6,
  unlocked = true,
  blueprint_compat = true,
  eternal_compat = true,
  perishable_compat = false,
  pos = RainyDays.GetJokersAtlasTable('hannysvoorwerp'),
  attributes = { 'mult', 'scaling', 'planet', 'space' },
  config = {
    extra = {
      current_mult = 0,
      plus_mult = 5
    }
  },
  
  loc_vars = function(self, info_queue, card)
    return {
      vars = {
        card.ability.extra.plus_mult,
        card.ability.extra.current_mult
      }
    }
  end,

  
  calculate = function(self, card, context)
    if context.joker_main and card.ability.extra.current_mult > 0 then
      return {
        mult = card.ability.extra.current_mult
      }
    end
    
    if context.selling_card and not context.blueprint then
      if context.card.ability.set == 'Planet' or (RainyDays.Constellations and context.card.ability.set == 'CN_Constellation') then
        SMODS.scale_card(card, {
          ref_table = card.ability.extra,
          ref_value = 'current_mult',
          scalar_value = 'plus_mult',
          scaling_message = { message = localize('k_upgrade_ex'), message_card = card, colour = G.C.MULT }
        })
      end
    end
  end
}