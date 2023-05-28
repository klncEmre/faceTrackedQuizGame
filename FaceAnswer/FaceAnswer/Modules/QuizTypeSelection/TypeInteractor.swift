//
//  Interactor.swift
//  FaceAnswer
//
//  Created by EMRE KILINC on 13.05.2023.
//

import Foundation
import UIKit
import CoreData


protocol TypeInputInteractor: AnyInteractor {
    //return type will bi list of questions
    func getQuestions(quizType: QuizType) -> [Question]
    
}

class TypeSelectionInteractor: TypeInputInteractor {
    
    let historyQuestions: [Question] = [
        Question(questionText: "Who wrote the Declaration of Independence?", optionFirst: "Thomas Jefferson", optionSecond: "George Washington", correctAnswer: 1),
        Question(questionText: "Which country was responsible for the construction of the Great Wall?", optionFirst: "China", optionSecond: "India", correctAnswer: 1),
        Question(questionText: "What year did World War II end?", optionFirst: "1945", optionSecond: "1918", correctAnswer: 1),
        Question(questionText: "Who was the first person to step on the moon?", optionFirst: "Neil Armstrong", optionSecond: "Buzz Aldrin", correctAnswer: 1),
        Question(questionText: "Which ancient civilization built the pyramids?", optionFirst: "Egyptians", optionSecond: "Greeks", correctAnswer: 1),
        Question(questionText: "Who was the leader of the Soviet Union during World War II?", optionFirst: "Joseph Stalin", optionSecond: "Vladimir Lenin", correctAnswer: 1),
        Question(questionText: "Which city hosted the first modern Olympic Games?", optionFirst: "Athens", optionSecond: "Paris", correctAnswer: 1),
        Question(questionText: "Which famous document begins with the words 'When in the course of human events'?", optionFirst: "The Declaration of Independence", optionSecond: "The Constitution", correctAnswer: 1),
        Question(questionText: "Who painted the Mona Lisa?", optionFirst: "Leonardo da Vinci", optionSecond: "Michelangelo", correctAnswer: 1),
        Question(questionText: "In what year did the Berlin Wall fall?", optionFirst: "1989", optionSecond: "1961", correctAnswer: 1),
        Question(questionText: "Who was the first Emperor of Rome?", optionFirst: "Julius Caesar", optionSecond: "Augustus", correctAnswer: 2),
        Question(questionText: "Which city was the capital of the Byzantine Empire?", optionFirst: "Rome", optionSecond: "Constantinople", correctAnswer: 2),
        Question(questionText: "Which famous queen ruled Egypt and is known for her alliance with Mark Antony?", optionFirst: "Cleopatra", optionSecond: "Nefertiti", correctAnswer: 1),
        Question(questionText: "In what year did the French Revolution begin?", optionFirst: "1789", optionSecond: "1812", correctAnswer: 1),
        Question(questionText: "Who was the first female Prime Minister of the United Kingdom?", optionFirst: "Margaret Thatcher", optionSecond: "Angela Merkel", correctAnswer: 1),
        Question(questionText: "Which country was responsible for the colonization of India?", optionFirst: "England", optionSecond: "France", correctAnswer: 1),
        Question(questionText: "Who was the leader of the Soviet Union during the Cuban Missile Crisis?", optionFirst: "Nikita Khrushchev", optionSecond: "Mikhail Gorbachev", correctAnswer: 1),
        Question(questionText: "Which war was fought between North Korea and South Korea from 1950 to 1953?", optionFirst: "Vietnam War", optionSecond: "Korean War", correctAnswer: 2),
        Question(questionText: "Which city was the capital of the Inca Empire?", optionFirst: "Cusco", optionSecond: "Machu Picchu", correctAnswer: 1),
        Question(questionText: "Who was the first President of the United States to be impeached?", optionFirst: "Andrew Johnson", optionSecond: "Bill Clinton", correctAnswer: 1)
    ]

    let artQuestions: [Question] = [
        Question(questionText: "Who painted The Last Supper?", optionFirst: "Leonardo da Vinci", optionSecond: "Pablo Picasso", correctAnswer: 1),
        Question(questionText: "What is the name of the famous sculpture of a seated pharaoh?", optionFirst: "The Thinker", optionSecond: "The Great Sphinx of Giza", correctAnswer: 2),
        Question(questionText: "Which artist is known for his series of paintings depicting water lilies?", optionFirst: "Claude Monet", optionSecond: "Salvador Dalí", correctAnswer: 1),
        Question(questionText: "What is the name of the famous painting featuring a melting clock?", optionFirst: "The Persistence of Memory", optionSecond: "Guernica", correctAnswer: 1),
        Question(questionText: "Who sculpted the statue of David?", optionFirst: "Michelangelo", optionSecond: "Donatello", correctAnswer: 1),
        Question(questionText: "What is the name of the famous painting of a woman sitting in a café?", optionFirst: "Girl with a Pearl Earring", optionSecond: "Nighthawks", correctAnswer: 2),
        Question(questionText: "Who is the artist known for creating the Campbell's Soup Cans artwork?", optionFirst: "Andy Warhol", optionSecond: "Vincent van Gogh", correctAnswer: 1),
        Question(questionText: "What is the name of the famous painting featuring a melting watch?", optionFirst: "The Persistence of Memory", optionSecond: "The Starry Night", correctAnswer: 1),
        Question(questionText: "Which artist painted The Birth of Venus?", optionFirst: "Sandro Botticelli", optionSecond: "Rembrandt", correctAnswer: 1),
        Question(questionText: "What is the name of the famous sculpture depicting a man reaching out his hand?", optionFirst: "The Thinker", optionSecond: "The Creation of Adam", correctAnswer: 2),
        Question(questionText: "Who painted the famous artwork 'The Starry Night'?", optionFirst: "Vincent van Gogh", optionSecond: "Pablo Picasso", correctAnswer: 1),
       Question(questionText: "What is the name of the famous sculpture located in Rio de Janeiro, Brazil?", optionFirst: "The Statue of Liberty", optionSecond: "Christ the Redeemer", correctAnswer: 2),
       Question(questionText: "Which artist is known for creating the painting 'The Scream'?", optionFirst: "Edvard Munch", optionSecond: "Salvador Dalí", correctAnswer: 1),
       Question(questionText: "Who painted the ceiling of the Sistine Chapel?", optionFirst: "Leonardo da Vinci", optionSecond: "Michelangelo", correctAnswer: 2),
       Question(questionText: "What is the name of the famous painting that depicts a mysterious woman with a slight smile?", optionFirst: "Mona Lisa", optionSecond: "The Creation of Adam", correctAnswer: 1),
       Question(questionText: "Which artist is known for his works such as 'Les Demoiselles d'Avignon' and 'Guernica'?", optionFirst: "Pablo Picasso", optionSecond: "Claude Monet", correctAnswer: 1),
       Question(questionText: "Who created the sculpture 'The Thinker'?", optionFirst: "Auguste Rodin", optionSecond: "Donatello", correctAnswer: 1),
       Question(questionText: "What is the name of the famous painting that depicts a scene from Greek mythology with the goddess of love and beauty emerging from the sea?", optionFirst: "The Birth of Venus", optionSecond: "The Last Supper", correctAnswer: 1),
       Question(questionText: "Which artist is known for his works such as 'Les Nymphéas' (Water Lilies)?", optionFirst: "Claude Monet", optionSecond: "Jackson Pollock", correctAnswer: 1),
       Question(questionText: "Who painted the famous artwork 'Girl with a Pearl Earring'?", optionFirst: "Johannes Vermeer", optionSecond: "Rembrandt", correctAnswer: 1)
    ]

    let randomQuestions: [Question] = [
        Question(questionText: "What is the capital of France?", optionFirst: "Paris", optionSecond: "Rome", correctAnswer: 1),
        Question(questionText: "What is the name of the largest ocean in the world?", optionFirst: "The Atlantic Ocean", optionSecond: "The Pacific Ocean", correctAnswer: 2),
        Question(questionText: "What is the name of the tallest mountain in the world?", optionFirst: "Mount Everest", optionSecond: "K2", correctAnswer: 1),
        Question(questionText: "What is the name of the largest country in the world by area?", optionFirst: "Russia", optionSecond: "Canada", correctAnswer: 1),
        Question(questionText: "What is the name of the smallest country in the world by area?", optionFirst: "Vatican City", optionSecond: "Monaco", correctAnswer: 1),
        Question(questionText: "What is the name of the largest ocean in the world by volume?", optionFirst: "The Atlantic Ocean", optionSecond: "The Pacific Ocean", correctAnswer: 2),
        Question(questionText: "What is the currency of Japan?", optionFirst: "Yen", optionSecond: "Euro", correctAnswer: 1),
        Question(questionText: "What is the largest continent in the world?", optionFirst: "Asia", optionSecond: "Africa", correctAnswer: 1),
        Question(questionText: "What is the capital of Australia?", optionFirst: "Canberra", optionSecond: "Sydney", correctAnswer: 1),
        Question(questionText: "What is the largest planet in our solar system?", optionFirst: "Jupiter", optionSecond: "Saturn", correctAnswer: 1),
        Question(questionText: "What is the chemical symbol for the element gold?", optionFirst: "Au", optionSecond: "Ag", correctAnswer: 1),
        Question(questionText: "What is the largest species of shark?", optionFirst: "Great White Shark", optionSecond: "Whale Shark", correctAnswer: 2),
        Question(questionText: "What is the tallest mammal in the world?", optionFirst: "Elephant", optionSecond: "Giraffe", correctAnswer: 2),
        Question(questionText: "What is the capital of Brazil?", optionFirst: "Rio de Janeiro", optionSecond: "Brasília", correctAnswer: 2),
        Question(questionText: "What is the chemical symbol for the element oxygen?", optionFirst: "O", optionSecond: "Os", correctAnswer: 1),
        Question(questionText: "What is the largest moon in our solar system?", optionFirst: "Titan", optionSecond: "Ganymede", correctAnswer: 2),
        Question(questionText: "What is the name of the largest desert in the world?", optionFirst: "Sahara Desert", optionSecond: "Gobi Desert", correctAnswer: 1),
        Question(questionText: "What is the capital of China?", optionFirst: "Beijing", optionSecond: "Shanghai", correctAnswer: 1),
        Question(questionText: "What is the largest landlocked country in the world?", optionFirst: "Kazakhstan", optionSecond: "Mongolia", correctAnswer: 1),
        Question(questionText: "What is the chemical symbol for the element carbon?", optionFirst: "C", optionSecond: "Co", correctAnswer: 1),
        Question(questionText: "What is the largest bird in the world?", optionFirst: "Ostrich", optionSecond: "Emu", correctAnswer: 1)
    ]
    
    var presenter: AnyPresenter?
    
    func getQuestions(quizType: QuizType) -> [Question] {
        //get questions for presenter
        switch quizType {
            case .art:
                let shuffledQuestions = artQuestions.shuffled()
                let first10Questions = Array(shuffledQuestions.prefix(10))
                return first10Questions
            case .history:
                let shuffledQuestions = historyQuestions.shuffled()
                let first10Questions = Array(shuffledQuestions.prefix(10))
                return first10Questions
            default:
                let shuffledQuestions = randomQuestions.shuffled()
                let first10Questions = Array(shuffledQuestions.prefix(10))
                return first10Questions
        }
    }
}
