# 例7-7
library(car)
library(lme4)

# 1. 构造矩阵
# 创建因子组合和重复观测
A <- factor(rep(c("0", "0.05", "0.10", "0.15"), each = 3 * 2 * 2))  
B <- factor(rep(rep(c("0", "0.025", "0.050"), each = 2 * 2), times = 4))  
C <- factor(rep(rep(rep(c("12", "14"), each = 2), times = 3), times = 4)) 

# 响应变量
value <- c(
  1.11, 0.97, 1.52, 1.45, 1.09, 0.99, 1.27, 1.22, 0.85, 1.21, 1.67, 1.24,
  1.30, 1.00, 1.55, 1.53, 1.03, 1.21, 1.24, 1.34, 1.12, 0.96, 1.76, 1.27,
  1.22, 1.13, 1.38, 1.08, 1.34, 1.41, 1.40, 1.21, 1.34, 1.19, 1.46, 1.39,
  1.19, 1.03, 0.80, 1.29, 1.36, 1.16, 1.42, 1.39, 1.46, 1.03, 1.62, 1.27
)

# 构建数据框
df <- data.frame(A, B, C, value)
print(df)

# 6. 构建三因素固定效应 ANOVA 模型（含交互作用）
# 若不考虑交互作用只考虑主效应则使用 A+B+C 
model_fixed <- aov(value ~ A * B * C, data = df) 

# 7. 输出固定效应方差分析表
cat("=== 固定效应模型 ANOVA 结果 ===\n")
print(summary(model_fixed))


# ---------------------------
# 以下为随机模型多因素方差分析
# ---------------------------

# 8. 构建三因素随机效应混合模型
#    假设将 A、B、C 及它们的交互作用都视为随机效应
#    lmer 中 (1|因子) 表示该因子为随机截距
#    依次包括主效应和交互效应：(1|A), (1|B), (1|C), (1|A:B), (1|A:C), (1|B:C), (1|A:B:C)
model_random <- lmer(value ~ 
                       (1 | A) + 
                       (1 | B) + 
                       (1 | C) + 
                       (1 | A:B) + 
                       (1 | A:C) + 
                       (1 | B:C) + 
                       (1 | A:B:C),
                     data = df, 
                     REML = FALSE)  # 通常用 REML=FALSE 做模型比较



# 9. 输出随机效应模型的摘要
cat("\n=== 随机效应模型 (lmer) 摘要 ===\n")
print(summary(model_random))


# 10. 提取并查看各随机效应的方差分量
cat("\n=== 随机效应方差分量 (VarCorr) ===\n")
print(VarCorr(model_random), comp = c("Variance", "Std.Dev"))

# 11. 对随机效应模型进行似然比检验（LR test），与仅含常数项的模型比较
#    首先拟合仅含随机截距（无任何效应）的“空模型”：
model_null <- lmer(value ~ 1 + 
                     (1 | A) + 
                     (1 | B) + 
                     (1 | C) + 
                     (1 | A:B) + 
                     (1 | A:C) + 
                     (1 | B:C) + 
                     (1 | A:B:C),
                   data = df, 
                   REML = FALSE)

# 这里的 null 模型与 model_random 同结构，若想检验某一效应是否显著，可逐步去掉相应随机项再做比较，相当于检验所有随机效应是否都为 0。
cat("\n=== 随机效应模型 LRT 检验 ===\n")
anova(model_null, model_random)



# 12. 若用 REML 方法估计方差分量（一般用于报告最终模型），可：
model_random_REML <- lmer(value ~ 
                            (1 | A) + 
                            (1 | B) + 
                            (1 | C) + 
                            (1 | A:B) + 
                            (1 | A:C) + 
                            (1 | B:C) + 
                            (1 | A:B:C),
                          data = df, 
                          REML = TRUE)

cat("\n=== 随机效应模型 (REML 估计) 方差分量 ===\n")
print(VarCorr(model_random_REML), comp = c("Variance", "Std.Dev"))



