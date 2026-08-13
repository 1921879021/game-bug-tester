# Bug 分类总览

v1.0 使用 12 个工程化一级类别，以便智能体从“功能 → 风险 → 用例 → Oracle”快速映射。

| Code | 类别 | 典型问题 | 默认风险 |
|---|---|---|---|
| STAB | Stability | 崩溃、闪退、卡死、黑屏、启动失败 | 极高 |
| NAV | Navigation | 卡地图、无法到达、掉出地图、传送错误 | 高 |
| PHY | Collision/Physics | 穿墙、穿地、碰撞抖动、刚体异常 | 高 |
| CHAR | Character/State | 动作锁死、死亡仍操作、状态残留 | 高 |
| INPUT | Input | 按键无响应、重复触发、连点异常、焦点丢失 | 中高 |
| UI | UI/UX Functional | 按钮失效、遮挡、错误状态、界面打不开/关不掉 | 中高 |
| GAME | Gameplay Logic | 战斗、技能、任务、道具、经济逻辑错误 | 高 |
| SAVE | Save/Load | 丢档、回档、状态不一致、坏档 | 极高 |
| NET | Network | 掉线、重连、不同步、重复奖励、房主迁移异常 | 极高/高 |
| PERF | Performance | FPS 严重下降、卡顿、内存持续增长、加载异常 | 高/中 |
| VIS | Graphics/Animation | 模型消失、穿模、LOD、动画、渲染错误 | 中 |
| AUDIO | Audio | 丢音、重复、错音、层级/循环错误 | 中低 |

## 与学术 taxonomy 的关系

研究文献可采用 Gaming Balance、Implementation Response、Network、Sound、Temporal、Unexpected Crash、Navigational、Non-Temporal 等一级分类。v1.0 为了自动化测试可执行性，将其重新分组，并额外强调存档、性能、输入、状态机等 QA 工作中高频且需要单独 oracle 的领域。

## 选类规则

- 只有主菜单：STAB + INPUT + UI + AUDIO
- 有角色移动：再加 NAV + PHY + CHAR
- 有战斗/技能/道具：再加 GAME
- 有存档：必须加 SAVE
- 联网：必须加 NET，并同时提高 STAB / SAVE / GAME 的交叉状态覆盖
- 3D 大地图：提高 NAV / PHY / PERF / VIS
- 手机：提高 INPUT / UI / PERF / 生命周期切换
