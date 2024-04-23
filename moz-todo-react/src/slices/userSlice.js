import { createSlice } from '@reduxjs/toolkit'

const initialState = { 
  id: null,
  role: null,
  name: null,
  email: null
};


const userSlice = createSlice({
  name: 'user',
  initialState,
  reducers: {
    addUserId: (state, id) => {
      state.id = id
    },
    addRole: (state, role) => {
      state.role = role
    },
    addName: (state, name) => {
      state.name = name
    },
    addEmail: (state, email) => {
      state.email = email
    }
  }
})

export const { addUserId, addRole, addName, addEmail } = userSlice.actions

export const getUserId = (state) => ( typeof state.user !== "undefined" ? state.user.id : undefined)
export const getRole = (state) => ( typeof state.user !== "undefined" ? state.user.role : undefined)
export const getName = (state) => ( typeof state.user !== "undefined" ? state.user.name : undefined)
export const getEmail = (state) => ( typeof state.user !== "undefined" ? state.user.email : undefined)

export default userSlice.reducer