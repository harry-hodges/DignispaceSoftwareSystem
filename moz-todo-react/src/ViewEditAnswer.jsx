import { useState } from 'react'
import './App.css'
import TextBox from './Components/TextBox'
import NavBar from './Componenets/NavBar'

function ViewEditAnswer() {
  const[questions, setQuestions] = useState([]);
  const [answers, setAnswers] = useState([]);


  const handleAddQuestion = (questionText) => {
    setQuestions((prevQuestions) => [... prevQuestions, questionText])
  }

  function addAnswer(answerText) {
    setAnswers((prevAnswers) => [...prevAnswers, answerText]);
  }

  return (
    <>
    <NavBar/>
      <h1>View and Edit Answer</h1>
      <TextBox text="Question" addTask={handleAddQuestion}/>
      <TextBox text="Answer" addTask = {addAnswer}/>
      <h2>Questions</h2>
      <ul>
        {questions.map((question, index) => (
          <li key={index}>{question}</li>
        ))}
      </ul>
      <h2>Answers:</h2>
      <ul>
        {answers.map((answer, index) => (
          <li key={index}>{answer}</li>
        ))}
      </ul>
    
    </>
  )
}

export default ViewEditAnswer
