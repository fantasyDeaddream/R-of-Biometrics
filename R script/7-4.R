#例7.4
# 1. 构造矩阵
data <- matrix(c(
  13,14,14,
  12,12,13,
  3, 3, 3,
  10, 9,10,
  2, 5, 4
), nrow = 5, byrow = TRUE,
dimnames = list(
  c("M1","M2","M3","M4","M5"),
  c("H1","H2","H3")
))

# 2. 转换为数据框并保留行名
df <- as.data.frame(data)
df$M <- rownames(df)        # 把行名存到M
rownames(df) <- NULL        # 可选：清空行名


# 3. 用 tidyr 把宽表转换成长表
library(tidyr)
df_long <- pivot_longer(
  df,
  cols = starts_with("H"),
  names_to = "H",
  values_to = "value"
)

# 4. 将 M 和 H 设为因子
df_long$M <- factor(df_long$M)
df_long$H <- factor(df_long$H)

# 5. 查看长表
print(df_long)
#      M  H value
# 1   M1 H1    13
# 2   M1 H2    14
# 3   M1 H3    14
# 4   M2 H1    12
# ...        

# 6. 构建二因素 ANOVA 模型（含交互作用）
#若不考虑交互作用只考虑主效应则使用 M + H 
model <- aov(value ~ M * H, data = df_long) 

# 7. 输出方差分析表
print(summary(model))

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
