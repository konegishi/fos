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
  } else if (arithOperations == "4"){
    # 割り算
    # 余り有無の設定に合わせて問題を抽出
    ansTableWithout1 <- ansTable %>% 
      filter(ans != 1)
    ansTableAdjusted <- ansTable %>% 
      filter(ans == 1) %>% 
      sample_n(size = trunc(nrow(ansTableWithout1) * 0.1)) %>% 
      bind_rows(ansTableWithout1)
    ansTableSampled <- switch(questionPattern, 
                              # 余りあり（1桁）
                              "1" = ansTable %>%
                                filter(haveRmdr == T) %>%  # 余りありだけ抽出
                                sample_n(size = 20),  # ランダムに20行抽出
                              # 余りなし（1桁）
                              "2" = ansTable %>%  
                                filter(haveRmdr == F) %>%  # 余りなしだけ抽出
                                sample_n(size = 20), 
                              # ランダム
                              "3" = ansTableAdjusted %>%  
                                sample_n(size = 20),
                              # 余りあり（1桁以外）
                              "4" = ansTableAdjusted %>%  
                                filter(haveRmdr == T) %>%  # 余りありだけ抽出
                                sample_n(size = 20),  # ランダムに20行抽出
                              # 余りなし（1桁以外）
                              "5" = ansTableAdjusted %>%  
                                filter(haveRmdr == F) %>%  # 余りなしだけ抽出
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
    
    # 問題文
    questionTexts <- c(questionTexts, glue("({i}) {slicedTable$Var1} {oprt} {slicedTable$Var2} = "))
    
    # 答え付き
    if (arithOperations == "4" && slicedTable$haveRmdr) {
      # 割り算の時には余りが
      ansTemplate <- "({i}) {slicedTable$Var1} {oprt} {slicedTable$Var2} = {slicedTable$ans}  あまり {slicedTable$rmdr} "
    } else {
      ansTemplate <- "({i}) {slicedTable$Var1} {oprt} {slicedTable$Var2} = {slicedTable$ans}"
    }
    answerTexts <- c(answerTexts, glue(ansTemplate))
  }
  
  return(list(questionTexts = questionTexts, answerTexts = answerTexts))
}
