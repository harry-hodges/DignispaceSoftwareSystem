import { createSlice } from '@reduxjs/toolkit'

const initialState = { token: null };


const tokenSlice = createSlice({
  name: 'token',
  initialState,
  reducers: {
    addToken: (state, token) => {
      state.token = token
    }
  }
})

export const { addToken } = tokenSlice.actions

export const getToken = (state) => ( typeof state.token !== "undefined" ? state.token.token : undefined)

export default tokenSlice.reducer