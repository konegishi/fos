# このappで使用する関数の定義

# 問題分を作成する
# @params ansTable 解答表
# @params questionPattern 問題形式のフラグ（1: 繰り上がりあり, 2: 繰り上がりなし, 3: ランダム）
# @params arithOperations 演算子
# @return 問題文のベクトル
getQuestions <- function(ansTable, questionPattern, arithOperations){
  if(arithOperations == "1"){
    # 足し算
    # 繰り上がり有無の設定に合わせて問題を抽出
    ansTableSampled <- switch(questionPattern, 
                              "1" = ansTable %>% 
                                filter(isCarried == T) %>%  # 繰り上がりありだけ抽出
                                sample_n(size = 20),  # ランダムに20行抽出
                              "2" = ansTable %>% 
                                filter(isCarried == F) %>%  # 繰り上がりなしだけ抽出
                                sample_n(size = 20), 
                              "3" = ansTable %>% 
                                sample_n(size = 20))
  } else if (arithOperations == "2"){
    # 引き算
    # 繰り上がり有無の設定に合わせて問題を抽出
    ansTableSampled <- switch(questionPattern, 
                              "1" = ansTable %>% 
                                filter(isBorrowed == T) %>%  # 繰り下がりありだけ抽出
                                sample_n(size = 20),  # ランダムに20行抽出
                              "2" = ansTable %>% 
                                filter(isBorrowed == F) %>%  # 繰り下がりなしだけ抽出
                                sample_n(size = 20), 
                              "3" = ansTable %>% 
                                sample_n(size = 20))
  }

  # arithOperationsで演算子の記号を決定
  oprt <- switch(arithOperations, 
                 "1" = "+",
                 "2" = "-",
                 "3" = "×",
                 "4" = "÷")
  
  # 問題文生成
  questionTexts <- c()
  answerTexts <- c()
  for(i in 1:nrow(ansTableSampled)){
    slicedTable <- ansTableSampled %>% 
      slice(i)
    questionTexts <- c(questionTexts, glue("({i}) {slicedTable$Var1} {oprt} {slicedTable$Var2} = "))
    answerTexts <- c(answerTexts, glue("({i}) {slicedTable$Var1} {oprt} {slicedTable$Var2} = {slicedTable$ans}"))
  }
  
  return(list(questionTexts = questionTexts, answerTexts = answerTexts))
}
