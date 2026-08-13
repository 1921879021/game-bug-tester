# Enemy AI Dynamic Model — v2.7

## 目的

测试可达追击、攻击距离和 target-loss 状态恢复，而不是仅看“敌人看起来动了”。

## 推荐 telemetry

- position
- velocity
- current state
- pathPending / pathStatus / remainingDistance（使用 NavMeshAgent 时）
- target visible / target id
- attack count / attack event

## 可达追击

只有项目声明应追击且路径被证实可达，才能自动判 `AI-001`。最终距离应进入 `stopping_distance + tolerance`。

## 攻击距离

为了隔离攻击判定，v2.7 的 attack boundary tests 可以在 test build 暂停导航位移，但不能暂停 AI 的攻击判定本身。若项目不能提供这种隔离能力，则应降级为人工/半自动 Oracle。

## 丢失目标

`idle/searching/return_home` 哪一种正确完全取决于项目 contract。Skill 不自行规定。
