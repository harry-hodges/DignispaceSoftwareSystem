import { createSlice } from '@reduxjs/toolkit'

const initialState = { 
  apiCalled: false,
  firstApiCall: false,
  initTd: []
 };


const manageQuestionsSlice = createSlice({
  name: 'manageQuestions',
  initialState,
  reducers: {
    apiCalledTrue: (state) => {
      state.apiCalled = true
    },
    apiCalledFalse: (state) => {
      state.apiCalled = false
    },
    firstApiCalledTrue: (state) => {
      state.apiCalled = true
    },
    setInitialTd: (state, val) => {
      state.initTd = val
    }
  }
})

export const { apiCalledTrue, apiCalledFalse, firstApiCalledTrue, setInitialTd } = manageQuestionsSlice.actions

export const getApiCalled = (state) => ( typeof state.manageQuestions !== "undefined" ? state.manageQuestions.apiCalled : undefined)
export const getFirstApiCalled = (state) => ( typeof state.manageQuestions !== "undefined" ? state.manageQuestions.firstApiCall : undefined)
export const getInitTd = (state) => ( typeof state.manageQuestions !== "undefined" ? state.manageQuestions.initTd : undefined)

export default manageQuestionsSlice.reducer