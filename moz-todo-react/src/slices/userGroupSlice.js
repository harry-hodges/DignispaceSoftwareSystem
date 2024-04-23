const initialState = {
    userGroup: [],
  };

import { createSlice } from '@reduxjs/toolkit';

const userGroupSlice = createSlice({
    name: 'userGroupList',
    initialState,
    reducers: {
      
    },
  });
  
  
  export default userGroupSlice.reducer;
