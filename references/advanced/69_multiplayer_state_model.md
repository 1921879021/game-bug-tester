# Multiplayer State Model (v3.0)

v3.0 把多人游戏测试从“单客户端看到什么”提升为“权威状态 + 多客户端副本 + 会话拓扑 + 网络条件”的联合模型。

核心对象：

- authoritative state：服务端/主机真正认可的业务状态。
- replica state：每个客户端收到并呈现的副本状态。
- topology：server、client、host、player/session identity。
- network profile：latency / jitter / packet loss 等测试条件。
- transaction identity：request_id / sequence_id，用于幂等与重复提交判断。

默认 Oracle 优先级：

1. 服务端权威业务状态/账本。
2. 明确的 session/ownership/transaction telemetry。
3. 多客户端最终收敛状态。
4. UI/视频只能作为辅助证据，不单独证明服务端已经正确结算。

自动化不得假设“客户端显示成功 = 服务端已成功”；也不得把暂时的预测差异直接判为 NET-001。必须等待项目声明的 convergence window。
