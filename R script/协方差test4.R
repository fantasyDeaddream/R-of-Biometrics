#协方差test4
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
ancova_mod <- lm(y ~ x+feed, data = df)
summary(ancova_mod)              # x（始重）与 feed（饲料）同时的显著性
anova(ancova_mod)
ancova_mod_null <- lm(y ~ 1, data = df)    # 仅截距的空模型
anova(ancova_mod_null, ancova_mod)           # 将 x1,x2,x3 三个一起看作“回归”来源


