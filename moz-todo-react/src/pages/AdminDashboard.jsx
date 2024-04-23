import { useState } from 'react';
import TextBox from '../Components/TextBox'
import { getToken } from '../slices/tokenSlice';
import { useDispatch, useSelector } from 'react-redux';
import { formatToken, useGetAnswersQuery, useGetAssociatedUserGroupsQuery, useGetQuestionsQuery, useGetUsersQuery } from '../slices/apiSlice';
import NavBar from '../Components/NavBar';
import React from 'react';
import { setNextQuestion, setPreviousQuestion, setCurrentReason, addReason, addAnswer, /* other actions */ } from '../slices/adminDashboardSlice'; // Adjust path as needed

function AdminDashboard() {
  
  // Stores and array of question and answer
  const dispatch = useDispatch();
  const { questionsAndAnswers, currentQuestionIndex, currentReason, reasons, answers } = useSelector(
    (state) => state.adminDashboard
  );

  const handleNextQuestion = () => {
    dispatch(setNextQuestion()); // update state
  };

  const handlePreviousQuestion = () => {
    dispatch(setPreviousQuestion()); // update state
  };

  const addReasonForFlagging = (reasonText) => {
    setCurrentReason(reasonText);
  };

  

  const token = useSelector(getToken)
  const {data: answersData, isError, isFetching: isAnswersFetching, isLoading: isAnswersLoading,
     isSuccess: isAnswersSuccess, isUninitialized: isAnswersUninitialized} = useGetAnswersQuery({token: formatToken(token['payload']), answerId: 1})
     if (typeof token === 'undefined' || token === null ||  !('payload' in token)){
    return (<h1>Page not found</h1>)
  }
  else if(isAnswersFetching || isAnswersLoading){
    return (<h1>Loading...</h1>)
  }
  else{
    console.log(answersData)
    return (<>
      <div className="adminDashboardContainer">
        <NavBar/>
        <h1>Admin Dashboard</h1>
        <TextBox text="Question"/>
        <TextBox text="Answer"/>
        <div className="questionButtons">
            <button className="prevButton" onClick={handlePreviousQuestion} disabled={currentQuestionIndex === 0}>
              Previous 
            </button>
            <button className="nextButton" onClick={handleNextQuestion}>Next</button>
        </div>
        <p>{[currentQuestionIndex + 1]}/{[questionsAndAnswers.length]}</p>
        <h2>Reason For Flagging (Answer {currentQuestionIndex + 1})</h2>
        <TextBox addTask={addReasonForFlagging} value={currentReason}/>
      </div>

    </>)
  }
}

export default AdminDashboard
