import React, { useEffect, useState } from 'react';
import { getToken } from '../slices/tokenSlice';
import { useDispatch, useSelector } from 'react-redux';
import { formatCreateAnswer, formatToken, useCreateAnswerMutation, useCreateQuestionMutation, useDeleteQuestionMutation, useGetAssociatedUserGroupsQuery, useGetQuestionsQuery, useLazyGetQuestionsQuery } from '../slices/apiSlice';
import NavBar from '../Components/NavBar';
import TableComponent from '../Components/Table';
import CreateQuestion from '../Components/CreateQuestion';
import { apiCalledFalse, firstApiCalledTrue, getApiCalled, getFirstApiCalled, getInitTd, setInitialTd } from '../slices/ManageQuestionsSlice';

function ManageQuestionsForProffesionalPage() {  
  // need to check the user role
  const tr = ["Title", "Contents", "Sensitivity"]
  const [td, setTd] = useState([])
  const [questionId, setQuestionId] = useState('')
  const [groupId, setGroupId] = useState('')


  const dispatch = useDispatch()

  const token = useSelector(getToken)
  const initTd = useSelector(getInitTd)['payload']
  const firstApiCall = useSelector(getFirstApiCalled)

  const [getQuestion, {data: questionData, isError, isSuccess, isLoading, isUninitialized, isFulfilled, status }] = useLazyGetQuestionsQuery()
  const {data: groupData} = useGetAssociatedUserGroupsQuery(formatToken(token['payload']))
  const [addQuestionToGroup] = useCreateAnswerMutation()
  useEffect(() => {
    getQuestion(formatToken(token['payload']))
  }, [])

  useEffect(() => {
    if(typeof questionData !== 'undefined'){
      const newTd = questionData.map((data) => [data['id'], data['title'], data['contents'], data['sensitivity']])
      setTd(newTd)

      if (firstApiCall === false){
        dispatch(setInitialTd(newTd))
        dispatch(firstApiCalledTrue())
      }
    }
  }, [status, questionData])



  if (questionData === null || groupData === null) return <h1>No Data</h1>
  if (typeof token == 'undefined' || token == null || !('payload' in token)){
    return <h1>404 page not found</h1>
  }
  else if (isFulfilled || isLoading, isUninitialized || !groupData){
    return <h1>Loading</h1>
  }
  else{
    const proffGroups = groupData.filter( (group) => group['role'] === "ROLE_PROFESSIONAL")
    const idNamePairs = proffGroups.map( (group) => [group['get_group']['id'], group['get_group']['name']])
    
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

        <div>
            <h2>Add Question to Group</h2>
            
            <select name="groups" onChange={e => handleBoxChange(e,idNamePairs)}>
                {idNamePairs.map((group, key) => {
                    return <option key={key} value={group[1]}>{group[1]}</option>;
                })}
            </select>
        
            <button onClick={(() => addQuestionToGroup({
                "token": formatToken(token['payload']),
                "body": formatCreateAnswer(questionId, groupId)
            }))}>Add question to group</button>
        </div>
      </>
    )
    
  }

  function handleBoxChange(e, idNamePairs){
    const group = idNamePairs.filter( (pair) => pair[1] === e.target.value)
    setGroupId(...group[0])
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

export default ManageQuestionsForProffesionalPage;
