#例6-10
# 输入数据
library(DescTools)
library(PropCIs)
data <- matrix(c(89,37,6063,5711), nrow =2, byrow = TRUE,
               dimnames = list(c("是", "否"),c("吸烟者", "已戒烟者")))
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
chi_test <- chisq.test(data,correct=TRUE,rescale.p = TRUE)
print(chi_test)
