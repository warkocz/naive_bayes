require_relative 'lib/document'
require_relative 'lib/naive_bayes'
require_relative 'lib/data_loader'

# Commented out data from module 2 used to double check correctness of classifier implementation
=begin
classes = [CLASS_L = 'list', CLASS_D = 'dict']

training_documents = [
    Document.new('1', CLASS_L, %w(append remove reverse)),
    Document.new('2', CLASS_L, %w(index append remove fromkeys)),
    Document.new('3', CLASS_D, %w(copy update)),
    Document.new('4', CLASS_D, %w(popitem fromkeys update)),
    Document.new('5', CLASS_D, %w(sort reverse keys))
]

test_documents = [
    Document.new('6', nil, %w(popitem popitem update fromkeys)),
    Document.new('7', nil, %w(append))
]
=end

classes = %w(motorcycles space)
data_loader = DataLoader.new(classes)
training_documents = data_loader.documents('training')
test_documents = data_loader.documents('test')

naive_bayes = NaiveBayes.new(classes, training_documents, test_documents)
naive_bayes.run


