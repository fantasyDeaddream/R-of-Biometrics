#协方差test2
# 1. 构造数据
feed <- factor(rep(c("A1","A2","A3"), each=8))
x    <- c(18,16,11,14,14,13,17,17,
          17,18,18,19,21,21,16,22,
          18,23,23,20,24,25,25,26)
y    <- c(85,89,65,80,78,83,91,85,
          95,100,94,98,104,97,90,106,
          91,89,98,82,100,98,102,108)

df <- data.frame(feed, x, y)
print(df)
# 2. 一元方差分析 ANOVA
anova_mod <- aov(y ~ feed, data = df)
summary(anova_mod)               # F 值和 p 值

# 若要事后多重比较（Tukey HSD）
TukeyHSD(anova_mod, "feed")

# 3. 协方差分析 ANCOVA
ancova_mod <- aov(y ~ feed + x, data = df)
summary(ancova_mod)              # x（始重）与 feed（饲料）同时的显著性
str(ancova_mod)
# 4. 绘图检查模型假定（可选）
par(mfrow=c(2,2))
plot(anova_mod)                  # ANOVA 残差图
plot(ancova_mod)                 # ANCOVA 残差图

# 5. 校正后组均值（LS-means）（可选，需要加载 emmeans 包）
# install.packages("emmeans")
library(emmeans)
emm <- emmeans(ancova_mod, ~ feed, cov.reduce = mean)  
summary(emm)                     # 给出校正初始体重后的各组预测均值
