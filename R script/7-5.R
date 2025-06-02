library(car)
library(lme4)
#例7.5
# 1. 构造矩阵
# 创建因子组合和重复观测
M <- factor(rep(c("5h/d", "10h/d","15h/d"), each = 3 * 4))  # 3 levels × 3 H × 4 repeats
H <- factor(rep(rep(c("25", "30", "35"), each = 4), times = 3))  # 3 repeats for each

# 响应变量（模拟数据，替换为你的观测值）
value <- c(
  143,138,120,107,  101,100,80,83,  89,93,101,76, 
  96,103,78,91,     79,61,83,59,    80,76,61,67,
  79,83,96,98,      60,71,78,64,    67,58,71,83
)

# 构建数据框
df <- data.frame(M, H, value)

print(df)
# 6. 构建二因素 ANOVA 模型（含交互作用）
#若不考虑交互作用只考虑主效应则使用 M + H 
model <- aov(value ~ M * H, data = df) 

# 7. 输出方差分析表
print(summary(model))

modelnew <- lmer(value ~ M * H + (1|M:H), data = df)

# 查看模型结果
print(summary(modelnew))

Anova(model, type = "II")
# 8. 事后检验（Tukey HSD），如有需要
print(TukeyHSD(model))

# 9. 绘制交互作用图
interaction.plot(
  x.factor    = df_long$H,
  trace.factor= df_long$M,
  response    = df_long$value,
  fun         = mean,
  type        = "b",
  pch         = 1:length(levels(df_long$M)),
  xlab        = "H 水平",
  ylab        = "平均值",
  trace.label = "M 水平"
)
