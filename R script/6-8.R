#例6-8
# 输入数据
data <- matrix(c(20,43,21,16), nrow = 2, byrow = TRUE,
               dimnames = list(c("有效", "无效"), c("安慰剂", "新药")))
alpha=0.95
print(data)
# Fisher和卡方检验
fisher_test <- fisher.test(data,conf.level = alpha)
chi_test <- chisq.test(data,correct=TRUE,rescale.p = TRUE)
mcnemar_test<-mcnemar.test(data,correct=FALSE)
# 输出结果
print(fisher_test)
print(chi_test)
print(mcnemar_test)

