# NLP_WSD
Word Sense Disambiguation Program for Natural Language Processing



decision-list.pl

# This is an application to determine the senses of the word 'line' being used 
# using word sense disambiguation.  For this particular example the word being 
# solved is 'line' and the senses are phone and product.
# The program runs as follows:
#       perl decision-list.pl line-train.txt line-test.txt my-decision-list.txt > my-line-answers.txt
# where line-train.txt is the training file, line-test.txt is the test file, 
# my-decision-list.txt is an output of the decision list, and 
# my-line-answers.txt is the output of the program.
#
# The program first grabs the files and opens each.  Then it builds a training
# corpus iterating through the training file, ignoring punctuation.  After that,
# it runs through the training corpus, collecting contexts at each instance of
# the word 'line'.  The contexts are: previous 2 words, previous word, next 2 
# words, next word, and next and previous words.  It keeps track of each context
# and how many of each sense apply to each context.  Then it iterates through all
# of the contexts and builds a decision list based on the log-likelihood of each 
# context and how strongly they correlate to each sense.  If a context only applies
# to one sense then that log-likelihood is defaulted to 99999 as it will be
# automatically chosen.  The list is ordered so that it can be iterated through 
# descendingly.
#
#
# Then we iterate through the test file, collecting contexts and instance IDs for
# each instane of 'line'.  Then we check each context through the decision list
# and return the predicted sense of the context with the highest log-likelihood.
# Then each instance and sense is printed in a format that is equal to line-key.txt
#
############################################################################################################################################

scorer.pl

# This is an application to determine the accuracy of decision-list.pl,it runs
# as follows:   Perl scorer.pl my-line-answers.txt line-key.txt
#
# The program first opens both the answers file (my-line-answers.txt) and the key
# file (line-key.txt).  Then it builds arrays for each of those files to be 
# compared.  Each instance's sense is compared one at a time, and a total score 
# is compiled, as well as a confusion matrix of determined and correct senses.
# Those are then printed to STDOUT, and are displayed below for easy viewing
#
#
#
#
#=============================================================
#
#  score of decision list program is 88.2 percent
#  score from most likely tag baseline is 57.4 percent
#
#=============================================================
#          |product| phone | 
# —————————+———————+———————+  
#  product |  49   |   5   |
# —————————+———————+———————+  
#    phone |  10   |   63  |  
# —————————+———————+———————+  

