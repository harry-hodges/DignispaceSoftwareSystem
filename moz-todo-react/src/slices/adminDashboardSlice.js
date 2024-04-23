const initialState = {
    questionsAndAnswers: [
      { question: 'Question 1', answer: 'Answer 1' },
      { question: 'Question 2', answer: 'Answer 2' },
      { question: 'Question 3', answer: 'Answer 3' },
    ],
    currentQuestionIndex: 0,
    currentReason: '',
    reasons: [],
    answers: [],
  };
  

import { createSlice } from '@reduxjs/toolkit';

const adminDashboardSlice = createSlice({
  name: 'adminDashboard',
  initialState,
  reducers: {
    setNextQuestion: (state) => {
      state.currentQuestionIndex = Math.min(state.currentQuestionIndex + 1, state.questionsAndAnswers.length - 1);
      state.currentReason = ''; // Reset reason on next question
    },
    setPreviousQuestion: (state) => {
      state.currentQuestionIndex = Math.max(state.currentQuestionIndex - 1, 0);
    },
    setCurrentReason: (state, action) => {
      state.currentReason = action.payload;
    },
    addReason: (state, action) => {
      state.reasons.push(action.payload); // Add reason to reasons array
    },
    addAnswer: (state, action) => {
      state.answers.push(action.payload); // Add answer to answers array
    },
    //reducers for other actions
  },
});

export const { setNextQuestion, setPreviousQuestion, setCurrentReason, addReason, addAnswer, /* other actions */ } = adminDashboardSlice.actions;

export default adminDashboardSlice.reducer;


  