# Game Bug Tester

![Agent Skill](https://img.shields.io/badge/Agent%20Skill-portable-4C8BF5)
![强制 QA 依赖](https://img.shields.io/badge/mandatory%20QA%20deps-none-success)
![Bug Patterns](https://img.shields.io/badge/Bug%20Patterns-81-orange)
![License](https://img.shields.io/badge/license-MIT-blue)

**面向 Codex、Claude Code 以及其他兼容 Agent Skills 的“原生优先”游戏 Bug 测试 Skill。**

它让编码智能体先理解你的游戏项目和现有工具，再按风险挑选高价值 Bug，优先使用 Unity / Unreal / Godot 或项目自身已有的测试、源码、命令行、日志和状态能力完成测试，并在失败后保留证据、缩小复现条件、输出结构化 Bug 报告。

> **不强制第三方 QA 框架，不强制 Python。** 你仍然需要开发这个游戏本来就需要的引擎和工具链。

[English README](README.md) · [快速开始](docs/QUICKSTART.md) · [FAQ](docs/FAQ.md) · [架构](docs/ARCHITECTURE.md) · [兼容性](docs/COMPATIBILITY.md)

## 它解决什么问题

“帮我测一下游戏有没有 Bug”对编码智能体来说太宽泛。这个 Skill 给它一套可复用的 QA 工作流：

```text
检测项目能力
    ↓
挑选适用的高风险 Bug
    ↓
确定最强可用 Oracle
    ↓
优先使用项目/引擎原生测试
    ↓
执行 + 采证
    ↓
复现 + 缩减
    ↓
结构化 Bug 报告 + 回归建议
```

它是**测试知识与方法 Skill**，不是“任意 EXE 都能零配置全自动玩并找出全部 Bug”的夸张承诺。

## 60 秒开始

### Codex

把本仓库放到游戏项目：

```text
<你的游戏>/.agents/skills/game-bug-tester/
```

然后直接说：

```text
使用 game-bug-tester 检查当前项目。先识别引擎和已有测试能力，不要安装任何额外软件。先跑一轮 P0/P1 高风险 Bug，优先使用引擎原生测试，并列出证据和未覆盖项。
```

### Claude Code

把本仓库放到：

```text
<你的游戏>/.claude/skills/game-bug-tester/
```

然后：

```text
/game-bug-tester
```

也可以直接用自然语言提出上面的测试要求。

下载/克隆本仓库后，也可以使用可选复制脚本：

```bash
./install/install.sh codex /path/to/your-game
./install/install.sh claude /path/to/your-game
```

Windows PowerShell：

```powershell
./install/install.ps1 codex C:\path\to\your-game
./install/install.ps1 claude C:\path\to\your-game
```

这些脚本**只复制 Skill 文件**，不会安装 Python 包、npm 包、Unity Package、Unreal Plugin、Godot Addon、MCP Server 或 QA 框架。

## 四种工作模式

| 模式 | 典型环境 | 是否新装 QA 工具 | 能力 |
|---|---|---:|---|
| `NATIVE` | 有源码 + 已有引擎/工具链 | 不需要 | 默认推荐；原生测试、Harness、日志和状态探针 |
| `NATIVE_PLUS` | NATIVE + 已经存在的适配器 | 不新增 | 使用已有工具增强自动化深度 |
| `BLACKBOX_ASSISTED` | 只有 Build、没有控制接口 | 不需要 | 日志/截图/Crash 分析 + 人工辅助测试 |
| `BLACKBOX_AUTOMATED` | Build + 已有控制/自动化接口 | 不新增 | 在适配器能力范围内做自动黑盒操作 |

没有 AltTester、Airtest、Poco、Appium、Selenium、Playwright 或引擎 MCP 时，**不能阻止有源码项目继续走 NATIVE 测试**。

## 原生引擎路线

- **Unity**：优先复用已有测试；项目已经有 Unity Test Framework 就使用，没有则不自动安装，改用小型项目内 Editor/Runtime QA Harness + Unity 已有 CLI/batch 能力。
- **Unreal Engine**：优先复用 Automation / Functional / Low-Level Tests / Gauntlet（如果项目本来就在使用），并使用 Unreal 自带命令行和报告能力。
- **Godot**：优先已有测试；没有则生成项目内 GDScript/C# Harness，使用现有 Godot CLI/headless；不自动安装 GUT/WAT。
- **自研/网页游戏**：复用仓库本身已有 build/test/run 命令，并用项目当前语言生成测试 Harness。

具体见 `native/`。

## 当前知识覆盖

公开版包含 **81 类结构化常见游戏 Bug**，覆盖：

- 崩溃、卡死、黑屏、流程阻塞；
- 越界、穿墙、穿地、碰撞与物理；
- Gameplay / Character State / Combat；
- UI / Input / 经济交易一致性；
- Save / Load / Migration / Persistent State；
- 性能、图形、动画、音频；
- AI、导航、Projectile；
- 多人同步、重连、幂等、Host Migration；
- Race Condition 与状态序列 Bug。

还保留：

- 竞态时间窗搜索；
- Failure Shrinking；
- Stateful Sequence Fuzzing；
- Sequence Shrinking；
- **多维反例最小化**：同时缩减操作序列、参与者、参数、时序以及项目明确允许变化的环境扰动。

这些是**智能体可以执行的算法流程**，不是要求所有用户先装 Python Runner。V3.5 仍然要求优先使用项目已有的 Unity/C#、Unreal/C++、Godot/GDScript/C# 或自研引擎工具链来实现，不得为了最小化功能强制安装额外软件。

## 示例结果

```text
能力识别
- Engine: Unity
- Source: 有
- Existing tests: EditMode + PlayMode
- Optional adapters: 未发现
- Mode: NATIVE

P0/P1 测试
- 保存回读                  PASS
- 场景切换持久化             GAME_FAILURE
- 碰撞/越界                  PASS
- 死亡后输入锁定              PASS
- 商店交易 invariant          PASS

确认 Bug
Town → Dungeon 后 quest_stage 从 4 被重置为 0
复现：3/3
证据：结构化状态快照 + 原生测试输出
Severity: High / P1
建议：增加回归测试

未覆盖
- 多人竞态：未发现本地多人测试 Fixture
- 性能预算：项目没有明确阈值
```

详见 [Demo](docs/DEMO.md) 与 [示例 Bug 报告](docs/EXAMPLE_REPORT.md)。

## Oracle 原则

Skill 不会自己编造：

- 武器伤害；
- 商品价格；
- 冷却时间；
- 存档语义；
- FPS / 帧耗时阈值；
- 网络收敛窗口；
- AI 设计行为。

这些必须从源码、现有测试、配置、设计文档或用户明确规则中获得。无法确认期望时，应标记为需要人工/项目规则，而不是制造假 `GAME_FAILURE`。

## 一个必须说明的限制

如果只有 `Game.exe` / APK / Build，没有源码，也没有任何控制接口，Codex / Claude Code 不能凭空成为通用游戏鼠标键盘机器人。此时进入 `BLACKBOX_ASSISTED`：做日志、截图、Crash、配置分析和人工辅助测试。

如果项目本来已经有自动化控制能力，可通过 `optional/` 增强，但它们不是必需依赖。

## 安全

正式服真实充值、真实账号资产、故意坏档、网络故障注入、迁移测试、删号/封禁等操作，只允许在明确隔离的本地/测试环境执行。

构建失败、自动化失败、环境失败必须与游戏自身 Bug 分开。只有明确违反项目 Oracle / invariant 的产品行为才能判 `GAME_FAILURE`。

## 贡献

欢迎补充：

- 有可靠 Oracle 的通用 Bug Pattern；
- Unity / Unreal / Godot 原生测试方法；
- 更好的零安装降级路径；
- 可复现的小型测试 Fixture / Eval；
- 保持“可选”的自动化适配器增强。

核心原则：**不能因为一个贡献，让基础使用突然必须安装新的第三方 QA Runtime。**

见 [CONTRIBUTING.md](CONTRIBUTING.md)。

## 版本说明

- [v1.1.0 Release Notes](RELEASE_NOTES_v1.1.0.md)
- [v1.0.0 Release Notes](RELEASE_NOTES_v1.0.0.md)

## License

MIT，见 [LICENSE](LICENSE)。
