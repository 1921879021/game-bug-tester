# Advanced Dynamics Model (v2.8)

本层只消费 **Project Contract + ENGINE_OBSERVED/DECLARED world evidence**，负责把高价值动态问题转成可执行测试。

## Projectile
- Ballistics：用项目声明的初速度、重力、仰角、水平距离计算参考落点/飞行时间；如果项目使用风阻、制导或自定义曲线，必须替换 oracle。
- AOE：半径边界内外各生成一例，以真实 HP/damage event 判定，不把物理查询本身当作产品伤害真值。
- Penetration：在 `max_layers` 与 `max_layers + 1` 两侧做边界测试。
- Hit point：比较真实 impact point 与项目参考点距离。

## AI
- Dynamic Replan：先追击，再启用动态障碍，观察 replan_count/path/progress。
- Crowd Progress：多个 agent 同向移动，检查 timeout 内最少到达数量。
- Crowd Separation：仅在项目明确 min_separation 时自动判定。
