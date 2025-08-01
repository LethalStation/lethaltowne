/obj/effect/proc_holder/spell/invoked/vigorousexchange
	name = "Vigorous Exchange"
	desc = "Restores the targets Energy, Twice as effective on someone else."
	overlay_state = "vigorousexchange"
	releasedrain = 0
	chargedrain = 0
	chargetime = 0
	warnie = "sydwarning"
	movement_interrupt = FALSE
	no_early_release = TRUE
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/items/bsmithfail.ogg'
	invocation = "Through flame and ash, let vigor rise, by Malum’s hand, let strength reprise!"
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = FALSE
	recharge_time = 3 MINUTES
	chargetime = 2 SECONDS
	miracle = TRUE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	devotion_cost = 30
	
/obj/effect/proc_holder/spell/invoked/heatmetal
	name = "Heat Metal"
	desc= "Damages Armor, Forces target to drop a metallic weapon, heats up an ingot in tongs or smelts a single item."
	overlay_state = "heatmetal"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 15
	warnie = "sydwarning"
	movement_interrupt = FALSE
	no_early_release = TRUE
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/items/bsmithfail.ogg'
	invocation = "With heat I wield, with flame I claim, Let metal serve in Malum's name!"
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = FALSE
	recharge_time = 2 MINUTES
	chargetime = 2 SECONDS
	miracle = TRUE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	devotion_cost = 40

/obj/effect/proc_holder/spell/invoked/hammerfall
	name = "Hammerfall"
	desc = "Damages structures in an area while possibly knocking down mobs in the area."
	overlay_state = "Hammerfall"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 15
	warnie = "sydwarning"
	movement_interrupt = FALSE
	no_early_release = TRUE
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/items/bsmithfail.ogg'
	invocation = "By molten might and hammer's weight, in Malum’s flame, the earth shall quake!"
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	recharge_time = 5 MINUTES
	chargetime = 2 SECONDS
	miracle = TRUE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	devotion_cost = 80

/obj/effect/proc_holder/spell/invoked/craftercovenant
	name = "The Crafter’s Covenant"
	desc = "Melt a pile of valuables and convert them into a single item. Sacrifice is accepted even if its not valuable enough to make anything."
	overlay_state = "craftercovenant"
	releasedrain = 30
	chargedrain = 0
	chargetime = 0
	range = 1
	warnie = "sydwarning"
	movement_interrupt = TRUE
	no_early_release = TRUE
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/items/bsmithfail.ogg'
	invocation = "Coins to ash, flame to form, in Malum’s name, let creation be born!"
	invocation_type = "shout"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = FALSE
	recharge_time = 25 MINUTES
	chargetime = 10 SECONDS
	miracle = TRUE
	charging_slowdown = 3
	chargedloop = /datum/looping_sound/invokegen
	devotion_cost = 100

/obj/effect/proc_holder/spell/invoked/heatmetal/cast(list/targets, mob/user = usr)
	. = ..()
	var/list/nosmeltore = list(/obj/item/rogueore/coal)
	var/datum/effect_system/spark_spread/sparks = new()
	var/target
	for(var/i in targets)
		target = i
	if (!target)
		return
	if(target in nosmeltore)
		return
	if (istype(target, /obj/item))
		handle_item_smelting(target, user, sparks, nosmeltore)
	else if (iscarbon(target))
		handle_living_entity(target, user, nosmeltore)

/proc/show_visible_message(mob/user, text, selftext)
	var/text_to_send = addtext("<font color='yellow'>", text, "</font>")
	var/selftext_to_send = addtext("<font color='yellow'>", selftext, "</font>")
	user.visible_message(text_to_send, selftext_to_send)

/proc/handle_item_smelting(obj/item/target, mob/user, datum/effect_system/spark_spread/sparks, list/nosmeltore)
	if (!target.smeltresult) return
	var/obj/item/itemtospawn = target.smeltresult
	show_visible_message(user, "After [user]'s incantation, [target] glows brightly and melts into an ingot.", null)
	new itemtospawn(target.loc)
	sparks.set_up(1, 1, target.loc)
	sparks.start()
	qdel(target)

/proc/handle_living_entity(mob/target, mob/user, list/nosmeltore)
	var/obj/item/targeteditem = get_targeted_item(user, target)
	if (!targeteditem || targeteditem.smeltresult == /obj/item/ash || target.anti_magic_check(TRUE,TRUE)) 
		show_visible_message(user, "After their incantation, [user] points at [target] but it seems to have no effect.", "After your incantation, you point at [target] but it seems to have no effect.")
		return
	if (istype(targeteditem, /obj/item/rogueweapon/tongs))
		handle_tongs(targeteditem, user)
	else if (should_heat_in_hand(user, target, targeteditem, nosmeltore))
		handle_heating_in_hand(target, targeteditem, user)
	else
		handle_heating_equipped(target, targeteditem, user)

/proc/get_targeted_item(mob/user, mob/target)
    var/target_item
    switch(user.zone_selected)
        if (BODY_ZONE_PRECISE_R_HAND)
            target_item = target.held_items[2]
        if (BODY_ZONE_PRECISE_L_HAND)
            target_item = target.held_items[1]
        if (BODY_ZONE_HEAD)
            target_item = target.get_item_by_slot(SLOT_HEAD)
        if (BODY_ZONE_PRECISE_EARS)
            target_item = target.get_item_by_slot(SLOT_HEAD)
        if (BODY_ZONE_CHEST)
            if(target.get_item_by_slot(SLOT_ARMOR))
                target_item = target.get_item_by_slot(SLOT_ARMOR)
            else if (target.get_item_by_slot(SLOT_SHIRT))
                target_item = target.get_item_by_slot(SLOT_SHIRT)    
        if (BODY_ZONE_PRECISE_NECK)
            target_item = target.get_item_by_slot(SLOT_NECK)
        if (BODY_ZONE_PRECISE_R_EYE)
            target_item = target.get_item_by_slot(ITEM_SLOT_MASK)
        if ( BODY_ZONE_PRECISE_L_EYE)
            target_item = target.get_item_by_slot(ITEM_SLOT_MASK)
        if (BODY_ZONE_PRECISE_NOSE)
            target_item = target.get_item_by_slot(ITEM_SLOT_MASK)
        if (BODY_ZONE_PRECISE_MOUTH)
            target_item = target.get_item_by_slot(ITEM_SLOT_MOUTH)
        if (BODY_ZONE_L_ARM)
            target_item = target.get_item_by_slot(ITEM_SLOT_WRISTS)
        if (BODY_ZONE_R_ARM)
            target_item = target.get_item_by_slot(ITEM_SLOT_WRISTS)
        if (BODY_ZONE_L_LEG)
            target_item = target.get_item_by_slot(ITEM_SLOT_PANTS)
        if (BODY_ZONE_R_LEG)
            target_item = target.get_item_by_slot(ITEM_SLOT_PANTS)
        if (BODY_ZONE_PRECISE_GROIN)
            target_item = target.get_item_by_slot(ITEM_SLOT_PANTS)
        if (BODY_ZONE_PRECISE_R_FOOT)
            target_item = target.get_item_by_slot(ITEM_SLOT_SHOES)
        if (BODY_ZONE_PRECISE_L_FOOT)
            target_item = target.get_item_by_slot(ITEM_SLOT_SHOES)
    return target_item

/proc/handle_tongs(obj/item/rogueweapon/tongs/T, mob/user) //Stole the code from smithing.
	if (!T.hingot) return
	var/tyme = world.time
	T.hott = tyme
	addtimer(CALLBACK(T, TYPE_PROC_REF(/obj/item/rogueweapon/tongs, make_unhot), tyme), 100)
	T.update_icon()
	show_visible_message(user, "After [user]'s incantation, the ingot inside [T] starts glowing.", "After your incantation, the ingot inside [T] starts glowing.")

/proc/handle_heating_in_hand(mob/living/carbon/target, obj/item/targeteditem, mob/user)
	var/datum/effect_system/spark_spread/sparks = new()
	apply_damage_to_hands(target, user)
	target.dropItemToGround(targeteditem)
	show_visible_message(target, "[target]'s [targeteditem.name] glows brightly, searing their flesh.", "Your [targeteditem.name] glows brightly, It burns!")
	target.emote("painscream")
	playsound(target.loc, 'sound/misc/frying.ogg', 100, FALSE, -1)
	sparks.set_up(1, 1, target.loc)
	sparks.start()

/proc/should_heat_in_hand(mob/user, mob/target, obj/item/targeteditem, list/nosmeltore)
	return ((user.zone_selected == BODY_ZONE_PRECISE_L_HAND && target.held_items[1]) || (user.zone_selected == BODY_ZONE_PRECISE_R_HAND && target.held_items[2])) && !(targeteditem in nosmeltore) && targeteditem.smeltresult

/proc/apply_damage_to_hands(mob/living/carbon/target, mob/user)
	var/obj/item/bodypart/affecting
	var/const/adth_damage_to_apply = 10 //How much damage should burning your hand before dropping the item do.
	if (user.zone_selected == BODY_ZONE_PRECISE_R_HAND)
		affecting = target.get_bodypart(BODY_ZONE_R_ARM)
	else if (user.zone_selected == BODY_ZONE_PRECISE_L_HAND)
		affecting = target.get_bodypart(BODY_ZONE_L_ARM)
	affecting.receive_damage(0, adth_damage_to_apply)

/proc/handle_heating_equipped(mob/living/carbon/target, obj/item/clothing/targeteditem, mob/user)
	var/obj/item/armor = target.get_item_by_slot(SLOT_ARMOR)
	var/obj/item/shirt = target.get_item_by_slot(SLOT_SHIRT)
	var/armor_can_heat = armor && armor.smeltresult && armor.smeltresult != /obj/item/ash
	var/shirt_can_heat = shirt && shirt.smeltresult && shirt.smeltresult != /obj/item/ash // Full damage if no shirt 
	var/damage_to_apply = 20 // How much damage should your armor burning you should do.
	if (user.zone_selected == BODY_ZONE_CHEST)
		if (armor_can_heat && (!shirt_can_heat && shirt))
			damage_to_apply = damage_to_apply / 2 // Halve the damage if only armor can heat but shirt can't.
		if (targeteditem == shirt & armor_can_heat) //this looks redundant but it serves to make sure the damage is doubled if both shirt and armor are metallic.
			apply_damage_if_covered(target, list(BODY_ZONE_CHEST), armor, CHEST, damage_to_apply)
		else if (targeteditem == armor & shirt_can_heat)
			apply_damage_if_covered(target, list(BODY_ZONE_CHEST), shirt, CHEST, damage_to_apply)
	apply_damage_if_covered(target, list(BODY_ZONE_CHEST), targeteditem, CHEST, damage_to_apply)
	apply_damage_if_covered(target, list(BODY_ZONE_L_ARM, BODY_ZONE_R_ARM), targeteditem, ARMS|HANDS, damage_to_apply)
	apply_damage_if_covered(target, list(BODY_ZONE_L_LEG, BODY_ZONE_R_LEG), targeteditem, GROIN|LEGS|FEET, damage_to_apply)
	apply_damage_if_covered(target, list(BODY_ZONE_HEAD), targeteditem, HEAD|HAIR|NECK|NOSE|MOUTH|EARS|EYES, damage_to_apply)
	show_visible_message(target, "[target]'s [targeteditem.name] glows brightly, searing their flesh.", "My [targeteditem.name] glows brightly, It burns!")
	playsound(target.loc, 'sound/misc/frying.ogg', 100, FALSE, -1)

/proc/apply_damage_if_covered(mob/living/carbon/target, list/body_zones, obj/item/clothing/targeteditem, mask, damage)
	var/datum/effect_system/spark_spread/sparks = new()
	var/obj/item/bodypart/affecting = null
	for (var/zone in body_zones)
	{
		if (targeteditem.body_parts_covered & mask)
			affecting = target.get_bodypart(zone)
		if (affecting)
			affecting.receive_damage(0, damage)
			sparks.set_up(1, 1, target.loc)
			sparks.start()
	}

/obj/effect/proc_holder/spell/invoked/vigorousexchange/cast(list/targets, mob/living/carbon/user = usr)
	. = ..()
	var/const/starminatoregen = 500 // How much stamina should the spell give back to the caster.
	var/mob/target = targets[1]
	if (!iscarbon(target)) 
		return
	if (target == user)
		target.energy_add(starminatoregen)
		show_visible_message(usr, "As [user] intones the incantation, vibrant flames swirl around them.", "As you intones the incantation, vibrant flames swirl around you, You feel refreshed.")
	else if (user.energy > (starminatoregen * 2))
		user.energy_add(-(starminatoregen * 2))
		target.energy_add(starminatoregen * 2)
		show_visible_message(target, "As [user] intones the incantation, vibrant flames swirl around them, a dance of energy flowing towards [target].", "As [user] intones the incantation, vibrant flames swirl around them, a dance of energy flowing towards you. You feel refreshed")

/obj/effect/proc_holder/spell/invoked/craftercovenant/cast(list/targets, mob/user = usr)
	. = ..()
	var/tithe = 0
	var/list/doable[][] = list()
	var/const/divine_tax = 2 // Multiplier used to adjust the price that should be paid.
	var/buyprice = 0
	var/turf/altar
	var/datum/effect_system/spark_spread/sparks = new()
	altar = get_turf(targets[1])
	if(!altar)
		return
	for (var/obj/item/sacrifice in altar.contents)
	{
		if (istype(sacrifice, /obj/item/roguecoin/))
			var/obj/item/roguecoin/coincrifice = sacrifice
			tithe += (coincrifice.quantity * coincrifice.sellprice)
		else if (istype(sacrifice, /obj/item/roguestatue/) || istype(sacrifice, /obj/item/clothing/ring/) || istype(sacrifice, /obj/item/roguegem/))
			tithe += sacrifice.sellprice
		qdel(sacrifice)
	}
	buyprice = tithe / divine_tax
	for (var/list/entry in anvil_recipe_prices)
	{
		var/obj/item/tentative_item = entry[1] // The recipe
		var/total_sellprice = entry[2] // The precompiled material price
		if (total_sellprice <= buyprice)
			var/obj/itemtorecord = tentative_item
			doable += list(list(itemtorecord.name, itemtorecord))
	}
	if (!doable.len)
		show_visible_message(usr, "A wave of heat washes over the pile as [user] speaks Malum's name. The pile of valuables crumble into dust.", "A wave of heat washes over the pile as you speak Malum's name. The pile of valuables crumble into dust. Malum accepted your sacrifice. Yet it seems it wasn't enough.")
		return
	var/list/doablename = list()
	var/list/item_map = list()
	for (var/list/doableextract in doable)
	{
		doablename += list(doableextract[1])
		item_map[doableextract[1]] = doableextract[2]
	}
	var/itemchoice = input(user, "Choose your boon", "Available boons") in (doablename)
	if (itemchoice)
		var/obj/item/itemtospawn = item_map[itemchoice]
		if (itemtospawn)
			new itemtospawn.type(altar)
			sparks.set_up(1, 1, altar)
			sparks.start()
			show_visible_message(usr, "A wave of heat washes over the pile as [user] speaks Malum's name. The pile of valuables crumble into dust, only for the dust to reform into an item as if reborn from the flames. Malum has accepted the offering.", "A wave of heat washes over the pile as you speak Malum's name. The pile of valuables crumble into dust, only for the dust to reform into an item as if reborn from the flames. Malum has accepted the offering.")

var/global/list/anvil_recipe_prices[][]
/proc/add_recipe_to_global(var/datum/anvil_recipe/recipe)
	var/total_sellprice = 0
	var/obj/item/ingot/bar = recipe.req_bar
	var/obj/item/itemtosend = null
	if (bar)
		total_sellprice += bar.sellprice
		itemtosend = recipe.created_item
	if (recipe.additional_items)
		for (var/obj/additional_item in recipe.additional_items)
			total_sellprice += additional_item.sellprice
	if (istype(recipe.created_item, /list))
		var/list/itemlist = recipe.created_item
		total_sellprice = total_sellprice/itemlist.len
		itemtosend = recipe.created_item[1]
	if (!istype(recipe.created_item, /list))
		itemtosend = recipe.created_item
	if (total_sellprice > 0)
		global.anvil_recipe_prices += list(list(itemtosend, total_sellprice))

/proc/initialize_anvil_recipe_prices()
	for (var/datum/anvil_recipe/armor/recipe)
	{
		add_recipe_to_global(recipe)
	}
	for (var/datum/anvil_recipe/tools/recipe)
	{
		add_recipe_to_global(recipe)
	}
	for (var/datum/anvil_recipe/weapons/recipe)
	{
		add_recipe_to_global(recipe)
	}
	global.anvil_recipe_prices += list(list(new /obj/item/rogue/instrument/flute, 10))
	global.anvil_recipe_prices += list(list(new /obj/item/rogue/instrument/drum, 10))
	global.anvil_recipe_prices += list(list(new /obj/item/rogue/instrument/harp, 20))
	global.anvil_recipe_prices += list(list(new /obj/item/rogue/instrument/lute, 20))
	global.anvil_recipe_prices += list(list(new /obj/item/rogue/instrument/guitar, 30))
	global.anvil_recipe_prices += list(list(new /obj/item/rogue/instrument/accord, 30))
	global.anvil_recipe_prices += list(list(new /obj/item/riddleofsteel, 400))
	global.anvil_recipe_prices += list(list(new /obj/item/dmusicbox, 500))
	// Add any other recipe types if needed

/world/New()
	..()
	initialize_anvil_recipe_prices() // Precompute recipe prices on startup

/obj/effect/proc_holder/spell/invoked/hammerfall/cast(list/targets, mob/user = usr)
	var/turf/fallzone = null
	var/const/damage = 250 //Structural damage the spell does. At 250, it would take 4 casts (8 minutes and 320 devotion) to destroy a normal door.
	var/const/radius = 1 //Radius of the spell
	var/const/shakeradius = 7 //Radius of the quake
	var/diceroll = 0
	var/const/dc = 42 //Code will roll 2d20 and add target's perception and Speed then compare to this to see if they fall down or not. 42 Means they need to roll 2x 20 with Speed and Perception at I
	var/const/delay = 2 SECONDS // Delay between the ground marking appearing and the effect playing.
	fallzone = get_turf(targets[1])
	if(!fallzone)
		return
	else
		show_visible_message(usr, "[usr] raises their arm, conjuring a hammer wreathed in molten fire. As they hurl it toward the ground, the earth trembles under its impact, shaking its very foundations!", "You raise your arm, conjuring a hammer wreathed in molten fire. As you hurl it toward the ground, the earth trembles under its impact, shaking its very foundations!")
	for (var/turf/open/visual in view(radius, fallzone))
		var/obj/effect/temp_visual/lavastaff/Lava = new /obj/effect/temp_visual/lavastaff(visual)
		animate(Lava, alpha = 255, time = 5)
	sleep(delay)
	for (var/mob/living/carbon/screenshaken in view(shakeradius, fallzone))
		shake_camera(screenshaken, 5, 5)
	for (var/mob/living/carbon/shaken in view(radius, fallzone))
		diceroll = roll(2,20) + shaken.STAPER + shaken.STASPD
		if (diceroll > dc)
			shaken.apply_effect(1 SECONDS, EFFECT_IMMOBILIZE, 0)
			show_visible_message(shaken, null, "The ground quakes but I manage to keep my footing.")
		else
			shaken.apply_effect(1 SECONDS, EFFECT_KNOCKDOWN, 0)		
			show_visible_message(shaken, null, "The ground quakes, making me fall over.")
	for (var/obj/structure/damaged in view(radius, fallzone))
		if(!istype(damaged, /obj/structure/flora/newbranch))
			damaged.take_damage(damage,BRUTE,"blunt",1)
	for (var/turf/closed/wall/damagedwalls in view(radius, fallzone))
		damagedwalls.take_damage(damage,BRUTE,"blunt",1)
	for (var/turf/closed/mineral/aoemining in view(radius, fallzone))
		aoemining.lastminer = usr
		aoemining.take_damage(damage,BRUTE,"blunt",1)

/obj/effect/proc_holder/spell/invoked/malum_flame_rogue
	name = "Malum's Fire"
	desc = "Ignites target."
	overlay_state = "sacredflame"
	releasedrain = 15
	chargedrain = 0
	chargetime = 0
	range = 15
	warnie = "sydwarning"
	movement_interrupt = FALSE
	chargedloop = null
	req_items = list(/obj/item/clothing/neck/roguetown/psicross)
	sound = 'sound/magic/heal.ogg'
	invocation = "Flame."
	invocation_type = "whisper"
	associated_skill = /datum/skill/magic/holy
	antimagic_allowed = TRUE
	recharge_time = 15 SECONDS
	miracle = TRUE
	devotion_cost = 15

/obj/effect/proc_holder/spell/invoked/malum_flame_rogue/cast(list/targets, mob/user = usr)
	. = ..()
	if(isliving(targets[1]))
		var/mob/living/L = targets[1]
		user.visible_message("<font color='yellow'>[user] points at [L]!</font>")
		if(L.anti_magic_check(TRUE, TRUE))
			return FALSE
		L.adjust_divine_fire_stacks(1)
		L.IgniteMob()
		return TRUE

	// Spell interaction with ignitable objects (burn wooden things, light torches up)
	else if(isobj(targets[1]))
		var/obj/O = targets[1]
		if(O.fire_act())
			user.visible_message("<font color='yellow'>[user] points at [O], igniting it with sacred flames!</font>")
			return TRUE
		else
			to_chat(user, span_warning("You point at [O], but it fails to catch fire."))
			return FALSE
	return FALSE


/obj/effect/temp_visual/lavastaff
	icon_state = "lavastaff_warn"
	duration = 50
