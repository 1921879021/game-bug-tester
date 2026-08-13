# Persistent State Model (v2.9)

Persistent State Model 将“存档是否正确”拆成 4 个独立真值：

1. **Runtime snapshot**：当前运行时真实业务状态。
2. **Durable snapshot**：磁盘/平台持久化后实际可恢复的状态。
3. **Schema contract**：字段作用域、默认值、版本与迁移规则。
4. **Lifecycle contract**：场景切换、进程重启、中断写入、损坏恢复后允许出现的状态。

字段 scope：`persistent / settings / session / transient`。自动 Oracle 不根据字段名字猜 scope。

v2.9 首批站点：`save_roundtrip / latest_commit_restart / atomic_interruption / scene_transition_persistence / settings_restart / corrupt_recovery / migration / session_reset`。
