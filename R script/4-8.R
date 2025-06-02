# 例4-8
#样本数据1
x=c(134,146,106,119,124,161,107,83,113,129,97,123)
#样本数据2
y=c(70,118,101,85,107,132,94)
#F检验方差
var.test(x, y, ratio = 1,
         alternative ="two.sided",
         conf.level = 0.95)
#t检验均值
result=t.test(x, y ,
       alternative = "two.sided",
       mu = 0, paired = FALSE, var.equal = TRUE,
       conf.level = 0.95)
print(result)
if(result$p.value>1-alpha)
{
  print("接受H0:μd=0，拒绝H1:μd≠0")
  print("两个样本无显著区别")
}else
{
  print("拒绝H0:μd=0，接受H1:μd≠0")
  print("两个样本存在显著区别")
}