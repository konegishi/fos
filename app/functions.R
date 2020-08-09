# このappで使用する関数の定義

# 問題分を作成する
# @param ansTable 解答表
# @return 問題文のベクトル
getQuestions <- function(ansTable){
  ansTableSampled <- ansTable %>% 
    sample_n(size = 20)  # ランダムに20行抽出
  
  questionTexts <- c()
  answerTexts <- c()
  for(i in 1:nrow(ansTableSampled)){
    slicedTable <- ansTableSampled %>% 
      slice(i)
    questionTexts <- c(questionTexts, glue("({i}) {slicedTable$Var1} + {slicedTable$Var2} = "))
    answerTexts <- c(answerTexts, glue("({i}) {slicedTable$Var1} + {slicedTable$Var2} = {slicedTable$ans}"))
  }
  
  return(list(questionTexts = questionTexts, answerTexts = answerTexts))
}
