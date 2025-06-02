#相关系数test 使用例6-5的数据
library(DescTools)
# 输入数据
data <- matrix(c(37, 49,23, 150,100,57), nrow = 2, byrow = TRUE,
               dimnames = list(c("死亡", "未死亡"), c("甲", "乙","丙")))
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

