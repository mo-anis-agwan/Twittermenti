import Cocoa
import CreateML

let data = try MLDataTable(contentsOf: URL(fileURLWithPath: "/Users/anis/Desktop/Courses/iOS Bootcamp/Twittermenti/twitter-sanders-apple3.csv"))

let(trainingData, testingData) = data.randomSplit(by: 0.8, seed: 5)

let sentimentClassifier = try MLTextClassifier(trainingData: trainingData, textColumn: "text", labelColumn: "class")

let evalMetric = sentimentClassifier.evaluation(on: testingData, textColumn: "text", labelColumn: "class")

let evalAccuracy = (1.0 - evalMetric.classificationError) * 100

let metaData = MLModelMetadata(author: "Childish El-nîno", shortDescription: "Model trained to classify sentiment on Tweets", version: "1.0")

try sentimentClassifier.write(to: URL(fileURLWithPath: "/Users/anis/Desktop/Courses/iOS Bootcamp/Twittermenti/TweetSentimentClassifier.mlmodel"))

try sentimentClassifier.prediction(from: "@Apple is a good company")

try sentimentClassifier.prediction(from: "@DuckandWaffle is a bad company")
