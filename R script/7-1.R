#例7-1
# 1. 构造观测矩阵
#    每列为一个处理组（group1–group4），每组 5 个观测值
mat <- matrix(c(
  18.1,18.6,18.7,18.9,18.3,
  17.4,17.9,17.1,16.5,17.5,
  17.3,16.9,18.5,18.2,16.2,
  15.6,15.8,16.7,15.3,16.8
), nrow = 4,byrow = TRUE)

df <- data.frame(
  value = as.vector(mat),
  group = factor(rep(paste0("G", 1:4), times = 5))
)

print(df)
# 3. Fligner–Killeen 检验（对非正态更鲁棒）
fligner_res <- fligner.test(value ~ group, data = df)
print(fligner_res)

# 2. Bartlett 检验（假设正态分布）
bartlett_res <- bartlett.test(value ~ group, data = df)
print(bartlett_res)

library(car)
leveneTest(value ~ group, data = df)

# 执行单因素方差分析
model <- aov(value ~ group, data = df)
summary(model)

library(agricolae)

# 使用 LSD.test 进行多组均值比较
lsd_result <- LSD.test(model, "group",alpha=0.05,console = FALSE)

# 查看 LSD 检验结果
print(lsd_result)

# 使用 LSD.test 进行多组均值比较
lsd_result <- LSD.test(model, "group",alpha=0.01,console = FALSE)

# 查看 LSD 检验结果
print(lsd_result)

# 使用 SNK 检验（基于 SSR 分布）
snk_result <- SNK.test(model, "group", alpha = 0.05, console = FALSE)

# 查看结果（包括 LSR）
print(snk_result)

# 使用 SNK 检验（基于 q 分布）
snk_result <- SNK.test(model, "group", alpha = 0.01, console = FALSE)

# 查看结果（包括 LSR）
print(snk_result)

# Tukey HSD 多重比较<另一种SSR？>
hsd_result <- HSD.test(model,
                       trt = "group",   # 处理变量名
                       alpha = 0.05,    # 显著性水平
                       group = TRUE,    # 是否给出分组字母
                       console = FALSE)  # 在控制台打印结果
#查看结果
print(hsd_result)

# 使用 Duncan 检验（基于 Duncan法）
duncan_result <- duncan.test(model, "group", alpha = 0.05, console = FALSE)

#查看结果
print(duncan_result)

# 使用 Duncan 检验（基于 Duncan法）
duncan_result <- duncan.test(model, "group", alpha = 0.01, console = FALSE)

#查看结果
print(duncan_result)