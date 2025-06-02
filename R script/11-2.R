#例11-2
# 1. 构造数据
chuli <- factor(rep(c("1","2","3","4","5","6","7","8","9","10","11","12","13","14"), each=2))
quzu<- factor(rep(rep(c("I","II"), each = 1), times = 14))
xy <- factor(rep(rep(rep(c("x", "y"), each = 1), times = 2),times= 14))
x <- c(4.59,4.32,4.09,4.11,3.94,4.11,3.90,3.57,3.45,3.79,3.48,3.38,3.39,3.03,3.14,3.24,3.34,3.04,4.12,4.76,4.12,4.75,3.84,3.60,3.96,4.50,3.03,3.01)
y <- c(58,61,65,62,64,64,66,69,71,67,71,72,71,74,72,69,69,69,61,54,63,56,67,62,64,60,75,71)

df <- data.frame(feed,quzu, x, y)
print(df)
# 2. 一元方差分析 ANOVA
anova_mod <- aov(y ~ chuli+quzu, data = df)
summary(anova_mod)               # F 值和 p 值

# 若要事后多重比较（Tukey HSD）
TukeyHSD(anova_mod, "chuli")

# 3. 协方差分析 ANCOVA
ancova_mod <- aov(lm(y ~ chuli+quzu, data = df))
summary(ancova_mod)              # x（始重）与 feed（饲料）同时的显著性


