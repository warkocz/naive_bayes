Naive Bayes Classifier
======================

## Description

For tokenization of text documents simple [Tokenizer](https://github.com/arbox/tokenizer) gem was used.

Intentionally text documents weren't cleaned from meta data before classification.

Natural logarithm was used to prevent floating point small probabilities overflow, so products of probabilities were changed to sum of probabilities logarithms.

Project classes:

* Document - helper class for wrapping text document
* DataLoader - helper class to create instances of Document class from multiple text files
* NaiveBayes - core class of the implementation

## Data

Source: [The 20 Newsgroups data set](http://qwone.com/~jason/20Newsgroups/) 

Classes: 

* motorcycles
* space

Documents:

* 90 training documents for each class
* 10 test documents for each class

## Execution

Ruby has to be installed before running following commands.

```
$ gem install bundler
```

```
$ bundle install
```

```
$ ruby script.rb
```

## Results

* 100% of test documents from 'motorcycles' news group were classified correctly
* 80% of test documents from 'space' news group were classified correctly 