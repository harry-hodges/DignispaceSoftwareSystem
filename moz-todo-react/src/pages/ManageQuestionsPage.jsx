import React, { useEffect, useState } from 'react';
import { getToken } from '../slices/tokenSlice';
import { useDispatch, useSelector } from 'react-redux';
import { formatToken, useCreateQuestionMutation, useDeleteQuestionMutation, useGetQuestionsQuery, useLazyGetQuestionsQuery } from '../slices/apiSlice';
import NavBar from '../Components/NavBar';
import TableComponent from '../Components/Table';
import CreateQuestion from '../Components/CreateQuestion';
import { apiCalledFalse, firstApiCalledTrue, getApiCalled, getFirstApiCalled, getInitTd, setInitialTd } from '../slices/ManageQuestionsSlice';
import { getRole } from '../slices/userSlice';
import { useNavigate } from 'react-router-dom';

function ManageQuestionsPage() {  
  // need to check the user role
  const role = useSelector(getRole)['payload']
  const navigate = useNavigate()

  if (role === "ROLE_PROFESSIONAL"){
    navigate("/manageQuestionsPageForProf")
  }

  const tr = ["Title", "Contents", "Sensitivity"]
  const [td, setTd] = useState([])
  const [questionId, setQuestionId] = useState('')
  const [update, setUpdate] = useState(0)

  const dispatch = useDispatch()

  const token = useSelector(getToken)
  const initTd = useSelector(getInitTd)['payload']
  const firstApiCall = useSelector(getFirstApiCalled)

  const [getQuestion, {data: questionData, isError, isSuccess, isLoading, isUninitialized, isFulfilled, status }] = useLazyGetQuestionsQuery()
  const [deleteQuestion, {status: deleteStatus}] = useDeleteQuestionMutation()
  const [createQuestion, {status: createStatus}] = useCreateQuestionMutation()

  
  useEffect(() => {
    getQuestion(formatToken(token['payload']))
  }, [createStatus, deleteStatus])

  

  useEffect(() => {
    console.log(questionData)
    if(typeof questionData !== 'undefined'){
      const newTd = questionData.map((data) => [data['id'], data['title'], data['contents'], data['sensitivity']])
      setTd(newTd)

      if (firstApiCall === false){
        console.log(status)
        console.log(questionData)
        dispatch(setInitialTd(newTd))
        dispatch(firstApiCalledTrue())
      }
    }

    
    
  }, [status, questionData])

  if (questionData === null) return <h1>No Data</h1>
  if (typeof token == 'undefined' || token == null || !('payload' in token)){
    return <h1>404 page not found</h1>
  }
  else if (isFulfilled || isLoading, isUninitialized){
    return <h1>Loading</h1>
  }
  else{
    return(
      <>
        <NavBar />
        <TableComponent tableCol={tr} tableRow={td} startIndex={1} setQuestionId={setQuestionId}/>

        <div>
          <h2>Filters</h2>
          <label>
            Input title filter: <input name="titleInput" onChange={e => titleSearchChanged(e.target.value)}/>
          </label>
          <label>
            Input content filter: <input name="contentInput" onChange={e => contentSearchChanged(e.target.value)}/>
          </label>
          <label>
            Input sensitivity filter:
            <input name="sensitivityInput" onChange={e => sensitivtyFilterChanged(e.target.value)}/>
          </label>
        </div>
        
        <h2>Add</h2>
        <CreateQuestion token={token} createQuestionFunction={createQuestion}/>
        <button onClick={handleDeleteQuestion}>Delete</button>
      </>
    )
    
  }

  function handleDeleteQuestion(){
    deleteQuestion({"token": formatToken(token['payload']), "questionId": questionId})
    console.log(update)
    setUpdate((previousValue) => previousValue + 1)
    console.log(update)
  }

  function titleSearchChanged(titleSearchval){
    let newTd = initTd.filter((item) => item[1].toLowerCase().includes(titleSearchval.toLowerCase()) ? item : null)
  
    if (titleSearchval === "" || titleSearchval.length === 0){
      newTd = initTd
    }

    const copy = [...newTd]
    setTd(copy)
  }

  function contentSearchChanged(contentSearchVal){
    let newTd = initTd.filter((item) => item[2].toLowerCase().includes(contentSearchVal.toLowerCase()) ? item : null)
  
    if (contentSearchVal === "" || contentSearchVal.length === 0){
      newTd = initTd
    }

    const copy = [...newTd]
    setTd(copy)
  }

  function sensitivtyFilterChanged(sensitivityValue){
    let newTd = initTd.filter((item) => item[3].toLowerCase().includes(sensitivityValue.toLowerCase()) ? item : null)

    if(sensitivityValue === "" || sensitivityValue.length === 0){
      newTd = initTd
    }

    const copy = [...newTd]
    setTd(copy)

  }

}

export default ManageQuestionsPage;
