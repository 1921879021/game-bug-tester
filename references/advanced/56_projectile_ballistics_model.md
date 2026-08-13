# Projectile / Ballistics Model — v2.7

## 目的

把 `PHY-004 高速投射物穿透目标` 从“普通攻击 LOS 候选”升级为 projectile-specific 动态测试。

## 必须由项目声明的真值

- fire action
- projectile speed
- damage
- fixed physics timestep（或项目等价离散步长）
- max range / lifetime 约束
- penetration policy

`speed × fixed_delta_time / target_thickness` 只作为 tunneling 风险指标。风险比很大时应优先执行，但不能单独判 Bug。

## 运行时证据

至少读取：真实投射物 hit telemetry、命中对象 ID、目标 HP/命中事件。墙体遮挡测试还应保存 first collider / wall hit 信息。

## Oracle

- `high_speed_target`: 合法命中条件下，目标应获得项目声明的伤害/命中事件。
- `projectile_wall_blocked`: 仅当 contract 明确 `penetration_count=0` 时，墙后目标的 HP delta 应为 0。
