import { useState } from 'react';
import '../App.css'
import { formatCreateQuestion, formatToken, useCreateQuestionMutation } from '../slices/apiSlice';
import { apiCalledTrue } from '../slices/ManageQuestionsSlice';
import { useDispatch } from 'react-redux';

function CreateQuestion({ token, createQuestionFunction }) {
    const [title, setTitle] = useState("")
    const [content, setContent] = useState("")
    const [sensitivity, setSensitivity] = useState("")

    const dispatch = useDispatch()

    const titleBox = <label>Input Title: <input name="Title" onChange={e => setTitle(e.target.value)}/></label>
    const contentBox = <label>Input Content: <input name="Content" onChange={e => setContent(e.target.value)}/></label>
    const sensitivityBox = <label>Input Sensitivity: <input name="Sensitivity" onChange={e => setSensitivity(e.target.value)}/></label>

    function handleSubmit(){
        createQuestionFunction({token: formatToken(token['payload']), body: formatCreateQuestion(title, content, sensitivity)})

        console.log("API_TRUE")
        dispatch(apiCalledTrue())
    }

    return (
        <>
            {titleBox}
            {contentBox}
            {sensitivityBox}
            <button onClick={handleSubmit}>Create Question</button>
        </>
    );
}

export default CreateQuestion