/datum/ai_controller/headless
	movement_delay = 0.8 SECONDS

	ai_movement = /datum/ai_movement/hybrid_pathing

	blackboard = list(
		BB_TARGETTING_DATUM = new /datum/targetting_datum/basic/allow_items()

	)

	planning_subtrees = list(
		/datum/ai_planning_subtree/flee_target,

		/datum/ai_planning_subtree/simple_find_target,
		/datum/ai_planning_subtree/attack_obstacle_in_path,
		/datum/ai_planning_subtree/find_food,
		/datum/ai_planning_subtree/basic_melee_attack_subtree,

		/datum/ai_planning_subtree/find_dead_bodies,
		/datum/ai_planning_subtree/eat_dead_body,
	)

	idle_behavior = /datum/idle_behavior/idle_random_walk
