library(rtweet)
library(twitteR)
library(ROAuth)
#Text processing
library(stringr)
#Text mining 
library(tm)
#Keyword extraction
consumer_key <- "KMzNM5vVURVu0JcEz8x64zhtc" # Input your API Key
consumer_secret <- "9PysheLsO9DP6TqFAjjPb0rIQiYERLCtnSPiIpkUmZ9oNqMDDC" #Input your API Secret
access_token <- "126591653-J9tGbPTBkt47EnNTt93rr0WhCfquuA1vqNiDJD9A" #Input your Access Token
access_secret <- "jgRcwUt8c83cMIYbg0AkQYmRE6k33vJNCr3ZneKgHlRhH" #Input your Access token secret
twitteR::setup_twitter_oauth(consumer_key, consumer_secret, access_token, access_secret) # Select 1
search.string <- "alexa+vs+google"
tweets <- searchTwitter(search.string, n= 10000,lang="en")
twDF <- twitteR::twListToDF(tweets)
View(twDF)

tweets.df <- data.frame(twDF)

tweets.df<- PT_Classified
#Convert tweets to ASCII to avoid reading strange characters
iconv(tweets.df$text, from="UTF-8", to="ASCII", sub="")
?iconv

#Clean text by removing graphic characters
tweets.df$text=str_replace_all(tweets.df$text,"[^[:graph:]]", " ") 

#Remove Junk Values and replacement words like fffd which appear because of encoding differences            
tweets.df$text <- gsub("[^[:alnum:]///' ]", "", tweets.df$text) 

#Remove Junk Values and replacement words like fffd which appear because of encoding differences            
tweets.df$text <- gsub("[^\x01-\x7F]", "", tweets.df$text) 
#Convert all text to lower case            
tweets.df$text <- tolower(tweets.df$text)

#Remove retweet keyword            
#tweets$text <- gsub("RT", "", tweets$text)

#Remove Punctuations            
tweets.df$text <- gsub("[[:punct:]]", "", tweets.df$text)

#Remove links            
tweets.df$text <- gsub("http\\w+", "", tweets.df$text)

#Remove tabs            
tweets.df$text <- gsub("[ |\t]{2,}", "", tweets.df$text)

#Remove blankspaces at begining            
tweets.df$text <- gsub("^ ", "", tweets.df$text)

#Remove blankspaces at the end            
tweets.df$text <- gsub(" $", "", tweets.df$text)

#Remove usernames 
tweets.df$text <- gsub("@\\w+", "", tweets.df$text)
