# Starter only. Copy/adapt into res://GameBugTesterGenerated/ in a test branch/worktree.
extends SceneTree

var failures: Array[String] = []

func check(condition: bool, message: String) -> void:
    if not condition:
        failures.append(message)

func _init() -> void:
    # Agent: add deterministic project-specific checks here.
    check(true, "starter")
    if failures.is_empty():
        print('{"status":"PASS","runner":"godot-native"}')
        quit(0)
    else:
        print(JSON.stringify({"status":"GAME_FAILURE", "failures": failures}))
        quit(1)
