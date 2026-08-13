// Starter only. Copy/adapt into Assets/GameBugTesterGenerated/Editor/ in a TEST branch/worktree.
// Does not depend on a third-party QA package.
using System;
using System.IO;
using UnityEditor;
using UnityEngine;

namespace GameBugTester.Generated
{
    public static class GameBugTesterEditorRunner
    {
        public static void Run()
        {
            var output = Path.Combine(Directory.GetCurrentDirectory(), "game-bug-tester-result.json");
            try
            {
                // Agent: replace/add project-specific deterministic checks here.
                var json = "{\"status\":\"PASS\",\"runner\":\"unity-native\"}";
                File.WriteAllText(output, json);
                Debug.Log("GAME_BUG_TESTER_PASS " + output);
            }
            catch (Exception ex)
            {
                File.WriteAllText(output, "{\"status\":\"ENVIRONMENT_FAILURE\"}");
                Debug.LogException(ex);
                EditorApplication.Exit(1);
            }
        }
    }
}
