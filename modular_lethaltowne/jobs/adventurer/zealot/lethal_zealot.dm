/datum/job/roguetown/lethaltowne/zealot
	title = "Zealot"
	flag = ADVENTURER
	department_flag = PEASANTS
	faction = "Station"
	total_positions = INFINITY
	spawn_positions = INFINITY
	allowed_races = RACES_ALL_KINDS
	tutorial = ""
	selection_color = JCOLOR_PEASANT
	outfit = null
	outfit_female = null
	display_order = JDO_ADVENTURER
	round_contrib_points = 2
	advclass_cat_rolls = list(CTAG_LETHALZEALOT = 20)
	wanderer_examine = FALSE
	advjob_examine = TRUE

/datum/job/roguetown/lethaltowne/zealot/after_spawn(mob/living/L, mob/M, latejoin = TRUE)
	..()
	if(L)
		var/mob/living/carbon/human/H = L
		if(!H.mind)
			return
		H.advsetup = 1
		H.invisibility = INVISIBILITY_MAXIMUM
		H.become_blind("advsetup")
