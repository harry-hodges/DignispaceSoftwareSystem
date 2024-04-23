import { useState } from 'react'
import '../App.css'
import Form from "./Form"

function TextBox(props) {
  const [inputValue, setInputValue] = useState("");

  const handleAddTask = () => {
    props.addTask(inputValue);
    setInputValue(""); // Clear the input after adding the task
  };
  return (
    <>
      <div className="textBox">
        <h2>{props.text}</h2>
        <Form className="textBoxForm" inputValue={inputValue} onInputChange={setInputValue} onAddTask={handleAddTask}/>
      </div>
    </>
  )
}

export default TextBox;
