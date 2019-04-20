#!/usr/bin/env python

from __future__ import division

import os
import re
import sys
import time

import json
import string

# Sentiments dictionary
sentimentDict = {'positive': {}, 'negative': {}}

def loadSentiments():
    with open('/home/cloudera/Downloads/Source_files_final/sentiments/positive-words.txt', 'r') as posFile:
        for line in posFile:
            sentimentDict['positive'][line.strip()] = 1

    with open('/home/cloudera/Downloads/Source_files_final/sentiments/negative-words.txt', 'r') as negFile:
        for line in negFile:
            sentimentDict['negative'][line.strip()] = 1

# Main mapper function
def main():
    loadSentiments()

    for tweetObject in sys.stdin:    

        # Formatting Date to  date format
        tweetObject = tweetObject.strip().split('\t')
        
        userId = tweetObject[0].strip()

        # formatting tweet text to lower case
        tweetText = tweetObject[1].lower()
        
        
        tweetText = re.sub('[^a-zA-Z]', ' ', tweetText)
        
        words = {}
        for w in tweetText.split():
            if len(w) > 0:
                words[w] = 1

        lTweet = len(words)
        
        counts = {'positive':0, 'negative':0}
        ratios = {'positive':0, 'negative':0}
        
        for key in ['samsung', 'apple']:
            if key in tweetText:
                for a in ['positive', 'negative']:
                    for i in sentimentDict[a].keys():
                        if i in words:
                            counts[a]+=1
                    
                    ratios[a] = counts[a]/lTweet
                    
                print '\t'.join([userId, key, str(ratios['positive'] - ratios['negative'])])
    
if __name__ == '__main__':
    main()