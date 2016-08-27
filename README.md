## README
   This is my Machine Learning final project.
   
   The Project name is " Handwriting detection and evaluation"

## Flow chart of all system
![](https://github.com/vigorous0503/ML-Final-project/blob/master/flow.PNG)
## Flow chart of formula analysis
![](https://github.com/vigorous0503/ML-Final-project/blob/master/flow2.PNG)


1、主程式在main.m檔案

2、用到的副程式為以下

    a. PredictNotation: 將框出來的notation做辨識(事先train 好SVM)

	      model_4: 為SVM model1

	      model_del0.5: 為SVM model2

    b. DoArithmetic: 主要是將normal得程式變easy，做基本運算(+、-、*)，且判斷括號、sigma與連乘。

    c. Dosigma: 當在DoArithmetic偵測到有sigma時，就會進入這個function。

    c. Dopi: 當在DoArithmetic偵測到有連乘符號時，就會進入這個function。

