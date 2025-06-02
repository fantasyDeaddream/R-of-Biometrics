# 例4-9(t检验，总体方差σ^2不同，但是n相同)
#样本数据1
x=c(50,47,42,43,39,51,43,38,44,37)
#样本数据2
y=c(36,38,37,38,36,39,37,35,33,37)
#F检验方差
var.test(x, y, ratio = 1,
         alternative = "two.sided",
         conf.level = 0.99)
#t检验均值
result=t.test(x, y ,
       alternative = "two.sided",
       mu = 0, paired = FALSE, var.equal = FALSE,
       conf.level = 0.99)
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