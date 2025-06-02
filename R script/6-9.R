#例6-9
# 输入数据
library(DescTools)
library(PropCIs)
data <- matrix(c(41,8,15,11), nrow =2, byrow = TRUE,
               dimnames = list(c("真手术", "假手术"),c("成功", "失败")))
alpha=0.95
#φ相关系数
phi_coef <- Phi(data)
print("φ相关系数为：")
print(phi_coef)
#列联相关系数C
c_coef <- ContCoef(data)
cat("列联系数 C:", c_coef,"\n")
#V相关系数
cramer_v <- CramerV(data)
print("V相关系数为：")
print(cramer_v)
#wald风格的置信区间
prop.test(data, conf.level = 0.95, correct = TRUE)
# 计算 Agresti-Caffo 风格的置信区间
x1=41
n1=49
x2=15
n2=26
result <- diffscoreci(x1,n1,x2,n2,conf.level = alpha)

print(result)
# 输出结果
cat("比例差估计:", (x1/n1) - (x2/n2), "\n",
    "95% 置信区间: [", result$conf.int[1], ",", result$conf.int[2], "]")