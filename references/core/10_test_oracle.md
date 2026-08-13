# Test Oracle：智能体如何判断“这是 Bug”

## 1. 进程 Oracle

Bug 条件示例：

- 正常输入序列导致进程异常退出
- fatal/unhandled exception 与实际退出同现
- 进程持续无响应且无法恢复

注意：日志中单独出现 error/warning 不自动等于用户可见 Bug。

## 2. 状态一致性 Oracle

同一事实在不同层必须一致：

- 背包状态 = UI 数量 = 角色实际装备
- HP 数值 = 血条 = 生死状态
- 任务后端状态 = 任务 UI = 世界对象状态

出现长期不一致即疑似/确认 Bug，取决于是否有设计依据。

## 3. 数值不变量 Oracle

常见公式：

- `balance_after = balance_before + reward - cost`
- `item_after = item_before + gained - consumed`
- `hp_after = clamp(hp_before + heal - effective_damage)`

需考虑折扣、税、Buff、护盾、服务费等设计项。

## 4. 位置/空间 Oracle

- 角色不得进入定义为不可行走/地图外的区域
- 传送/复活结果应位于合法安全点
- 关键目标应可达

若没有导航网格/坐标，可用连续录像和关卡边界证据判断。

## 5. 生命周期 Oracle

关键状态转换应有终点，不应永久卡在：

`Loading / Connecting / Saving / Matchmaking / Respawning`

除非外部服务确实不可用且产品设计明确允许无限等待（通常不建议）。

## 6. Save Snapshot Oracle

保存前后只比较“设计上应持久化”的字段；临时战斗 Buff 等不可直接判丢失。

## 7. Network Convergence Oracle

若服务端权威：最终客户端应收敛到服务端结果。
若无服务端数据：多个客户端在合理同步窗口后应对关键状态一致。

## 8. UI Reachability Oracle

关键交互满足：可见（或可导航到）→ 可触发 → 有反馈 → 结果正确。

## 9. Performance Oracle

优先：`当前值 vs 同设备/同场景历史基线/预算`。
无基线：报告测量值和体感影响，标记 suspected regression，不强行给固定阈值。

## 10. Visual Regression Oracle

截图对比必须控制：分辨率、画质、相机、时间/随机元素；动态特效/随机 NPC 区域应忽略或使用区域级规则。

## 11. 证据等级

- A：可重复 + 日志/状态/数值证据 + 截图/录像
- B：可重复 + 至少一种强证据
- C：仅一次录像/截图，缺少 oracle 数据
- D：用户描述，无复现和原始证据

CONFIRMED BUG 通常至少 B；P0 一次灾难性失败可先以 C 上报，但注明复现待补。
