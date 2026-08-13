# Bug 报告标准

## 必填

- ID
- 标题
- 状态：confirmed/suspected/not_reproduced/expected_behavior
- Severity / Priority
- Build / Platform
- 模块
- 前置条件
- 复现步骤
- Expected
- Actual
- Reproducibility：N/M
- Evidence

## 建议字段

- Engine / device / OS / GPU
- Account / server / region
- Network condition
- Scene / map / coordinate
- First observed time
- Regression from build
- Logs / callstack
- Workaround
- Suspected component

## 标题规范

不要：`有BUG`、`角色不对`。

推荐：

`[模块][触发条件] 实际异常结果`

例：

`[Save][场景切换后立即退出] 已保存金币回退到上一次存档值`

## 步骤规范

每一步只描述一个明确动作，不把“观察结果”混在动作里。将 Expected/Actual 独立记录。

## 证据命名

建议：

`BUGID_build_platform_timestamp_type.ext`

例：

`PHY-001_b612_win11_20260813_111500_video.mp4`
