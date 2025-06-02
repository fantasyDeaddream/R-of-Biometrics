在 R 语言中，`glmnet` 包是一个强大的工具，用于拟合带有 L1（Lasso）或 L2（Ridge）正则化的广义线性模型（GLM），也支持 Elastic Net（L1 和 L2 的组合）。该包提供了多种函数，涵盖模型拟合、交叉验证、预测、可视化等功能。

------

### 📦 `glmnet` 包的主要函数

以下是 `glmnet` 包中常用的函数及其简要说明：

#### 1. 模型拟合与正则化

- `glmnet()`：核心函数，用于拟合带有 Lasso、Ridge 或 Elastic Net 正则化的广义线性模型。支持多种模型族（`family`），如高斯（`gaussian`）、二项（`binomial`）、泊松（`poisson`）、多项（`multinomial`）、Cox 比例风险模型（`cox`）等。 ([RDocumentation](https://www.rdocumentation.org/packages/glmnet/versions/4.1-8/topics/glmnet?utm_source=chatgpt.com))
- `relax.glmnet()`：在已拟合的模型基础上，执行“relaxed”拟合，即对选定的特征子集进行无惩罚的重新拟合，以提高预测性能。 ([haoen-cui.github.io](https://haoen-cui.github.io/SOA-Exam-PA-R-Package-Documentation/glmnet/reference/index.html?utm_source=chatgpt.com))

#### 2. 交叉验证与模型选择

- `cv.glmnet()`：执行 k 折交叉验证，帮助选择最优的正则化参数 `lambda`，并可视化误差曲线。 ([R包文档](https://rdrr.io/cran/glmnet/src/R/cv.glmnet.R?utm_source=chatgpt.com))
- `glmnet.control()`：设置或查询 `glmnet` 的全局控制参数，如最大迭代次数、收敛阈值等。

#### 3. 模型评估与预测

- `predict()`：基于拟合的模型对象，进行预测。支持预测响应值、线性预测器、概率等。
- `coef()`：提取模型的回归系数。([hastie.su.domains](https://hastie.su.domains/glmnet_matlab/intro.html?utm_source=chatgpt.com))
- `deviance()`：计算模型的偏差，用于评估模型拟合优度。([haoen-cui.github.io](https://haoen-cui.github.io/SOA-Exam-PA-R-Package-Documentation/glmnet/reference/index.html?utm_source=chatgpt.com))

#### 4. 可视化与输出

- `plot()`：绘制模型的系数路径图或交叉验证误差图，便于观察正则化路径和模型性能。
- `print()`：输出模型的简要信息，包括非零系数的数量、`lambda` 值等。

#### 5. 其他辅助函数

- `assess.glmnet()`：评估模型在测试数据集上的性能指标，如均方误差（MSE）、AUC 等。([haoen-cui.github.io](https://haoen-cui.github.io/SOA-Exam-PA-R-Package-Documentation/glmnet/reference/index.html?utm_source=chatgpt.com))
- `confusion.glmnet()`：生成分类模型的混淆矩阵。([haoen-cui.github.io](https://haoen-cui.github.io/SOA-Exam-PA-R-Package-Documentation/glmnet/reference/index.html?utm_source=chatgpt.com))
- `roc.glmnet()`：绘制接收者操作特征（ROC）曲线，评估分类模型的性能。([haoen-cui.github.io](https://haoen-cui.github.io/SOA-Exam-PA-R-Package-Documentation/glmnet/reference/index.html?utm_source=chatgpt.com))
- `makeX()`：将数据框转换为模型矩阵，支持哑变量编码。([haoen-cui.github.io](https://haoen-cui.github.io/SOA-Exam-PA-R-Package-Documentation/glmnet/reference/index.html?utm_source=chatgpt.com))
- `na.replace()`：对缺失值进行处理，按列替换为指定的值。([haoen-cui.github.io](https://haoen-cui.github.io/SOA-Exam-PA-R-Package-Documentation/glmnet/reference/index.html?utm_source=chatgpt.com))

------

### 📘 参考资料

- [glmnet 包官方文档](https://www.rdocumentation.org/packages/glmnet/versions/4.1-8)
- [glmnet 包函数参考](https://haoen-cui.github.io/SOA-Exam-PA-R-Package-Documentation/glmnet/reference/index.html)
- [glmnet 包 PDF 手册](https://cran.r-project.org/web/packages/glmnet/glmnet.pdf)

------

