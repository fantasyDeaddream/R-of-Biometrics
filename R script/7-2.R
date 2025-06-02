library(car)
library(lme4)
#例7.2
# 1. 构造矩阵
# 创建因子组合和重复观测
M <- factor(rep(c("东北", "内蒙古","河北","安徽","贵州"), each = 4))  


# 响应变量（模拟数据，替换为你的观测值）
value <- c(
  32.0,32.8,31.2,30.4,
  29.2,27.4,26.3,26.7,
  25.5,26.1,25.8,26.7,
  23.3,25.1,25.1,25.5,
  22.3,22.5,22.9,23.7
)

# 构建数据框
df <- data.frame(M, value)

print(df)
# 6. 构建单因素 ANOVA 模型
model <- aov(value ~ M, data = df) 

# 7. 输出方差分析表
print(summary(model))

library(agricolae)

# 使用 LSD.test 进行多组均值比较
lsd_result <- LSD.test(model, "M",alpha=0.05,console = FALSE)

# 查看 LSD 检验结果
print(lsd_result)

# 使用 LSD.test 进行多组均值比较
lsd_result <- LSD.test(model, "M",alpha=0.01,console = FALSE)

# 查看 LSD 检验结果
print(lsd_result)

# 使用 SNK 检验（基于 SSR 分布）
snk_result <- SNK.test(model, "M", alpha = 0.05, console = FALSE)

# 查看结果（包括 LSR）
print(snk_result)

# 使用 SNK 检验（基于 q 分布）
snk_result <- SNK.test(model, "M", alpha = 0.01, console = FALSE)

# 查看结果（包括 LSR）
print(snk_result)

# Tukey HSD 多重比较<另一种SSR？>
hsd_result <- HSD.test(model,
                       trt = "M",   # 处理变量名
                       alpha = 0.05,    # 显著性水平
                       group = TRUE,    # 是否给出分组字母
                       console = FALSE)  # 在控制台打印结果
#查看结果
print(hsd_result)

# 使用 Duncan 检验（基于 Duncan法）
duncan_result <- duncan.test(model, "M", alpha = 0.05, console = FALSE)

#查看结果
print(duncan_result)

# 使用 Duncan 检验（基于 Duncan法）
duncan_result <- duncan.test(model, "M", alpha = 0.01, console = FALSE)

#查看结果
print(duncan_result)


